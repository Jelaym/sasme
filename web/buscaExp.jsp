<%--
    Document   : buscaExp
    Created on : 11/04/2018, 09:39:55 PM
    Author     : Touchier
--%>

<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>JSP Page</title>
    </head>
    <body>
        <%@page import="serv.cPacientes" %>
        <%
            request.setCharacterEncoding("UTF-8");
            String val = (String) request.getParameter("pedidoExp");/* Boton anterior */

            String nss = request.getParameter("nss");

            cPacientes objPaciente = new cPacientes();
            String[] infoPaci = objPaciente.buscaPaciente(nss);
            if (infoPaci[0].equals("0")) {
                response.sendRedirect("consultaExp.jsp?a=E");
            };

            String[][] consultasPaci = objPaciente.consultasDeUnPaciente(nss);
            String[] tratamiento = objPaciente.ultimoTratamiento(nss);

        %>
        <!DOCTYPE html>
    <html>
        <head>
            <title>Servlet buscaExp</title>            
        </head>
        <body>
            <label> Información General del Paciente </label>
            <table>
                <%/* Información general del paciente */ %>
                <tr>
                    <td> Numero del Paciente</td>
                    <td> Nombre del Paciente </td>
                    <td> NSS </td>
                    <td> Edad </td>
                    <td> Institución </td>
                    <td> Género </td>
                </tr>

                <tr>
                    <%for (String infoPac : infoPaci) {%>
                    <td> <%=infoPac%> </td>
                    <%}%>
                </tr>
            </table>
            <%/* Consultas */%>
            <label> Consultas realizadas al paciente: </label>
            <table>
                <tr>
                    <td> Número de Consulta </td>
                    <td> Fecha </td>
                    <td> Tipo de Consulta </td>
                    <td> Número de Doctor </td>
                    <td> Observaciones </td>
                    <td> Descargar </td>
                </tr>
                <%if (consultasPaci.length != 0) {
                            for (String[] consultasPac : consultasPaci) {%>
                <tr>
                    <%for (String consultaIndi/*viudal*/ : consultasPac) {%>
                    <td> <%=consultaIndi%> </td>
                    <%}%>
                    <td>
                        <input type="button" value="Descargar" id="<%=consultasPac[0]%>consulta" name="<%=consultasPac[0]%>consulta" onClick="irConsulta(this.name)"/>
                    </td>
                </tr>
                <%}
                        } else {%>
                <tr>
                    <td> No hay consulta registrada </td>
                    <td> ----- </td>
                    <td> ----- </td>
                    <td> ----- </td>
                    <td> ----- </td>
                    <td> ----- </td>
                </tr>
                <%}%>
            </table>
            <%/* Ultima Referencia Médica (Tratamiento) */%>
            <label> Ultima Referencia Médica hecha al paciente (Tratamiento): </label>
            <table>
                <tr>
                    <td> Número de Plan </td>
                    <td> Número de Consulta </td>
                    <td> Fecha </td>
                </tr>

                <tr>
                    <%if (tratamiento[0].length() != 0) {
                            for (String tratami : tratamiento) {%>
                    <td> <%=tratami%> </td>
                    <%}
                        } else {%>
                    <td> No hay registrado </td>
                    <td> ----- </td>
                    <td> ----- </td>
                    <%}%>
                </tr>
            </table>
            <%/* Documentos Escaneados */%>
            <%--<<label> Documentos Escaneados del Paciente </label>
            <table>
                <tr>
                    <td> Nombre </td>
                    <td> Ver / Descargar </td>
                </tr>
            </table>--%>
        </body>
        <script src=\"js\\Expedientes.js\" type=\"text/javascript\"></script>        
    </html>
</body>
</html>
