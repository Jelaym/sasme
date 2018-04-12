<%-- 
    Document   : modificaPac
    Created on : 12/04/2018, 12:28:31 AM
    Author     : Touchier
--%>

<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<%@page import="serv.cPacientes" %>
<%
    String nombre= request.getParameter("nombre");
    int edad= Integer.parseInt(request.getParameter("edad"));
    String institucion= request.getParameter("institucion");
    String genero= request.getParameter("genero");
    String nss= request.getParameter("nss");

    cPacientes paci= new cPacientes();
    paci.modificaPacienteBasico(nombre, institucion, genero, edad, nss);
%>
<script>alert("Paciente modificado con exito");
        location.href='consultaExp.jsp';</script>
