package com.yazeedmo.finbro.domain;

public class AdminEvent {

    public enum EventType {
        TOTAL_USER_COUNT,
        ONLINE_USER_COUNT,
        USERS_UPDATED,
        CATEGORIES_UPDATED,
        ACCOUNTS_UPDATED,
        TRANSACTIONS_UPDATED,
        REGULAR_PAYMENTS_UPDATED,
    }

    private EventType eventType;
    private Object data;

    public AdminEvent(EventType eventType, Object data) {
        this.eventType = eventType;
        this.data = data;
    }

    public AdminEvent(EventType eventType) {
        this.eventType = eventType;
        this.data = null;
    }

    public EventType getEventType() {
        return eventType;
    }

    public void setEventType(EventType eventType) {
        this.eventType = eventType;
    }

    public Object getData() {
        return data;
    }

    public void setData(Object data) {
        this.data = data;
    }

    @Override
    public String toString() {
        return "AdminEvent{" +
                "eventType=" + eventType +
                ", data=" + data +
                '}';
    }

}
