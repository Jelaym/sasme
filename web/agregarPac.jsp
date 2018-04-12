<%-- 
    Document   : agregarPac
    Created on : Dec 7, 2017, 3:34:52 AM
    Author     : Sonia
--%>

<%@page contentType="text/html" pageEncoding="ISO-8859-1" session="true"%>
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
          <span class="mdl-layout-title">Agregar Paciente</span>
          <div class="mdl-layout-spacer"></div>
          <button class="mdl-button mdl-js-button mdl-js-ripple-effect mdl-button--icon" id="hdrbtn">
            <i class="material-icons">more_vert</i>
          </button>
          <ul class="mdl-menu mdl-js-menu mdl-js-ripple-effect mdl-menu--bottom-right" for="hdrbtn">
            <li class="mdl-menu__item">Nosotros</li>
            <li class="mdl-menu__item">Nuestra Pagina</li>
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
           <%        
                }else if(Tipo.equals("Doctor")){
            %>
                <a class="mdl-navigation__link" href="consulta.jsp">Consulta Médica</a>
                <a class="mdl-navigation__link" href="consultaExp.jsp">Expedientes</a>
            <%
                }
            %>
          <a class="mdl-navigation__link" href="Graficas.jsp">Estadisticas</a>
          <a class="mdl-navigation__link" href="CerrarSesion.jsp">salir</a>
          <div class="mdl-layout-spacer"></div>
        </nav>
      </div>
      <main class="mdl-layout__content mdl-color--grey-100">
          <form action="agregarPac" method="post">
              <br>
                <div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label ">
                  <input class="mdl-textfield__input" type="text" id="nombreP" name="nnombreP">
                  <label class="mdl-textfield__label" for="nombreP">Nombre del Paciente</label>
                </div> &nbsp;
                <div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label ">
                  <input class="mdl-textfield__input" type="text" id="identificador" name="identificador">
                  <label class="mdl-textfield__label" for="identificador">Boleta/Num de Trabajador</label>
                </div> &nbsp;
                <div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label ">
                  <input class="mdl-textfield__input" type="text" id="edadP" pattern="-?[0-9]*(\.[0-9]+)?" name="edadP">
                  <label class="mdl-textfield__label" for="edadP">Edad</label>
                </div> &nbsp;<br>

                <a>Tipo</a>&nbsp; 
                <label class = "mdl-radio mdl-js-radio mdl-js-ripple-effect" for = "opcion1">
                  <input type = "radio" id = "opcion1" name = "tipoP" value="alumno" 
                     class = "mdl-radio__button" checked>
                  <span class = "mdl-radio__label">Alumno</span>
               </label>&nbsp; 
                <label class = "mdl-radio mdl-js-radio mdl-js-ripple-effect" 
                  for = "opcion2">
                  <input type = "radio" id = "opcion2" name = "tipoP" value="Maestro"
                     class = "mdl-radio__button" >
                  <span class = "mdl-radio__label">Maestro</span>
                </label> &nbsp; 
                <label class = "mdl-radio mdl-js-radio mdl-js-ripple-effect" 
                  for = "opcion3">
                  <input type = "radio" id = "opcion3" name = "tipoP" value="Administrativo"
                     class = "mdl-radio__button" >
                  <span class = "mdl-radio__label">Administrativo</span>
                </label>
               <br>
               <br>
                <a>Genero</a>&nbsp; 
                <label class = "mdl-radio mdl-js-radio mdl-js-ripple-effect" for = "opcion5">
                  <input type = "radio" id = "opcion5" name = "generoP" value="Hombre" 
                     class = "mdl-radio__button" checked>
                  <span class = "mdl-radio__label">Hombre</span>
               </label>&nbsp; 
                <label class = "mdl-radio mdl-js-radio mdl-js-ripple-effect" 
                  for = "opcion6">
                  <input type = "radio" id = "opcion6" name = "generoP" value="Mujer"
                     class = "mdl-radio__button" >
                  <span class = "mdl-radio__label">Mujer</span>
                </label> &nbsp; 
                <br><br>

                &nbsp;<p>Otro</p>
                <div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label ">
                  <input class="mdl-textfield__input" type="text" id="institucion" name="institucion">
                  <label class="mdl-textfield__label" for="institucion">Institucion</label>
                </div> &nbsp;
                <div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label ">
                  <input class="mdl-textfield__input" type="text" id="nss" name="nss">
                  <label class="mdl-textfield__label" for="nss">NSS</label>
                </div> &nbsp;
                <br>
                
               <input type="submit" value="Enviar" name="enviar" class="mdl-button mdl-js-button mdl-button--primary" />
               
                
              </form>
      </main>
    </div>
    <script src="https://code.getmdl.io/1.3.0/material.min.js"></script>
  </body>
</html>
