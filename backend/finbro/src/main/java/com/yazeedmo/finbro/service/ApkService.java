package com.yazeedmo.finbro.service;

import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.io.File;

@Service
public class ApkService {

    public File getLatestApk() {

        String filePath = "finbro.apk";

        return new File(filePath);

    }

}
