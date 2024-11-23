import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:stomp_dart_client/stomp_dart_client.dart';

class WebsocketExample extends StatefulWidget {
  const WebsocketExample({super.key});

  @override
  State<WebsocketExample> createState() => _WebsocketExampleState();
}

class _WebsocketExampleState extends State<WebsocketExample> {

  StompClient? stompClient;
  String receivedMessage = "No messages yet";
  Map<String, dynamic>? receivedUser;

  @override
  void initState() {
    super.initState();
    connectToWebSocket();
  }

  void connectToWebSocket() {
    stompClient = StompClient(
      config: StompConfig.sockJS(
        url: 'http://192.168.8.46:8081/ws', // Replace with your backend URL
        onConnect: onConnect,
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

    stompClient?.activate();
  }

  void onConnect(StompFrame frame) {
    print('Connected to WebSocket!');

  }

  void sendMessageToServer(String message) {
    stompClient?.send(
      destination: '/app/sendMessage',
      body: message,
    );
  }

  @override
  void dispose() {
    stompClient?.deactivate();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WebSocket Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Received Message:',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(
              receivedMessage,
              style: const TextStyle(fontSize: 16, color: Colors.blue),
            ),
            const SizedBox(height: 20),
            if (receivedUser != null)
              Text(
                'Received User: ${receivedUser!['username']}',
                style: const TextStyle(fontSize: 16, color: Colors.green),
              ),
            const SizedBox(height: 40),
            TextField(
              onSubmitted: (value) {
                sendMessageToServer(value);
              },
              decoration: const InputDecoration(
                labelText: 'Send a message',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
