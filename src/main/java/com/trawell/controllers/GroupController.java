package com.trawell.controllers;

import java.util.Set;

import javax.servlet.http.HttpSession;

import com.trawell.models.TrawellGroup;
import com.trawell.models.User;
import com.trawell.services.TrawellGroupService;
import com.trawell.services.UserService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

/**
 * GroupController: andranno mappate tutte le funzionalità relative ad i
 * controller
 * 
 * @author Umberto Russomando
 */

@Controller
@RequestMapping("group")
public class GroupController {
    @Autowired
    TrawellGroupService dao;

    @Autowired
    UserService daoUser;

    @GetMapping("/list-view")
    public String listView(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");

        if (user == null ? false : !user.getIsAdmin()) {

            user=daoUser.findOne(user.getId());

            Set<TrawellGroup> groups = null;

            groups = user.getUserGroups();

            model.addAttribute("itineraries", user.getUserItineraries());

            model.addAttribute("Groups", groups);

            return "pages/group/list-view";
        }
        return "redirect:/users/login";
    }

    @GetMapping("/view")
    public String view(HttpSession session, @RequestParam("id") Long id, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null ? false : !user.getIsAdmin()) {
            TrawellGroup group = dao.findOne(id);

            model.addAttribute("posts", group.getPosts());
            model.addAttribute("participants", group.getParticipants());
            model.addAttribute("group", group);
            return "pages/group/view-group";
        }
        return "redirect:/users/login";
    }
}
