package com.einnovates.controllers;

import com.einnovates.customtags.tree.TreeNode;
import java.io.PrintStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.servlet.ModelAndView;

public class TreePageController extends BaseController
{
  protected final Log logger = LogFactory.getLog(getClass());
  static Connection conn = null;
  static Connection conn1 = null;
  static Statement st = null; static Statement st1 = null; static Statement st2 = null; static Statement st3 = null; static Statement st4 = null; static Statement st5 = null;
  static String todaysDate = null; static String todaysdate1 = null;
  public static String username = "";

  public static void GetConnection()
  {
    try
    {
      Class.forName("org.gjt.mm.mysql.Driver");
      conn = DriverManager.getConnection("jdbc:mysql://localhost/db_gps", "fleetview", "1@flv");
      conn1 = DriverManager.getConnection("jdbc:mysql://localhost/db_gps", "fleetview", "1@flv");

      st = conn.createStatement();
      st1 = conn1.createStatement();
      st2 = conn1.createStatement();
      st3 = conn1.createStatement();
      st4 = conn1.createStatement();
      st5 = conn.createStatement();
      System.out.println("In Open Connection");
    }
    catch (Exception e) {
      System.out.print("GetConnection Exception ---->" + e);

      GetConnection();
    }
  }

  public static void CloseConnection() {
    try {
      st.close();
      conn.close();
      System.out.println("In Close Connection");
    }
    catch (Exception localException)
    {
    }
  }

  public void setViewName(String viewName)
  {
    this.viewName = viewName;
  }
  public String getViewName() {
    return this.viewName;
  }

  public void setusername(String username)
  {
    System.out.println("****   " + username);
    username = username;
  }

  public String getusername() {
    return username;
  }

  public ModelAndView execute(HttpServletRequest req, HttpServletResponse res)
  {
    GetConnection();
    if (this.logger.isDebugEnabled()) {
      this.logger.debug("execute method called");
    }

    this.logger.info("Returning DeviceTree Controller");
    HttpSession session = req.getSession(true);
    ModelAndView mv = new ModelAndView(getViewName());

    String username1 = "";
    username1 = session.getAttribute("user").toString();
    System.out.println("username1 ************************************************************************:->  " + username1);
    String firstname = ""; String HODID = "";
    String sql4 = "select * from db_gps.t_userdetails where username = '" + username1 + "'";
    try
    {
      ResultSet rs4 = st4.executeQuery(sql4);
      if (rs4.next())
      {
        firstname = rs4.getString("FirstName") + " " + rs4.getString("LastName");
        HODID = rs4.getString("SrNo");
      }

      
      if ((username1 == "Kishore.Kumar@se1.bp.com") || (username1.equals("Kishore.Kumar@se1.bp.com")) || (username1 == "sanjay.jetly@se1.bp.com") || (username1.equals("sanjay.jetly@se1.bp.com")) || (username1 == "Kishore.Kumar1@se1.bp.com") || (username1.equals("Kishore.Kumar1@se1.bp.com")))
      {
        HODID = "11317";
      }

      TreeNode treeData = new TreeNode(firstname, "Unknown");

      String sql = "select * from db_gps.t_userdetails where HODID = '" + HODID + "' ";

      ResultSet rs = st.executeQuery(sql);
      while (rs.next())
      {
        String var = rs.getString("FirstName") + " " + rs.getString("LastName");
        TreeNode temp = new TreeNode(var);
        String sql1 = "Select * from db_gps.t_userdetails where HODID = '" + rs.getString("SrNo") + "'";
        ResultSet rs1 = st1.executeQuery(sql1);
        while (rs1.next())
        {
          var = rs1.getString("FirstName") + " " + rs1.getString("LastName");
          TreeNode temp1 = new TreeNode(var);
          String sql2 = "Select * from db_gps.t_userdetails where HODID = '" + rs1.getString("SrNo") + "'";
          ResultSet rs2 = st2.executeQuery(sql2);
          while (rs2.next())
          {
            var = rs2.getString("FirstName") + " " + rs2.getString("LastName");
            TreeNode temp2 = new TreeNode(var);
            String sql3 = "Select * from db_gps.t_userdetails where HODID = '" + rs2.getString("SrNo") + "'";
            ResultSet rs3 = st3.executeQuery(sql3);
            while (rs3.next())
            {
              var = rs3.getString("FirstName") + " " + rs3.getString("LastName");
              temp2.add(new TreeNode(var));
            }
            temp1.add(temp2);
          }
          temp.add(temp1);
        }
        treeData.add(temp);
      }

      mv.addObject("deviceTreeData", treeData);
    }
    catch (SQLException e)
    {
      e.printStackTrace();
    }
    return mv;
  }
}