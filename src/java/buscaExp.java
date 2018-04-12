/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import serv.cPacientes;

/**
 *
 * @author Touchier
 */
@WebServlet(urlPatterns = {"/buscaExp"})
public class buscaExp extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String val= (String)request.getParameter("pedidoExp");
        if(true){
            String nss= request.getParameter("nss");
            
            cPacientes objPaciente= new cPacientes();
            String[] infoPaci= objPaciente.buscaPaciente(nss);
            if(infoPaci[0].length() == 0){ response.sendRedirect("consultaExp.jsp?a=E"); };
            
            String[][] consultasPaci= objPaciente.consultasDeUnPaciente(nss);
            String[] tratamiento= objPaciente.ultimoTratamiento(nss);
            
            response.setContentType("text/html;charset=UTF-8");

            try (PrintWriter out = response.getWriter()) {
                /* TODO output your page here. You may use following sample code. */
                out.println("<!DOCTYPE html>");
                out.println("<html>");
                out.println("<head>");
                out.println("<title>Servlet buscaExp</title>");            
                out.println("</head>");
                out.println("<body>");
                out.println("<label> Información General del Paciente </label>");
                out.println("<table>");
                    /* InformaciÃ³n general del paciente */
                    out.println("<tr>");
                        out.println("<td> Numero del Paciente</td>");
                        out.println("<td> Nombre del Paciente </td>");
                        out.println("<td> NSS </td>");
                        out.println("<td> Edad </td>");
                        out.println("<td> InstituciÃ³n </td>");
                        out.println("<td> Género </td>");
                    out.println("</tr>");
                    
                    out.println("<tr>");
                    for (String infoPac : infoPaci) {
                        out.println("<td> " + infoPac + " </td>");
                    }
                    out.println("</tr>");
                out.println("</table>");
                /* Consultas */
                out.println("<label> Consultas realizadas al paciente: </label>");
                out.println("<table>");
                    out.println("<tr>");
                        out.println("<td> Número de Consulta </td>");
                        out.println("<td> Fecha </td>");
                        out.println("<td> Tipo de Consulta </td>");
                        out.println("<td> Número de Doctor </td>");
                        out.println("<td> Observaciones </td>");
                        out.println("<td> Descargar </td>");
                    out.println("</tr>");
                    if(consultasPaci.length != 0){
                        for(String[] consultasPac : consultasPaci){
                            out.println("<tr>");
                            for(String consultaIndi/*viudal*/ : consultasPac){
                                out.println("<td> " + consultaIndi + " </td>");
                            }
                            out.println("<td> <input type='button' value='Descargar' id='" + consultasPac[0] + "consulta' "
                                    + "name='" + consultasPac[0] + "consulta' onClick='irConsulta(this.name)'/> </td>");
                            out.println("</tr>");
                        }
                    }else{
                        out.println("<tr>");
                            out.println("<td> No hay consulta registrada </td>");
                            out.println("<td> ----- </td>");
                            out.println("<td> ----- </td>");
                            out.println("<td> ----- </td>");
                            out.println("<td> ----- </td>");
                            out.println("<td> ----- </td>");
                        out.println("</tr>");
                    }
                out.println("</table>");
                /* Ultima Referencia MÃ©dica (Tratamiento) */
                out.println("<label> Ultima Referencia Médica hecha al paciente (Tratamiento): </label>");
                out.println("<table>");
                    out.println("<tr>");
                        out.println("<td> Número de Plan </td>");
                        out.println("<td> Número de Consulta </td>");
                        out.println("<td> Fecha </td>");
                    out.println("</tr>");
                    
                    out.println("<tr>");
                    if(tratamiento.length != 0){
                        for(String tratami: tratamiento){
                            out.println("<td> " + tratami + " </td>");
                        }
                    }else{
                        out.println("<td> No hay registrado </td>");
                        out.println("<td> ----- </td>");
                        out.println("<td> ----- </td>");
                    }
                    out.println("</tr>");
                out.println("</table>");
                /* Documentos Escaneados */
                out.println("<label> Documentos Escaneados del Paciente </label>");
                out.println("<table>");
                    out.println("<tr>");
                        out.println("<td> Nombre </td>");
                        out.println("<td> Ver / Descargar </td>");
                    out.println("</tr>");
                out.println("</table>");
                out.println("</body>");
                out.println("<script src=\"js\\Expedientes.js\" type=\"text/javascript\"></script>");
                out.println("</html>");
            }
        }else{
            response.sendRedirect("index.html");
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

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
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
