package com.yazeedmo.finbro.controller.websocket;

import com.yazeedmo.finbro.service.WebSocketService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.stereotype.Controller;

@Controller
public class WebSocketController {

    @Autowired
    WebSocketService webSocketTestService;

//    @MessageMapping("/sendMessage")
//    public void handleSendMessage(String message) {
//        System.out.println("Received message from client: " + message);
//        webSocketTestService.publicMessage(message);
//    }

}
