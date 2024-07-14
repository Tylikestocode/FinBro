package com.finbro.FinBroJavaSpring.controller;

import com.finbro.FinBroJavaSpring.domain.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ViewController {

    private UserController userController;

    public ViewController(UserController userController) {
        this.userController = userController;
    }

    @RequestMapping("/home")
    public String home(Model page) {
        page.addAttribute("heading", "Heading one");
        return "index.html";
    }
}
