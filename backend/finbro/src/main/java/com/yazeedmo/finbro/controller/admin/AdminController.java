package com.yazeedmo.finbro.controller.admin;

import com.yazeedmo.finbro.domain.AdminEvent;
import com.yazeedmo.finbro.domain.ApiResponse;
import com.yazeedmo.finbro.service.ApkService;
import com.yazeedmo.finbro.service.PdfService;
import com.yazeedmo.finbro.service.UserService;
import com.yazeedmo.finbro.service.WebSocketService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.io.File;
import java.io.IOException;

@RestController
@RequestMapping("/api/admin/")
@CrossOrigin(origins = "http://localhost")
public class AdminController {

    @Autowired
    private WebSocketService webSocketService;

    @Autowired
    private UserService userService;

    @Autowired
    private PdfService pdfService;

    @Autowired
    private ApkService apkService;

    @GetMapping("/online-users/count")
    public ResponseEntity<ApiResponse<AdminEvent>> getTotalUsersOnline() {

        int totalUsersOnline = webSocketService.getTotalOnlineUsers();

        AdminEvent adminEvent = new AdminEvent(AdminEvent.EventType.ONLINE_USER_COUNT, totalUsersOnline);
        ApiResponse<AdminEvent> apiResponse = new ApiResponse<>(true, adminEvent);

        return ResponseEntity
                .status(HttpStatus.OK)
                .body(apiResponse);

    }

    @GetMapping("/total-users/count")
    public ResponseEntity<ApiResponse<AdminEvent>> getTotalUsers() {

        long totalUsers = userService.getCountTotalUsers();

        AdminEvent adminEvent = new AdminEvent(AdminEvent.EventType.TOTAL_USER_COUNT, totalUsers);
        ApiResponse<AdminEvent> apiResponse = new ApiResponse<>(true, adminEvent);

        return ResponseEntity
                .status(HttpStatus.OK)
                .body(apiResponse);

    }

    @GetMapping("/download-pdf")
    public ResponseEntity<byte[]> downloadPdf() throws IOException {
        byte[] pdfBytes = pdfService.createPdf();

        HttpHeaders headers = new HttpHeaders();
        headers.add(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=stats.pdf");
        headers.add(HttpHeaders.CONTENT_TYPE, "application/pdf");

        return ResponseEntity.ok()
                .headers(headers)
                .body(pdfBytes);
    }

    @GetMapping("/download-apk")
    public ResponseEntity<Resource> downloadApk() {
        File apkFile = apkService.getLatestApk();

        if (!apkFile.exists()) {
            System.out.println("APK does not exist");
            return ResponseEntity.notFound().build();
        }

        System.out.println("Trying to download APK");

        Resource resource = new FileSystemResource(apkFile);

        // Ensure Content-Length header is set
        long fileLength = apkFile.length();

        HttpHeaders headers = new HttpHeaders();
        headers.add(HttpHeaders.CONTENT_TYPE, "application/vnd.android.package-archive");
        headers.add(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=" + apkFile.getName());
        headers.add(HttpHeaders.CONTENT_LENGTH, String.valueOf(fileLength));

        System.out.println(fileLength);

        return ResponseEntity.ok()
                .headers(headers)
                .body(resource);
    }


}
