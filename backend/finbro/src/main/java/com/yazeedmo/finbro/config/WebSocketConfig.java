package com.yazeedmo.finbro.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.messaging.simp.config.MessageBrokerRegistry;
import org.springframework.web.socket.config.annotation.EnableWebSocketMessageBroker;
import org.springframework.web.socket.config.annotation.StompEndpointRegistry;
import org.springframework.web.socket.config.annotation.WebSocketMessageBrokerConfigurer;

@Configuration
@EnableWebSocketMessageBroker
public class WebSocketConfig implements WebSocketMessageBrokerConfigurer {

    @Override
    public void configureMessageBroker(MessageBrokerRegistry registry) {

        // Enables a simple in-memory message broker for topics
        // (server to client)
        registry.enableSimpleBroker("/topic");

        // Prefix for messages that should be routed to @MessageMapping methods
        // (client to server)
        registry.setApplicationDestinationPrefixes("/app");

    }

    @Override
    public void registerStompEndpoints(StompEndpointRegistry registry) {
        // Allow CORS for WebSocket endpoint
        registry.addEndpoint("/ws")
                .setAllowedOrigins("http://localhost", "https://finbro.yazeedmo.com") // Add allowed origins here
                .withSockJS(); // Enable SockJS fallback
    }
}
