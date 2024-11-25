class WebSocketAPI {
    constructor() {
        this.socket = null;
        this.stompClient = null;
        this.url = window.location.hostname === 'localhost'
            ? 'http://localhost:8081'
            : 'https://finbro.yazeedmo.com';
        this.eventHandlers = {};
    }

    // Initialize the WebSocket connection
    initialize() {
        // Create WebSocket connection
        this.socket = new SockJS(`${this.url}/ws`);
        // Wrap WebSocket connection with Stomp
        this.stompClient = Stomp.over(this.socket);

        // Establish connection
        this.stompClient.connect({}, this.onConnected.bind(this), this.onError.bind(this));
    }

    // Callback for successful connection
    onConnected(frame) {
        console.log('Connected: ' + frame);

        // Subscribe to the adminUpdates topic
        this.stompClient.subscribe('/topic/adminUpdates', this.onMessageReceived.bind(this));
    }

    // Handle messages from the WebSocket connection
    onMessageReceived(message) {
        const event = JSON.parse(message.body);
        const eventType = event.eventType;
        console.log(eventType);

        // Check if there is a handler for the event type
        if (this.eventHandlers[eventType]) {
            // Call the handler for this event type
            this.eventHandlers[eventType](event.data);
        } else {
            console.log('No handler found for event type:', eventType);
        }
    }

    // Callback for connection errors
    onError(error) {
        console.error('Connection error: ' + error);
    }

    // Method to register event handlers
    registerEventHandler(eventType, handler) {
        this.eventHandlers[eventType] = handler;
    }

    // Method to connect to a specific topic (if needed, though it's already done in onConnected)
    connectToTopic(topic) {
        this.stompClient.subscribe(topic, this.onMessageReceived.bind(this));
    }
}

export default WebSocketAPI;