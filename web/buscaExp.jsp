<%--
    Document   : buscaExp
    Created on : 11/04/2018, 09:39:55 PM
    Author     : Touchier
--%>
<%@page contentType="text/html" pageEncoding="ISO-8859-1" session="true"%>
<%@page import="java.sql.ResultSet,Doctor.cDoctor"%>
<%
    HttpSession ses = request.getSession();
    String usuario = "" + ses.getAttribute("ID");
        String Tipo = ""+ses.getAttribute("Tipo");
%>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="description" content="A front-end template that helps you build fast, modern mobile web apps.">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0">
    <title>Doctor</title>

    <!-- Add to homescreen for Chrome on Android -->
    <meta name="mobile-web-app-capable" content="yes">
    <link rel="icon" sizes="192x192" href="images/android-desktop.png">

    <!-- Add to homescreen for Safari on iOS -->
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-title" content="Material Design Lite">
    <link rel="apple-touch-icon-precomposed" href="images/ios-desktop.png">

    <!-- Tile icon for Win8 (144x144 + tile color) -->
    <meta name="msapplication-TileImage" content="images/touch/ms-touch-icon-144x144-precomposed.png">
    <meta name="msapplication-TileColor" content="#3372DF">

    <link rel="shortcut icon" href="images/favicon.png">

    <!-- SEO: If your mobile URL is different from the desktop URL, add a canonical link to the desktop page https://developers.google.com/webmasters/smartphone-sites/feature-phones -->
    <!--
    <link rel="canonical" href="http://www.example.com/">
    -->

    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:regular,bold,italic,thin,light,bolditalic,black,medium&amp;lang=en">
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
    <link rel="stylesheet" href="https://code.getmdl.io/1.3.0/material.cyan-light_blue.min.css">
    <link rel="stylesheet" href="styles.css">
    <link href="Estilo/reaparecer.css" rel="stylesheet" type="text/css"/>
    
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"  crossorigin="anonymous">
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" crossorigin="anonymous"></script>
        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"  crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" crossorigin="anonymous"></script>
        <link href="https://fonts.googleapis.com/css?family=Fira+Sans|Libre+Baskerville|Rubik" rel="stylesheet">
    <style>
    #view-source {
      position: fixed;
      display: block;
      right: 0;
      bottom: 0;
      margin-right: 40px;
      margin-bottom: 40px;
      z-index: 900;
    }
    main h3{
        padding-left: 8%;
    }
    main table, table td{
        margin-left: 5%;
    }
    table *{
        text-align: center;
        font-size: 1.1em;
    }
    table{
        border-collapse: collapse;
        border: 5px solid #00334d;
        text-align: center;
    }
    /*input[type="submit"], input[type="button"]{
        padding: 15% auto;
        margin-left: 7%;
        margin-top: 15%;
        border: none;
        color: white;
        background-color: black;
    }*/
    input[type="button"]{
        margin-top: 5%;
    }
    .titulo{
        background-color: #004466;
        color: white;
        font-weight: bold;
    }
    .titulo td{
        padding-left: 2%;
        padding-right: 2%;
        width: 150px;
    }
    .boton{
        width: 20%;
    }
    </style>
  </head>
  <body>
    <div class="demo-layout mdl-layout mdl-js-layout mdl-layout--fixed-drawer mdl-layout--fixed-header">
      <header class="demo-header mdl-layout__header mdl-color--grey-100 mdl-color-text--grey-600">
        <div class="mdl-layout__header-row">
          <span class="mdl-layout-title">Consultar Expediente</span>
          <div class="mdl-layout-spacer"></div>
          <button class="mdl-button mdl-js-button mdl-js-ripple-effect mdl-button--icon" id="hdrbtn">
            <i class="material-icons">more_vert</i>
          </button>
          <ul class="mdl-menu mdl-js-menu mdl-js-ripple-effect mdl-menu--bottom-right" for="hdrbtn">
            <a href="nosotros.jsp"><li class="mdl-menu__item">Nosotros</li></a>
          </ul>
        </div>
      </header>
      <div class="demo-drawer mdl-layout__drawer mdl-color--blue-grey-900 mdl-color-text--blue-grey-50">
        <header class="demo-drawer-header">
          <div class="demo-avatar-dropdown">
              <span><%out.print("<a>"+usuario+"</a>");%></span>
            <div class="mdl-layout-spacer"></div>
          </div>
        </header>
        <nav class="demo-navigation mdl-navigation mdl-color--blue-grey-800">
            <%
                if(Tipo.equals("Jefe_Area")){
                    
            %>   
                <a class="mdl-navigation__link" href="consultarDoc.jsp">Doctores</a>
                <a class="mdl-navigation__link" href="graficas.jsp">Estadísticas</a>
            <%        
                }else if(Tipo.equals("Doctor")){
            %>
                <a class="mdl-navigation__link" href="consulta.jsp">Consulta Médica</a>
                <a class="mdl-navigation__link" href="consultaExp.jsp">Expedientes</a>
                <a class="mdl-navigation__link" href="graficas.jsp">Estadísticas</a>
            <%
                }
            %>
          
          <a class="mdl-navigation__link" href="CerrarSesion.jsp">salir</a>
          <div class="mdl-layout-spacer"></div>
        </nav>
      </div>
      <main class="mdl-layout__content mdl-color--grey-100">
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
          <h3> Información General del Paciente </h3>
            <table>
                <%/* Información general del paciente */ %>
                <tr class="titulo">
                    <td> Numero del Paciente</td>
                    <td> Nombre del Paciente </td>
                    <td> NSS </td>
                    <td> Edad </td>
                    <td> Institución </td>
                    <td> Género </td>
                    <td class="boton"> Boton </td>
                </tr>

                <tr>
                    <%for (String infoPac : infoPaci) {%>
                    <td> <%=infoPac%> </td>
                    <%}%>
                    <td>
                        <form name="formu" id="formu" action="modifyPac.jsp" method="post">
                            <input type="submit" value="Modificar" class="btn btn-info" name="<%=infoPaci[0]%>paciente" id="<%=infoPaci[0]%>paciente" onClick="cambia(this.id)"/>
                            <input type="hidden" value="<%=infoPaci[2]%>" name="nss"/>
                        </form>
                    </td>
                </tr>
                
            </table>
            <%/* Consultas */%>
            <h3> Consultas realizadas al paciente: </h3>
            <table>
                <tr class="titulo">
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
                        <input type="button" value="Descargar" class="btn btn-info" id="<%=consultasPac[0]%>" name="<%=consultasPac[0]%>" onClick="irConsulta(this.name)"/>
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
            <h3> Ultima Referencia Médica hecha al paciente (Tratamiento): </h3>
            <table>
                <tr class="titulo">
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
            <script src=\"js\\Expedientes.js\" type=\"text/javascript\"></script>  
      </main>
    </div>
    <script src="https://code.getmdl.io/1.3.0/material.min.js"></script>
  </body>
</html>

