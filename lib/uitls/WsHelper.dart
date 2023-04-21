// ignore_for_file: constant_identifier_names, file_names

import 'dart:async';
import 'dart:convert';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

/// WebSocket地址
const String _SOCKET_URL = 'ws://192.168.1.52:8081/im/';

/// WebSocket状态
enum SocketStatus {
  SocketStatusConnected, // 已连接
  SocketStatusFailed, // 失败
  SocketStatusClosed, // 连接关闭
}

class WsHelper {
  /// 内部构造方法，可避免外部暴露构造函数，进行实例化
  WsHelper._();

  /// 单例对象
  static final WsHelper _socket = WsHelper._();

  /// 获取单例内部方法
  // factory WebSocketUtility() {
  //   // 只能有一个实例
  //   _socket ??
  //   return _socket!;
  // }

  IOWebSocketChannel? _webSocket; // WebSocket
  SocketStatus _socketStatus = SocketStatus.SocketStatusClosed; // socket状态
  Timer? _heartBeat; // 心跳定时器
  final int _heartTimes = 3000; // 心跳间隔(毫秒)
  final num _reconnectCount = 60; // 重连次数，默认60次
  num _reconnectTimes = 0; // 重连计数器
  Timer? _reconnectTimer; // 重连定时器
  Function? onError; // 连接错误回调
  Function? onOpen; // 连接开启回调
  // Function? onMessage; // 接收消息回调
  static String _token = "";

  // final ObserverList<Function> _observerList = ObserverList();
  final Map<int, Function> typeFunList = {};

  /// 初始化WebSocket
  void initWebSocket({Function? onOpen, Function? onError}) {
    this.onOpen = onOpen;
    // this.onMessage = onMessage;
    this.onError = onError;
    openSocket();
  }

  static WsHelper getInstance() {
    return _socket;
  }

  //添加消息回调监听
  void addMsgCallBack(int type, Function onMessage) {
    // _observerList.add(onMessage);
    typeFunList[type] = onMessage;
  }

  /// 开启WebSocket连接
  void openSocket() {
    closeSocket();
    _webSocket = IOWebSocketChannel.connect(_SOCKET_URL + _token);
    print('WebSocket连接成功: $_SOCKET_URL');
    // 连接成功，返回WebSocket实例
    _socketStatus = SocketStatus.SocketStatusConnected;
    // 连接成功，重置重连计数器
    _reconnectTimes = 0;
    if (_reconnectTimer != null) {
      _reconnectTimer!.cancel();
      _reconnectTimer = null;
    }

    // 接收消息
    _webSocket?.stream.listen((data) => webSocketOnMessage(data),
        onError: webSocketOnError, onDone: webSocketOnDone);
  }

  void setToken(String userToken) {
    _token = userToken;
  }

  /// WebSocket接收消息回调
  webSocketOnMessage(json) {
    print("收到消息：" + json);

    Map<String, dynamic> data = jsonDecode(json);
    if (20 == data["status"]) {
      onOpen!();
    } else if (21 == data["status"]) {
      dynamic body = data["body"];
      var typeFunLists = typeFunList[body["type"]];
      if (null != typeFunLists) {
        typeFunLists(body);
      }
    }
  }

  /// WebSocket关闭连接回调
  webSocketOnDone() {
    print('closed');
    // reconnect();
  }

  /// WebSocket连接错误回调
  webSocketOnError(e) {
    WebSocketChannelException ex = e;
    _socketStatus = SocketStatus.SocketStatusFailed;
    onError!(ex.message);
    closeSocket();
  }

  /// 初始化心跳
  void initHeartBeat() {
    destroyHeartBeat();
    _heartBeat = Timer.periodic(Duration(milliseconds: _heartTimes), (timer) {
      sentHeart();
    });
  }

  /// 心跳
  void sentHeart() {
    sendMessage('{"module": "HEART_CHECK", "message": "请求心跳"}');
  }

  /// 销毁心跳
  void destroyHeartBeat() {
    if (_heartBeat != null) {
      _heartBeat?.cancel();
      _heartBeat = null;
    }
  }

  /// 关闭WebSocket
  void closeSocket() {
    if (_webSocket != null) {
      print('WebSocket连接关闭');
      _webSocket?.sink.close();
      destroyHeartBeat();
      _socketStatus = SocketStatus.SocketStatusClosed;
      typeFunList.clear();
    }
  }

  /// 发送WebSocket消息
  void sendMessage(message) {
    if (_webSocket != null) {
      switch (_socketStatus) {
        case SocketStatus.SocketStatusConnected:
          print('发送中：' + message);
          _webSocket?.sink.add(message);
          break;
        case SocketStatus.SocketStatusClosed:
          print('连接已关闭');
          break;
        case SocketStatus.SocketStatusFailed:
          print('发送失败');
          break;
        default:
          break;
      }
    }
  }

  /// 重连机制
  void reconnect() {
    if (_reconnectTimes < _reconnectCount) {
      _reconnectTimes++;
      _reconnectTimer =
          Timer.periodic(Duration(milliseconds: _heartTimes), (timer) {
        openSocket();
      });
    } else {
      if (_reconnectTimer != null) {
        print('重连次数超过最大次数');
        _reconnectTimer?.cancel();
        _reconnectTimer = null;
      }
      return;
    }
  }
}
