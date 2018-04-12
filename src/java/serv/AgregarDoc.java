/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package serv;

import Doctor.cDoctor;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Sonia
 */
public class AgregarDoc extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try (PrintWriter out = response.getWriter()) {
            HttpSession ses = request.getSession();
            int Sta=0,End=0;
            cDoctor doc = new cDoctor();
            String nombre = request.getParameter("nombreD");
            String usuario = request.getParameter("nusuario");
            String contraseña = request.getParameter("ncontra");
            String contraseña2 = request.getParameter("ncontra2");
            String genero = request.getParameter("generoDoc");
            String[] dias = request.getParameterValues("dias");
            String[] permisos = request.getParameterValues("permisos");
            String mail = request.getParameter("correo");
            String Turno = request.getParameter("Turno");
            String TypeDoc = request.getParameter("TypeDoc");
            String celular = request.getParameter("celular");
            if(!usuario.equals("")){
                if(contraseña.equals(contraseña2)){
                    if(Turno.equals("MAT")){
                        Sta=8; End=14;
                    }else{
                        Sta=14; End=20;
                    }
                    String msj = doc.insertaDoctor(nombre, contraseña, usuario,dias,Sta,End,TypeDoc,genero, mail,celular,permisos);
                    out.println("<html>");
                    out.println("<script>location.href = 'consultarDoc.jsp' ;</script>");
                    out.println("</html>");
                }else{
                    out.println("<html>");
                    out.println("<script>alert('Las contraseñas no coinciden');</script>");
                    out.println("</html>");
                }
            }else{
                out.println("<html>");
                out.println("<script>alert('Faltan Datos');</script>");
                out.println("</html>");
            }
        }

    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**


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
