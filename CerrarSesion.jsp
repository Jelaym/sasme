
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Salir</title>
    </head>
    <body>
        <%
            HttpSession sesion = request.getSession();
            sesion.invalidate();
            out.println("<script> location.href = 'index.html'; </script>");
        %>
    </body>
</html>
