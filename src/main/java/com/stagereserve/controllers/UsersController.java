package com.stagereserve.controllers;

import com.stagereserve.forms.UserForm;
import com.stagereserve.models.User;
import com.stagereserve.services.UserService;
import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.io.File;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.List;
import java.util.logging.Logger;

@Controller
public class UsersController {

    private static final Logger logger = Logger.getLogger(UsersController.class.getName());
    private final String STATIC_FOLDER_PATH = "WEB-INF/resources/images/users/";
    private final String SYM_FOLDER_PATH = "/resources/images/users/";

    @Autowired
    private UserService userService;

    @Autowired
    private ServletContext context;

    // This method creates the users page view, accessible by users with the appropriate right.
    @GetMapping(value="/users")
    public ModelAndView getUsers(HttpServletRequest request) {
        try {
            // Session existence check.
            User user = (User) request.getSession().getAttribute("user");
            if (user == null) {
                return new ModelAndView("redirect:/");
            }
            // User right check.
            if (!user.getUsers()) {
                return new ModelAndView("redirect:/notFound");
            }
            // View creation.
            List<User> users = userService.findAll();
            ModelAndView mav = new ModelAndView("users");
            mav.addObject("user", user);
            mav.addObject("users", users);
            mav.addObject("userForm", new UserForm());
            return mav;
        } catch (Exception e) {
            logger.info("Exception: " + e.getMessage());
            return new ModelAndView("redirect:/error");
        }
    }

    // This method enables users with appropriate right to create a new user.
    @PostMapping(value="/users")
    public ModelAndView addUser(HttpServletRequest request, @Valid @ModelAttribute UserForm userForm) {
        try {
            // Session existence check.
            User sessionUser = (User) request.getSession().getAttribute("user");
            if (sessionUser == null) {
                return new ModelAndView("redirect:/");
            }
            // User right check.
            if (!sessionUser.getUsers()) {
                return new ModelAndView("redirect:/notFound");
            }
            // User creation.
            User user = new User();
            user.setEmail(userForm.getEmail());
            user.setPassword(userForm.getPassword());
            user.setName(userForm.getName());
            user.setSurname(userForm.getSurname());
            user.setPhone(userForm.getPhone());
            user.setManagement(false);
            user.setUsers(false);
            user = userService.save(user);
            // User profile static image creation.
            user.setImage(SYM_FOLDER_PATH + user.getId() + File.separator + userForm.getFile().getOriginalFilename());
            String userFolderPath = context.getRealPath(STATIC_FOLDER_PATH) + user.getId();
            File userFolder = new File(userFolderPath);
            if (userFolder.exists()) {
                FileUtils.forceDelete(userFolder);
            }
            Files.createDirectories(Paths.get(userFolderPath));
            userFolderPath += File.separator;
            userForm.getFile().transferTo(new File(userFolderPath + userForm.getFile().getOriginalFilename()));
            userService.save(user);
            return new ModelAndView("redirect:/users");
        } catch (Exception e) {
            logger.info("Exception: " + e.getMessage());
            return new ModelAndView("redirect:/error");
        }
    }

    // This method enables users with appropriate right to edit the information of a user.
    @PostMapping(value="/users/{id}")
    public ModelAndView editUser(HttpServletRequest request, @PathVariable Integer id, @Valid @ModelAttribute UserForm userForm) {
        try {
            // Session existence check.
            User sessionUser = (User) request.getSession().getAttribute("user");
            if (sessionUser == null) {
                return new ModelAndView("redirect:/");
            }
            // User right check.
            if (!sessionUser.getUsers()) {
                return new ModelAndView("redirect:/notFound");
            }
            // User existence check.
            User user = userService.findUserById(id);
            if (user == null) {
                return new ModelAndView("redirect:/notFound");
            }
            // Edit execution.
            user.setPassword(userForm.getPassword());
            user.setName(userForm.getName());
            user.setSurname(userForm.getSurname());
            user.setPhone(userForm.getPhone());
            user.setManagement((userForm.getManagement() != null) ? userForm.getManagement() : false);
            user.setUsers((userForm.getUsers() != null) ? userForm.getUsers() : false);
            if (userForm.getFile() != null && !userForm.getFile().isEmpty()) {
                // User profile static image update.
                user.setImage(SYM_FOLDER_PATH + user.getId() + File.separator + userForm.getFile().getOriginalFilename());
                String userFolderPath = context.getRealPath(STATIC_FOLDER_PATH) + user.getId();
                File userFolder = new File(userFolderPath);
                if (userFolder.exists()) {
                    FileUtils.forceDelete(userFolder);
                }
                Files.createDirectories(Paths.get(userFolderPath));
                userFolderPath += File.separator;
                userForm.getFile().transferTo(new File(userFolderPath + userForm.getFile().getOriginalFilename()));
            }
            userService.save(user);
            if (user.getId().equals(sessionUser.getId())) {
                request.getSession().setAttribute("user", user);
            }
            return new ModelAndView("redirect:/users");
        } catch (Exception e) {
            logger.info("Exception: " + e.getMessage());
            return new ModelAndView("redirect:/error");
        }
    }

    // This method enables users with appropriate right to delete a user.
    @PostMapping(value="/users/delete/{id}")
    public ModelAndView deleteUser(HttpServletRequest request, @PathVariable Integer id) {
        try {
            // Session existence check.
            User sessionUser = (User) request.getSession().getAttribute("user");
            if (sessionUser == null) {
                return new ModelAndView("redirect:/");
            }
            // User right check.
            if (!sessionUser.getUsers()) {
                return new ModelAndView("redirect:/notFound");
            }
            // User existence check.
            User user = userService.findUserById(id);
            if (user == null) {
                return new ModelAndView("redirect:/notFound");
            }
            // Delete execution.
            File file = new File(context.getRealPath(STATIC_FOLDER_PATH) + user.getId());
            if (file.exists()) {
                FileUtils.forceDelete(file);
            }
            userService.delete(user);
            if (sessionUser.getId().equals(user.getId())) {
                return new ModelAndView("redirect:/logout");
            }
            return new ModelAndView("redirect:/users");
        } catch (Exception e) {
            logger.info("Exception: " + e.getMessage());
            return new ModelAndView("redirect:/error");
        }
    }

}
