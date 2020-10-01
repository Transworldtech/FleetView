package com.einnovates.controllers;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.SimpleFormController;

public abstract class BaseController extends SimpleFormController {
   protected String viewName = null;

   public ModelAndView handleRequest(HttpServletRequest req, HttpServletResponse res) {
      return execute(req, res);
   }

   public abstract ModelAndView execute(HttpServletRequest req, HttpServletResponse res);
}