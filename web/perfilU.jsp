<%-- 
    Document   : perfilU
    Created on : 18/02/2018, 05:02:29 PM
    Author     : angelraymundo
--%>
<%@page contentType="text/html" pageEncoding="ISO-8859-1" session="true"%>
<%@page import="java.sql.ResultSet,Doctor.cDoctor"%>
<%
    HttpSession ses = request.getSession();
    String usuario = "" + ses.getAttribute("ID");
        String Tipo = ""+ses.getAttribute("Tipo");
    String usBus = request.getParameter("idBus");
    cDoctor docBus = new cDoctor();
    String[] datosBus = docBus.buscaDoctor(usBus);
    String[] datosCon = docBus.buscaContactoDoctor(usBus);
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
          <span class="mdl-layout-title">Doctor</span>
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
                <a class="mdl-navigation__link" href="">Estadísticas</a>
            <%        
                }else if(Tipo.equals("Doctor")){
            %>
                <a class="mdl-navigation__link" href="consulta.jsp">Consulta Médica</a>
                <a class="mdl-navigation__link" href="consultaExp.jsp">Expedientes</a>
                <a class="mdl-navigation__link" href="">Estadísticas</a>
            <%
                }
            %>
          
          <a class="mdl-navigation__link" href="CerrarSesion.jsp">salir</a>
          <div class="mdl-layout-spacer"></div>
        </nav>
      </div>
      <main class="mdl-layout__content mdl-color--grey-100">
          <form name="datosMod" action="ModificarDoc" method="post">
          <%
                if(Tipo.equals("Jefe_Area")&& usBus!=null){
                    
            %>   
                <div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label ">
                    <input class="mdl-textfield__input" type="text" id="nombreD" value="<%=datosBus[1]%>" disabled="true" name="nombreD">
                  <label class="mdl-textfield__label" for="nombreD">Nombre del Doctor</label>
                </div> &nbsp;
                <div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label ">
                  <input class="mdl-textfield__input" type="text" id="nusuario" value="<%=datosBus[2]%>" disabled="true" name="nusuario">
                  <label class="mdl-textfield__label" for="nusuario">Usuario</label>
                </div> &nbsp;<br>
                <!--Radio Button con Material Design Lite-->
                <a>Genero</a>&nbsp;
                <%
                    if(datosBus[7].equals("Masculino")){
                %>
                    <label class = "mdl-radio mdl-js-radio mdl-js-ripple-effect" for = "opcion1">
                  <input type = "radio" id = "opcion1" name = "generoDoc" value="Masculino" 
                         class = "mdl-radio__button" checked disabled="true">
                  <span class = "mdl-radio__label">Masculino</span>
               </label>&nbsp; 
                <label class = "mdl-radio mdl-js-radio mdl-js-ripple-effect" 
                  for = "opcion2">
                  <input type = "radio" id = "opcion2" name = "generoDoc" value="Femenino"
                     class = "mdl-radio__button" disabled="true">
                  <span class = "mdl-radio__label">Femenino</span>
                </label>
                <%        
                    }else{
                %>
               <label class = "mdl-radio mdl-js-radio mdl-js-ripple-effect" for = "opcion1">
                  <input type = "radio" id = "opcion1" name = "generoDoc" value="Masculino" 
                         class = "mdl-radio__button" disabled="true">
                  <span class = "mdl-radio__label">Masculino</span>
               </label>&nbsp; 
                <label class = "mdl-radio mdl-js-radio mdl-js-ripple-effect" 
                  for = "opcion2">
                  <input type = "radio" id = "opcion2" name = "generoDoc" value="Femenino"
                     class = "mdl-radio__button" checked disabled="true">
                  <span class = "mdl-radio__label">Femenino</span>
                </label> 
               <%
                    }
                %>
               <br>
               <!--Combo box con Material Design Lite-->
                    
                        <%
                            if(datosBus[4].equals("8")&&datosBus[5].equals("14")){
                            %>
                                <div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label getmdl-select">
                                    <input type="text" value="" class="mdl-textfield__input" id="Turno" readonly disabled="true">
                                    <input type="hidden" value="" name="Turno" disabled="true">
                                    <label class="mdl-textfield__label" for="Turno">Turno</label>
                                    <ul class="mdl-menu mdl-menu--bottom-left mdl-js-menu" for="Turno">
                                        <li class="mdl-menu__item" data-val="MAT" data-selected="true">Matutino</li>
                                        <li class="mdl-menu__item" data-val="VES">Vespertino</li>
                                    </ul>
                                </div>
                            <%    
                            }else{
                            %>
                                <div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label getmdl-select">
                                    <input type="text" value="" class="mdl-textfield__input" id="Turno" readonly disabled="true">
                                    <input type="hidden" value="" name="Turno" >
                                    <label class="mdl-textfield__label" for="Turno">Turno</label>
                                    <ul class="mdl-menu mdl-menu--bottom-left mdl-js-menu" for="Turno">
                                        <li class="mdl-menu__item" data-val="MAT">Matutino</li>
                                        <li class="mdl-menu__item" data-val="VES"  data-selected="true" >Vespertino</li>
                                    </ul>
                                </div>
                            <%
                            }
                        %>
               &nbsp;
               
               <div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label getmdl-select">
                    <input type="text" value="" class="mdl-textfield__input" id="TypeDoc" readonly disabled="true">
                    <input type="hidden" value="" name="TypeDoc">
                    <label class="mdl-textfield__label" for="TypeDoc">Tipo de doctor</label>
                    <ul class="mdl-menu mdl-menu--bottom-left mdl-js-menu" for="TypeDoc">
                        <%
                            if(datosBus[6].equals("General")){
                        %>
                        <li class="mdl-menu__item" data-val="General" data-selected="true">General</li>
                        <li class="mdl-menu__item" data-val="Dentista">Dentista</li>
                        <li class="mdl-menu__item" data-val="Pasante">Pasante</li>
                        <%
                            }else if(datosBus[6].equals("Dentista")){
                        %>
                        <li class="mdl-menu__item" data-val="General">General</li>
                        <li class="mdl-menu__item" data-val="Dentista" data-selected="true">Dentista</li>
                        <li class="mdl-menu__item" data-val="Pasante">Pasante</li>
                        <%
                            }else{
                        %>
                        <li class="mdl-menu__item" data-val="General">General</li>
                        <li class="mdl-menu__item" data-val="Dentista">Dentista</li>
                        <li class="mdl-menu__item" data-val="Pasante" data-selected="true">Pasante</li>
                        <%
                            }
                        %>
                    </ul>
                </div>
               <br>
               <!--Check box con Material Design Lite-->
               <p>Dias de trabajo</p>
               <table>
                    <tr>
                       <td> 
                          <label class="mdl-checkbox mdl-js-checkbox mdl-js-ripple-effect" for="lunes">
                            <input type="checkbox" id="lunes" class="mdl-checkbox__input" name="dias" value="lunes" disabled="true" <%=datosBus[3].contains("Lunes")? "checked" : ""%>/>
                            <span class="mdl-checkbox__label">Lunes</span>
                          </label>
                       </td>
                       <td>
                          <label class="mdl-checkbox mdl-js-checkbox mdl-js-ripple-effect" for="martes">
                            <input type="checkbox" id="martes" class="mdl-checkbox__input" name="dias" value="martes" disabled="true" <%=datosBus[3].contains("Martes")? "checked" : ""%>/>
                            <span class="mdl-checkbox__label">Martes</span> 
                          </label>	  
                       </td>
                       <td>
                          <label class="mdl-checkbox mdl-js-checkbox mdl-js-ripple-effect" for="Miercoles">
                            <input type="checkbox" id="Miercoles" class="mdl-checkbox__input" name="dias" value="Miercoles" disabled="true" <%=datosBus[3].contains("Miercoles")? "checked" : ""%>/>
                            <span class="mdl-checkbox__label">Miercoles</span> 
                          </label>   
                       </td>
                       <td>
                           <label class="mdl-checkbox mdl-js-checkbox mdl-js-ripple-effect" for="jueves">
                            <input type="checkbox" id="jueves" class="mdl-checkbox__input" name="dias" value="jueves" disabled="true"<%=datosBus[3].contains("Jueves")? "checked" : ""%>/>
                            <span class="mdl-checkbox__label">Jueves</span> 
                          </label>
                       </td>
                       <td>
                           <label class="mdl-checkbox mdl-js-checkbox mdl-js-ripple-effect" for="Viernes">
                            <input type="checkbox" id="Viernes" class="mdl-checkbox__input" name="dias" value="Viernes" disabled="true"<%=datosBus[3].contains("Viernes")? "checked" : ""%>/>
                            <span class="mdl-checkbox__label">Viernes</span> 
                          </label>
                       </td>
                    </tr>
                 </table>   
                <br>
                &nbsp;<p>Permisos</p>
                <table>
                    <tr>
                        <td>
                            <label class="mdl-checkbox mdl-js-checkbox mdl-js-ripple-effect" for="ConGen">
                            <input type="checkbox" id="ConGen" class="mdl-checkbox__input" name="permisos" value="1" disabled="true" <%=datosBus[8].contains("1")? "checked" : ""%>/>
                            <span class="mdl-checkbox__label">Generar Consultas Generales: </span> 
                          </label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label class="mdl-checkbox mdl-js-checkbox mdl-js-ripple-effect" for="ConDen">
                            <input type="checkbox" id="ConDen" class="mdl-checkbox__input" name="permisos" value="2" disabled="true" <%=datosBus[8].contains("2")? "checked" : ""%>/>
                            <span class="mdl-checkbox__label">Generar Consultas Dentales: </span> 
                          </label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label class="mdl-checkbox mdl-js-checkbox mdl-js-ripple-effect" for="AccExp">
                            <input type="checkbox" id="AccExp" class="mdl-checkbox__input" name="permisos" value="3" disabled="true" <%=datosBus[8].contains("3")? "checked" : ""%>/>
                            <span class="mdl-checkbox__label">Accesar a Expedientes: </span> 
                          </label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label class="mdl-checkbox mdl-js-checkbox mdl-js-ripple-effect" for="ManExp">
                            <input type="checkbox" id="ManExp" class="mdl-checkbox__input" name="permisos" value="4" disabled="true" <%=datosBus[8].contains("4")? "checked" : ""%>/>
                            <span class="mdl-checkbox__label">Manejar información de expedientes: </span> 
                          </label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label class="mdl-checkbox mdl-js-checkbox mdl-js-ripple-effect" for="PerApp">
                            <input type="checkbox" id="PerApp" class="mdl-checkbox__input" name="permisos" value="5" disabled="true" <%=datosBus[8].contains("5")? "checked" : ""%>/>
                            <span class="mdl-checkbox__label">Utilizar aplicación movil: </span> 
                          </label>
                        </td>
                    </tr>
                </table>
                <br>
                &nbsp;<p>Contacto</p>
                <div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label ">
                    <input class="mdl-textfield__input" type="text" id="correo" name="correo" value="<%=datosCon[0]%>" disabled="true">
                  <label class="mdl-textfield__label" for="correo">Correo</label>
                </div> &nbsp;
                <div class="mdl-textfield mdl-js-textfield mdl-textfield--floating-label ">
                  <input class="mdl-textfield__input" type="text" id="celular" name="celular" value="<%=datosCon[1]%>" disabled="true">
                  <label class="mdl-textfield__label" for="celular">Celular</label>
                </div> &nbsp;<br>
                
                <button id="Elim" type="submit" class="mdl-button mdl-js-button mdl-button--raised mdl-button--colored">
                    Eliminar
                  </button>
                <button id="Modi" type="submit" style="visibility:hidden" class="mdl-button mdl-js-button mdl-button--raised mdl-button--colored">
                    Modificar
                </button>
                
            <%        
                }else if(Tipo.equals("Jefe_Area")){
                    response.sendRedirect("index.html");
                }else if(Tipo.equals("Doctor")){
                    response.sendRedirect("index.html");
                }
            %>
            
          </form>
            
            <button id="Mod0" type="submit" class="mdl-button mdl-js-button mdl-button--raised mdl-button--colored" onclick="ocultar();">
                   Modificar
                  </button>
             &nbsp;
             <button  class="mdl-button mdl-js-button mdl-button--raised mdl-button--colored" onclick="location.href='consultarDoc.jsp'">
                    Regresar
                  </button>
      </main>
    </div>
            <script src="https://code.getmdl.io/1.3.0/material.min.js"></script>
            <script>
                function ocultar(){document.getElementById('Mod0').style.visibility='hidden';
                    document.getElementById("Modi").style.visibility='visible';
                    document.getElementsByName('datosMod').disabled="false";
    };
            </script>
    <script src="getmdl-select-master/getmdl-select.min.js" type="text/javascript"></script>
  </body>
</html>
