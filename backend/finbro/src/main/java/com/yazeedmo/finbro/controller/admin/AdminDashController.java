package com.yazeedmo.finbro.controller.admin;

import com.yazeedmo.finbro.service.WebSocketService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@Controller
@CrossOrigin(origins = "http://localhost")
public class AdminDashController {

    @Autowired
    private WebSocketService webSocketService;

    @GetMapping("/")
    public String showMainPage() {
        return "index";
    }

}
