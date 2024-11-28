package com.yazeedmo.finbro.util;

import com.yazeedmo.finbro.domain.AdminEvent;
import com.yazeedmo.finbro.service.WebSocketService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class AdminEventHelper {

    @Autowired
    private final WebSocketService webSocketService;

    public AdminEventHelper(
            WebSocketService webSocketService
    ) {
        this.webSocketService = webSocketService;
    }

    public void sendAllUpdates() {

        for (AdminEvent.EventType eventType : AdminEvent.EventType.values()) {
            AdminEvent adminEvent = new AdminEvent(eventType);
            this.webSocketService.sendAdminUpdate(adminEvent);
        }

    }

}
