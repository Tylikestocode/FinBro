package com.yazeedmo.finbro.service;

import com.yazeedmo.finbro.domain.AdminEvent;
import com.yazeedmo.finbro.domain.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.event.EventListener;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.messaging.simp.stomp.StompHeaderAccessor;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.web.socket.messaging.SessionConnectEvent;
import org.springframework.web.socket.messaging.SessionDisconnectEvent;

import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.atomic.AtomicInteger;

@Service
public class WebSocketService {

    @Autowired
    private SimpMessagingTemplate messagingTemplate;

    // Keep track of sessions and their associated client types
    private final ConcurrentHashMap<String,String> sessionClientTypes = new ConcurrentHashMap<>();
    private final AtomicInteger mobileClientCount = new AtomicInteger();

    private final String ADMIN_TOPIC = "/topic/adminUpdates";

    // Event listener for client connections
    @EventListener
    public void handleWebSocketConnectListener(SessionConnectEvent event) {
        StompHeaderAccessor headerAccessor = StompHeaderAccessor.wrap(event.getMessage());

        // Get client type from headers
        String clientType = headerAccessor.getFirstNativeHeader("client-type");
        if ("mobile".equals(clientType)) {
            // Save session ID and client type
            String sessionId = headerAccessor.getSessionId();
            System.out.println("New Session ID: " + sessionId);
            if (sessionId != null) {
                sessionClientTypes.put(sessionId, clientType);
            }
            int currentCount = mobileClientCount.incrementAndGet();
            System.out.println("Mobile client connected. Total mobile clients: " + currentCount);

            sendMobileConnectedClientsCount();
        }
    }

    // Event listener for client disconnections
    @EventListener
    public void handleWebSocketDisconnectListener(SessionDisconnectEvent event) {
        StompHeaderAccessor headerAccessor = StompHeaderAccessor.wrap(event.getMessage());

        // Get session ID to look up client type
        String sessionId = headerAccessor.getSessionId();
        System.out.println("Deleting Session ID: " + sessionId);
        String clientType = null;
        if (sessionId != null) {
            clientType = sessionClientTypes.remove(sessionId);
        }

        if ("mobile".equals(clientType)) {
            int currentCount = mobileClientCount.decrementAndGet();
            System.out.println("Mobile client disconnected. Total mobile clients: " + currentCount);

            sendMobileConnectedClientsCount();
        }

    }

    public void sendMobileConnectedClientsCount() {
        int currentCount = mobileClientCount.get();
        AdminEvent adminEvent = new AdminEvent(AdminEvent.EventType.ONLINE_USER_COUNT, currentCount);
        messagingTemplate.convertAndSend(ADMIN_TOPIC, adminEvent);
    }

    public int getTotalOnlineUsers() {
        return mobileClientCount.get();
    }

    public void sendAdminUpdate(AdminEvent adminEvent) {
        messagingTemplate.convertAndSend(ADMIN_TOPIC, adminEvent);
    }

}
