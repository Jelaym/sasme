/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package serv;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Sonia
 */
public class nConsulta extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
   protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession ses = request.getSession();
        
        
        cConsulta con = new cConsulta();
        String nombrePaciente = request.getParameter("nombreP");
        String nombreDoctor = request.getParameter("DoctorN");
        String usuarioDoctor = "DMB_Doc";
        String tipoConsulta = "normal";        
        String cedulaProfesional = "pppppppppppxxxxx";        
        String nssPaciente = "0123456789";
        
        float peso = Float.parseFloat(request.getParameter("peso"));
        float talla = Float.parseFloat(request.getParameter("talla"));
        float perimetro = Float.parseFloat(request.getParameter("abdominal"));
        float temp = Float.parseFloat(request.getParameter("temperatura"));
        float tension = Float.parseFloat(request.getParameter("arterial"));
        String grupoSan = request.getParameter("sangre");
        String rh = request.getParameter("rh");
        String agudezaVisual = request.getParameter("vista");
        String observaciones = request.getParameter("observaciones");
        String onico = request.getParameter("onicomicosis");
        boolean onicomicosis = true;
        int fc = Integer.parseInt(request.getParameter("fc"));
        int fr = Integer.parseInt(request.getParameter("fr"));
        int pulso = Integer.parseInt(request.getParameter("pulso"));
        
        
        
        
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Cargando...</title>");
            out.println("<script type=\"text/javascript\" src=\"https://code.jquery.com/jquery-1.11.3.min.js\"></script>");
            out.println("<script type='text/javascript' src='Librerias/jspdf.min.js'></script>");
            out.println("<style>");
            out.println(".cargando{");
                out.println("position: absolute;");
                out.println("z-index: 3;");
                out.println("left: 49%;");
                out.println("top: 65%;");
            out.println("}");
            out.println(".circulo {");
                out.println("position: absolute;");
                out.println("z-index: 3;");
                out.println("border: 30px solid #E1F5FE;"); 
                out.println("border-top: 30px solid #01579B;"); 
                out.println("border-radius: 50%;");
                out.println("left: 38%;");
                out.println("top: 15%;");
                out.println("width: 300px;");
                out.println("height: 300px;");
                out.println("animation: spin 3s linear infinite;");
            out.println("}");

            out.println("@keyframes spin {");
                out.println("0% { transform: rotate(0deg); }");
                out.println("100% { transform: rotate(360deg); }");
            out.println("}");
        out.println("</style>");
            out.println("</head>");
            out.println("<body style=\"background-image: url('images/fondo_1_1.jpg')\">");
            
            out.println("<img src='images/Encabezado.png' alt='Imagen' onload='Imprimir()' id='imgPrueba' style='visibility: hidden'>");
            out.println("<canvas id='cvsPdf' style='visibility: hidden'></canvas>");

            out.println("<div class='circulo' ></div>");
            out.println("<p class='cargando' style='color: white; font-size: 30px;'>Cargando...</p>");
            
            out.println("<script>");
                out.println("function Imprimir(){");
                    out.println("var imagen = $('img#imgPrueba').get()[0];");
                    out.println("var doc = new jsPDF();");
                    out.println("var canvas = $('canvas#cvsPdf').get()[0];");
                    out.println("var c = canvas.getContext('2d');");
                    out.println("c.clearRect(0, 0, canvas.width, canvas.height);");
                    out.println("doc.text(80, 70, 'SERVICIO MEDICO');");
                    out.println("doc.text(10, 90, 'Fue atendido por el Dr(a).: "+nombreDoctor+"');");
                    out.println("doc.text(10, 100, 'DATOS DEL PACIENTE');");
                    out.println("doc.text(10, 110, 'Nombre: "+nombrePaciente+"');");
                    out.println("doc.text(10, 120, 'Peso: "+peso+"');");
                    out.println("doc.text(10, 130, 'Talla: "+talla+"');");
                    out.println("doc.text(10, 140, 'Ptro. abd.: "+perimetro+"');");
                    out.println("doc.text(10, 150, 'Temp.: "+temp+"');");
                    out.println("doc.text(90, 150, 'Presion art.: "+tension+"');");
                    out.println("doc.text(10, 160, 'Gpo. Sanquineo: "+grupoSan+"');");
                    out.println("doc.text(90, 160, 'RH: "+rh+"');");
                    out.println("doc.text(10, 170, 'Agudeza Visual: "+agudezaVisual+"');");
                    if(onicomicosis == true){
                        out.println("doc.text(10, 180, 'Onicomicosis: Positiva');");
                    }else{
                        out.println("doc.text(10, 180, 'Onicomicosis: Negativa');");
                    }
                    out.println("doc.text(10, 190, 'FC: "+fc+"');");
                    out.println("doc.text(40, 190, 'FR: "+fr+"');");
                    out.println("doc.text(10, 200, 'Pulso: "+pulso+"');");
                    out.println("doc.text(10, 210, 'Observaciones:');");
                    out.println("doc.text(10, 220, '"+observaciones+"');");
                    out.println("canvas.width = imagen.width;");
                    out.println("canvas.height = imagen.height;"); 
                    out.println("c.drawImage(imagen, 10, 10);");  
                    out.println("var foto = canvas.toDataURL();");
                    out.println("doc.addImage(foto, 'PNG', 0, 0, 200, 60);");
                    
                    out.println("doc.save('"+nombrePaciente+".pdf');");
                out.println("}");
                out.println("window.location.replace('consulta.jsp');");
            out.println("</script>");
            out.println("</body>");
            out.println("</html>");
        }
//        Conectamos a la base
        con.insertaConsultaDatosBasicos(nombreDoctor, usuarioDoctor, nombrePaciente, nssPaciente, cedulaProfesional);
//        
        con.insertaConsultaDatosProfundos(peso, talla, perimetro, fc, fr, temp, tension, pulso,
                                          grupoSan, rh, agudezaVisual, observaciones, onicomicosis);

        response.sendRedirect("consulta.jsp");
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


    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs

   

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
  
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
