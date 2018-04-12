 <%-- 
    Document   : consulta
    Created on : Dec 6, 2017, 9:51:12 PM
    Author     : Sonia
--%>

<%@page contentType="text/html" pageEncoding="ISO-8859-1" session="true"%>
<%
        HttpSession ses = request.getSession();
       //request.setAttribute("nom", ses.getAttribute("nombre"));
        String usuario = "" + ses.getAttribute("ID");
        String Tipo = ""+ses.getAttribute("Tipo");
%>
<!DOCTYPE html>
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

    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"  crossorigin="anonymous">
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" crossorigin="anonymous"></script>
        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"  crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" crossorigin="anonymous"></script>
        <link href="https://fonts.googleapis.com/css?family=Fira+Sans|Libre+Baskerville|Rubik" rel="stylesheet">
        
    
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
          <span class="mdl-layout-title">Consulta</span>
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
          <form action="nConsulta" method="post">
              <br>
              <%out.print("<input type='hidden' name='DoctorN' value='"+usuario+"'>");%>
                <div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label mdl-cell mdl-cell--2-col ">
                  <input class="mdl-textfield__input" type="text" id="nombreP" name="nombreP">
                  <label class="mdl-textfield__label" for="nombreP">Nombre del paciente</label>
                </div> &nbsp;
                <div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label mdl-cell mdl-cell--2-col">
                    <input class="mdl-textfield__input" type="text" pattern="-?[0-9]*(\.[0-9]+)?" id="nss" name="nss">
                    <label class="mdl-textfield__label" for="nss">NSS</label>
                    <span class="mdl-textfield__error">debe ser un numero</span>
                  </div> &nbsp;
                <div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label mdl-cell mdl-cell--2-col">
                    <input class="mdl-textfield__input" type="text" pattern="-?[0-9]*(\.[0-9]+)?" id="edad" name="edad">
                    <label class="mdl-textfield__label" for="edad">Edad</label>
                    <span class="mdl-textfield__error">debe ser un numero</span>
                </div> <br>
                <div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label mdl-cell mdl-cell--1-col">
                    <input class="mdl-textfield__input" type="text" pattern="-?[0-9]*(\.[0-9]+)?" id="peso" name="peso">
                    <label class="mdl-textfield__label" for="peso">Peso</label>
                    <span class="mdl-textfield__error">debe ser un numero</span>
                </div> &nbsp;
                <div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label mdl-cell mdl-cell--1-col">
                    <input class="mdl-textfield__input" type="text" pattern="-?[0-9]*(\.[0-9]+)?" id="talla" name="talla">
                    <label class="mdl-textfield__label" for="talla">Talla</label>
                    <span class="mdl-textfield__error">debe ser un numero</span>
                </div> &nbsp;
                <div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label mdl-cell mdl-cell--1-col">
                    <input class="mdl-textfield__input" type="text" pattern="-?[0-9]*(\.[0-9]+)?" id="abdominal" name="abdominal">
                    <label class="mdl-textfield__label" for="abdominal">P. Abdominal</label>
                    <span class="mdl-textfield__error">debe ser un numero</span>
                </div> &nbsp;
                <div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label mdl-cell mdl-cell--1-col">
                    <input class="mdl-textfield__input" type="text" pattern="-?[0-9]*(\.[0-9]+)?" id="fr" name="fr">
                    <label class="mdl-textfield__label" for="fr">FR</label>
                    <span class="mdl-textfield__error">debe ser un numero</span>
                </div> &nbsp;
                <div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label mdl-cell mdl-cell--1-col">
                    <input class="mdl-textfield__input" type="text" pattern="-?[0-9]*(\.[0-9]+)?" id="fc" name="fc">
                    <label class="mdl-textfield__label" for="fc">FC</label>
                    <span class="mdl-textfield__error">debe ser un numero</span>
                </div> &nbsp;
                <div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label mdl-cell mdl-cell--1-col">
                    <input class="mdl-textfield__input" type="text" pattern="-?[0-9]*(\.[0-9]+)?" id="arterial" name="arterial">
                    <label class="mdl-textfield__label" for="arterial">T. arterial</label>
                    <span class="mdl-textfield__error">debe ser un numero</span>
                </div> &nbsp;
                <div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label mdl-cell mdl-cell--1-col">
                    <input class="mdl-textfield__input" type="text" pattern="-?[0-9]*(\.[0-9]+)?" id="temperatura" name="temperatura">
                    <label class="mdl-textfield__label" for="temperatura">Temperatura</label>
                    <span class="mdl-textfield__error">debe ser un numero</span>
                </div> &nbsp;
                <div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label mdl-cell mdl-cell--1-col">
                    <input class="mdl-textfield__input" type="text" id="sangre" name="sangre">
                    <label class="mdl-textfield__label" for="sangre">G. Sanguineo</label>
                </div> &nbsp;
                <div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label mdl-cell mdl-cell--1-col">
                    <input class="mdl-textfield__input" type="text" id="rh" name="rh">
                    <label class="mdl-textfield__label" for="rh">RH</label>
                </div> &nbsp;
                <div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label mdl-cell mdl-cell--1-col">
                    <input class="mdl-textfield__input" type="text" id="pulso" name="pulso">
                    <label class="mdl-textfield__label" for="pulso">Pulso</label>
                </div> <br><br>
                <div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label mdl-cell mdl-cell--2-col">
                    <input class="mdl-textfield__input" type="text" id="vista" name="vista">
                    <label class="mdl-textfield__label" for="vista">Agudeza Viual</label>
                </div> &nbsp;&nbsp; 
                <a>Onicomicosis</a>&nbsp; 
                <label class = "mdl-radio mdl-js-radio mdl-js-ripple-effect" for = "opcion1">
                  <input type = "radio" id = "opcion1" name = "onmicomicosis" value="si"
                     class = "mdl-radio__button" checked>
                  <span class = "mdl-radio__label">Si</span>
               </label>&nbsp; 
                <label class = "mdl-radio mdl-js-radio mdl-js-ripple-effect" 
                  for = "opcion2">
                  <input type = "radio" id = "opcion2" name = "onmicomicosis" value="no"
                     class = "mdl-radio__button" >
                  <span class = "mdl-radio__label">No</span>
                </label>
               <br><br>
               <div class="mdl-textfield mdl-js-textfield mdl-cell mdl-cell--5-col">
                <textarea class="mdl-textfield__input" type="text" rows= "4" id="observaciones" name="observaciones" ></textarea>
                <label class="mdl-textfield__label" for="observaciones">Observaciones</label>
              </div>
               <br><br>
               <input type="submit" value="Enviar" name="enviar" class="mdl-button mdl-js-button mdl-button--primary" />
               
                
              </form>
      </main>
    </div>
    <script src="https://code.getmdl.io/1.3.0/material.min.js"></script>
  </body>
</html>
