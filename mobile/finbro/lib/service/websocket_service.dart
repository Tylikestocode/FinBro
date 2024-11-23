import 'package:stomp_dart_client/stomp_dart_client.dart';

class WebSocketService {
  static final WebSocketService _instance = WebSocketService._internal();

  factory WebSocketService() {
    return _instance;
  }

  WebSocketService._internal();

  StompClient? _stompClient;

  void connectToWebSocket() {
    if (_stompClient != null && _stompClient!.connected) {
      print('Already connected to WebSocket');
      return;
    }

    _stompClient = StompClient(
      config: StompConfig.sockJS(
        url: 'https://finbro.yazeedmo.com/ws',
        onConnect: _onConnect,
        stompConnectHeaders: {
          'client-type': 'mobile',
        },
        onWebSocketError: (dynamic error) {
          print('WebSocket Error: $error');
        },
        onStompError: (StompFrame frame) {
          print('STOMP Error: ${frame.body}');
        },
        onDisconnect: (frame) => print('Disconnected from WebSocket'),
        onDebugMessage: (message) => print('Debug: $message'),
      ),
    );

    _stompClient!.activate();
  }

  void disconnectFromWebSocket() {
    if (_stompClient != null && _stompClient!.connected) {
      _stompClient!.deactivate();
      _stompClient = null;
      print('WebSocket connection closed');
    }
  }

  void _onConnect(StompFrame frame) {
    print('Connected to WebSocket!');
  }
}
