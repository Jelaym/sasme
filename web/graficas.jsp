<%-- 
    Document   : graficas
    Created on : 12/04/2018, 02:22:16 AM
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

    <script src="js/Chart.js" type="text/javascript"></script>
    <script src="js/Chart.min.js" type="text/javascript"></script>
    <link href='https://fonts.googleapis.com/css?family=Galdeano' rel='stylesheet'>
    <link href="Estilo/cienPorCiento.css" rel="stylesheet" type="text/css"/>
    <link href="css/csGraf.css" rel="stylesheet" type="text/css"/>
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
          <div class='diviTitulo'>
            <h1> Servicio Médico </h1>
        </div>
        
        <label class="datoX2"> Mes </label>
        
        <div class="divi2"><canvas id="grafic2" height="250"></canvas></div>
        
        <%@page import="serv.cPacientes"%>
        <%
            cPacientes paci= new cPacientes();
            String[][] datos= paci.pacientesPorMes();
            int total= 0;
            for(int i= 0; i < datos.length; i++){
                total+= Integer.parseInt(datos[i][0]);
            }
        %>
                <div class='total'><label> Numero de Personas que han asisitdo: <%=total%> </label></div>
        <%   
            if(total == 0){ 
                %>
                    <script> alert("No han contestado el cuestionario.\nGraficas no disponibles"); </script>
                <%
            }
        %>
        <%
            String nombres, valores;
            nombres= valores= "";
            for(int i= 0; i < datos.length; i++){
                if(i == 0){
                    nombres+= "['";
                    valores+= "['";
                }
                nombres+= datos[i][0];
                valores+= datos[i][1];
                if((i + 1) == datos.length){
                    nombres+= "']";
                    valores+= "']";
                }else{
                    nombres+= "','";
                    valores+= "','";
                }
            }
        %>    
            
        <script>
            var ctx2 = document.getElementById("grafic2").getContext('2d');
            var myChart2 = new Chart(ctx2, {
                type: 'bar',
                data: {
                    labels: <%= valores %>,
                    datasets: [{
                        label: 'Personas',
                        backgroundColor: "rgba(80,106,118,0.8)",
                        borderColor: "rgba(60, 205, 133, 1)",
                        highlightFill: "#1864f2",
                        highlightStroke: "#ffffff",
                        borderWidth: 1,
                        data: <%= nombres %>
                    }]
                },
                options: {
                    resize: true,
                    barValueSpacing: 20,
                    title: {
                        display: true,
                        text: 'Personas que asistieron al SM',
                        fontColor: "black",
                        fontSize: 18
                    },
                    scales: {
                        xAxes: [{
                            gridLines:{
                                color:"rgba(75,75,75,0.8)"
                            },
                            ticks:{
                                min: 0,
                                fontColor: "black",
                                fontSize: 12
                            }
                        }],
                        yAxes: [{
                            gridLines:{
                                color:"rgba(75,75,75,0.2)"
                            },
                            ticks:{
                                min: 0,
                                fontColor: "black",
                                fontSize: 13
                            }
                        }]
                    },
                    legend: {
                        labels:{
                            fontColor:"black", 
                            fontSize: 14
                        },
                        position: 'top'
                    }
                }
            });
        </script>
      </main>
    </div>
    <script src="https://code.getmdl.io/1.3.0/material.min.js"></script>
  </body>
</html>

