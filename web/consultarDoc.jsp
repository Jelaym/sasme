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
    </style>
  </head>
  <body>
    <div class="demo-layout mdl-layout mdl-js-layout mdl-layout--fixed-drawer mdl-layout--fixed-header">
      <header class="demo-header mdl-layout__header mdl-color--grey-100 mdl-color-text--grey-600">
        <div class="mdl-layout__header-row">
          <span class="mdl-layout-title text-primary ">Consultar Doctores</span>
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
                        
                        
                            <form action="#">
                            <div class="mdl-textfield mdl-js-textfield mdl-textfield--expandable">
                              <label class="mdl-button mdl-js-button mdl-button--icon" for="sample6">
                                <i class="material-icons">search</i>
                              </label>
                              <div class="mdl-textfield__expandable-holder">
                                <input class="mdl-textfield__input" type="text" id="sample6">
                                <label class="mdl-textfield__label" for="sample-expandable">Ingresa el ID del doctor</label>
                              </div>
                            </div>
                            </form>
                        <br>
                        <div>

                            <%    
                                    out.println("<div id='EditarInfo' style='display:none; background-color: #a6e1ec; position: absolute;  left: 30%; width: 80%; '>");
                                    out.println("<form action='Doctores' method='GET' enctype='multipart/form-data'>");
                                        out.println("<div class='zonaRegD1' style='background-color: #a6e1ec; text-align: center;'>");
                                            out.println("<h1>Editar doctores</h1>");
                                            out.println("<p>Nombre completo</p>");
                                            out.println("<input type='text' name='nombre' placeholder='Nombre completo' value='' size='50' />"); 
                                            out.println("<br><br>");
                                            out.println("<p>Contraseña</p>");
                                            out.println("<input type='password' name='contra' value='' placeholder='Contraseña' size='50' />");   
                                            out.println("<br><br>");
                                            out.println("<p>Usuario</p>");
                                            out.println("<input type='text' name='usr' value='' placeholder='Usuario' size='50' />");
                                            out.println("<br><br>");
                                            out.println("<p>Genero</p>");
                                            out.println("<input type='radio' name='Genero' value='F' checked='checked' />Mujer <br>");
                                            out.println("<input type='radio' name='Genero' value='M' />Hombre");
                                            out.println("<br>");
                                            out.println("<p>  Tipo</p>");
                                            out.println("<input type='radio' name='Tipo' value='Doctor' checked='checked' />Doctor<br>");
                                            out.println("<input type='radio' name='Tipo' value='Dentista' />Dentista<br>");
                                            out.println("<br>"); 
                                            out.println("<p>Dias</p>");
                                            out.println("<input type='checkbox' name='dia' value='' />Lunes");
                                            out.println("<br>");
                                            out.println("<input type='checkbox' name='dia' value='' />Martes");
                                            out.println("<br>");
                                            out.println("<input type='checkbox' name='dia' value='' />Miercoles");
                                            out.println("<br>");
                                            out.println("<input type='checkbox' name='dia' value='' />Jueves");
                                            out.println("<br>");
                                            out.println("<input type='checkbox' name='dia' value='' />Viernes");
                                            out.println("<br>");
                                            out.println("<p>Contactos</p>");
                                            out.println("<a>Correo &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a> <input type='text' name='correo' value='' size='30' /><br>");
                                            out.println("<a>Celular &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a> <input type='text' name='cel' value='' size='30' /><br>");
                                            out.println("<a>Tel. Emergencia &nbsp; </a> <input type='text' name='emergen' value='' size='30' /><br><br>");
                                            out.println("<input type='submit' value='Guardar' class='btn btn-success'/>");
                                            out.println("<input type='button' value='Cancelar' onclick='Cancelar()' class='btn btn-success'/>");
                                            out.println("<br>");
                                            
                                        out.println("</div>");
                                    out.println("</form>");   
                                out.println("</div>");                               
                                %> 

                                <form action="Doctores" method="get">
                                <table class="table table-hover">
                                    <thead>
                                      <tr>
                                        <th>Id</th>
                                        <th>Nombre</th>
                                        <th>Hora de entrada</th>
                                        <th>Hora de salida</th>
                                        <th>Tipo</th>
                                        <th>Perfil</th>
                                      </tr>
                                    </thead>
                                    <tbody>
                                        <%
                                            cDoctor Doctores = new cDoctor();
                                            String [][] Doctor = Doctores.DoctoresTotales();    
                                            for(int i = 0; i < Doctor.length; i++){
                                                out.println("<tr>");
                                                    out.println("<td>"+Doctor[i][0]+"</td>");
                                                    out.println("<td>"+Doctor[i][1]+"</td>");
                                                    //out.println("<td>"+Doctor[i][2]+"</td>"); Usuario
                                                    out.println("<td>"+Doctor[i][4]+"</td>");
                                                    out.println("<td>"+Doctor[i][5]+"</td>");
                                                    out.println("<td>"+Doctor[i][6]+"</td>");
                                                    //out.println("<td>"+Doctor[i][7]+"</td>"); Genero
                                                    out.println("<td><input type='button' value='Ver' class='btn btn-success' onclick='Editar(\""+Doctor[i][2]+"\")'></td>");
                                                out.println("</tr>");    
                                            }
                                        %>   
                                    </tbody>
                                </table>            
                            </form>
                                    <br>
                                    <div>
                        <button class="mdl-button mdl-js-button mdl-button--raised" onclick="location.href='agregarDoc.jsp'">Registrar</button>
                        </div>
                        </div>
                    </section>
                    <%
                        out.println("<script>");
                            out.println("function Editar(usuario){location.href='perfilU.jsp?idBus='+usuario");
                                //out.println("document.getElementById('EditarInfo').style.display= 'block';");
                                
                            out.println("}");
                            out.println("function Cancelar(){");
                                out.println("document.getElementById('EditarInfo').style.display= 'none';");
                            out.println("}");
                        out.println("</script>");
                    %>
      </main>
    </div>
    <script src="https://code.getmdl.io/1.3.0/material.min.js"></script>
  </body>
</html>
