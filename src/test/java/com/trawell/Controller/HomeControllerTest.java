package com.trawell.Controller;

import static org.junit.Assert.assertEquals;
import static org.mockito.Mockito.when;

import com.trawell.models.*;
import com.trawell.services.*;
import com.trawell.controllers.*;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.MockitoJUnitRunner;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.mock.web.MockHttpSession;

import org.springframework.test.web.servlet.MockMvc;

import org.springframework.ui.Model;



import java.sql.Date;
import java.util.ArrayList;



/**
 * @author Paolo Fasano
 */
@RunWith(MockitoJUnitRunner.class)
public class HomeControllerTest {


    @Mock
    private CarsharingService daocarsharing;
    @Mock
    private ItineraryService daoitinerary;
    @Mock
    private PostService daopost;
    @Mock
    private AdService daoad;

    ArrayList<Carsharing> amodello = new ArrayList<Carsharing>();
    TrawellGroup modello = new TrawellGroup();

    @InjectMocks
    HomeController controller = new HomeController();

    @Mock
    Model model;

    User instance = new User();

    MockHttpSession session = new MockHttpSession();

    @Autowired
    private MockMvc mvc;

    @Before
    public void setup() {

        System.out.println("Before");
        instance.setName("Name");
        instance.setBirth(new Date(0, 0, 0));
        instance.setBanned(false);
        instance.setPhone("Phone");
        instance.setIsAdmin(false);
        instance.setIsBanned(false);
        instance.setMail("Mail");
        instance.setSurname("Surname");
        instance.setUsername("Username");
        instance.setPassword("Password");
        instance.setId(0L);

        session.setAttribute("user", instance);

       
    }

    @After
    public void after() {
        System.out.println("After");
    }

    @Test
    public void TestlistLandingNoUser() {
        session.setAttribute("user", null);
        assertEquals("pages/user/login", controller.landing(session, model));
    }
   
    @Test
    public void TestlistLanding() {
        when(daocarsharing.findAll()).thenReturn(amodello);
        assertEquals("pages/home/index", controller.landing(session, model));
    }

    /*
    public String landing(HttpSession session, Model model) {
        if (session.getAttribute("user") != null) {

            model.addAttribute("carsharingAds", daocarsharing.findAll());
            model.addAttribute("itineraries", daoitinerary.findAll());
            model.addAttribute("posts", daopost.findAll());
            model.addAttribute("ads",daoad.findAll());

            return "pages/home/index";
        }
        return "pages/user/login";
    }
    */
        
}