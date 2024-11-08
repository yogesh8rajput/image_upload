/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import javax.swing.JOptionPane;
import static org.eclipse.jdt.internal.compiler.parser.Parser.name;

/**
 *
 * @author yoges
 */
@MultipartConfig
@WebServlet(urlPatterns = {"/image_upload"})
public class image_upload extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet image_upload</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet image_upload at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

   
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter pt = response.getWriter();
        String name = request.getParameter("categery");
        Part file = request.getPart("pic");
        String filename = file.getSubmittedFileName();
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3307/imageupload", "root", "1234");
            PreparedStatement pt2 = con.prepareStatement("insert into image (categary,image) values(?,?)");
//             PreparedStatement pt2=con.prepareStatement("insert into book (Book_name,Auther,Quantity,Price,image_id) values(?,?,?,?,?)");
            pt2.setString(1, name);
            pt2.setString(2, filename);
            String drive_path = "E:/Uploadfile/web/Upload_img/" + filename;
            FileOutputStream fos = new FileOutputStream(drive_path);
            InputStream is = file.getInputStream();
            byte[] imageData = new byte[is.available()];
            is.read(imageData);
            fos.write(imageData);
            int i = pt2.executeUpdate();

            if (i == 1) {
                String path = getServletContext().getRealPath("") + "Upload_img";
                file.write(path + File.separator + filename);
                JOptionPane.showMessageDialog(null, "Image upload successfully!");
                response.sendRedirect("index.html");
            }
        } catch (Exception e) {
            pt.print(e.getMessage());
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
