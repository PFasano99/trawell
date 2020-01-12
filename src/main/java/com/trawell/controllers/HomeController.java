package com.trawell.controllers;

import javax.servlet.http.HttpSession;

import com.trawell.services.CarsharingService;
import com.trawell.services.PostService;
import com.trawell.services.ItineraryService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
/**
 * Homecontroller: andranno mappate tutte le funzionalità relative ad i controller
 * @author Umberto Russomando
 */
import org.springframework.web.bind.annotation.RequestMapping;

 /**
  * @author Alfieri Davide
  */
@RequestMapping("/home")
@Controller
public class HomeController {
    @Autowired
    private CarsharingService daocarsharing;
    @Autowired
    private ItineraryService daoitinerary;
    @Autowired
    private PostService daopost;
    @GetMapping("/home-page")
    public String landing(HttpSession session, Model model) {
        if (session.getAttribute("user") != null) {

            model.addAttribute("carsharingAds", daocarsharing.findAll());
            model.addAttribute("itineraries", daoitinerary.findAll());
            model.addAttribute("posts", daopost.findAll());

            return "pages/home/index";
        }
        return "pages/home/index";
    }

    
}
