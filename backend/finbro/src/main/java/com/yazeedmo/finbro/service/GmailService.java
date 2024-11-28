package com.yazeedmo.finbro.service;

import com.google.api.client.auth.oauth2.Credential;
import com.google.api.client.extensions.java6.auth.oauth2.AuthorizationCodeInstalledApp;
import com.google.api.client.extensions.jetty.auth.oauth2.LocalServerReceiver;
import com.google.api.client.googleapis.auth.oauth2.GoogleAuthorizationCodeFlow;
import com.google.api.client.googleapis.auth.oauth2.GoogleClientSecrets;
import com.google.api.client.googleapis.javanet.GoogleNetHttpTransport;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.client.json.JsonFactory;
import com.google.api.client.json.gson.GsonFactory;
import com.google.api.client.util.store.FileDataStoreFactory;
import com.google.api.services.gmail.Gmail;
import com.google.api.services.gmail.GmailScopes;
import jakarta.mail.Message;
import jakarta.mail.Session;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import org.springframework.stereotype.Service;

import java.io.*;
import java.util.*;

@Service
public class GmailService {

    // Application name
    private static final String APPLICATION_NAME = "FinBro";

    // Global instance of the JSON factory
    private static final JsonFactory JSON_FACTORY = GsonFactory.getDefaultInstance();

    // Directory to store authorization tokens for this application
    private static final String TOKENS_DIRECTORY_PATH = "gmail_tokens";

    // Global instance of the scopes required by this application
    // If modifying these scopes, delete previously saved tokens/folder
    private static final Set<String> SCOPES = Collections.singleton(GmailScopes.GMAIL_SEND);
    private static final String CREDENTIALS_FILE_PATH = "gmail_credential.json";

    // Creates and authorized Credential object
    // HTTP_TRANSPORT - The network HTTP Transport
    // Return - An authorized Credential object
    // Throws = IOException is the credentials.json file cannot be found
    private static Credential getCredentials(final NetHttpTransport HTTP_TRANSPORT) throws IOException {

        // Load client secrets
        InputStream in = new FileInputStream(new File(CREDENTIALS_FILE_PATH));
        GoogleClientSecrets clientSecrets = GoogleClientSecrets.load(JSON_FACTORY, new InputStreamReader(in));

        //Build flow and trigger user authorization request
        GoogleAuthorizationCodeFlow flow = new GoogleAuthorizationCodeFlow.Builder(
                HTTP_TRANSPORT, JSON_FACTORY, clientSecrets, SCOPES)
                .setDataStoreFactory(new FileDataStoreFactory(new java.io.File(TOKENS_DIRECTORY_PATH)))
                .setAccessType("offline")
                .build();
        LocalServerReceiver receiver = new LocalServerReceiver.Builder().setPort(8888).build();
        return new AuthorizationCodeInstalledApp(flow, receiver).authorize("user");

    }

    private static MimeMessage createEmail(String to, String from, String subject, String bodyText) throws Exception {
        Properties props = new Properties();
        Session session = Session.getDefaultInstance(props, null);

        MimeMessage email = new MimeMessage(session);
        email.setFrom(new InternetAddress(from));
        email.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
        email.setSubject(subject);
        email.setText(bodyText);
        return email;
    }

    private static void sendEmail(Gmail service, String userId, String to, String subject, String bodyText) throws Exception {

        MimeMessage email = createEmail(to, "finbro2024@gmail.com", subject, bodyText);

        ByteArrayOutputStream buffer = new ByteArrayOutputStream();
        email.writeTo(buffer);
        byte[] rawMessageBytes = Base64.getEncoder().encode(buffer.toByteArray());
        String encodedEmail = new String(rawMessageBytes);

        com.google.api.services.gmail.model.Message message = new com.google.api.services.gmail.model.Message();
        message.setRaw(encodedEmail);

        service.users().messages().send(userId, message).execute();

    }

    public void sendWelcomeEmail(String recipient) throws Exception {

        // Build a new authorized API client service
        final NetHttpTransport HTTP_TRANSPORT = GoogleNetHttpTransport.newTrustedTransport();
        Gmail service = new Gmail.Builder(HTTP_TRANSPORT, JSON_FACTORY, getCredentials(HTTP_TRANSPORT))
                .setApplicationName(APPLICATION_NAME)
                .build();

        // Email details
        String subject = "Welcome to FinBro";
        String bodyText = "Thank you for joining FinBro. We're excited to have you on board!";

        sendEmail(service, "me", recipient, subject, bodyText);

    }

}

