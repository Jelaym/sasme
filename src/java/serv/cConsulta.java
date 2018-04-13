/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package serv;

import BD.cConectaBD;
import java.sql.CallableStatement; /*PROCEDIMIENTOS*/
import java.sql.Statement; /*VIEWS*/
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author Touchier
 */
public class cConsulta {
    cConectaBD Conecta;
    Connection cont;
    CallableStatement procedure;
    Statement vista;
    ResultSet resul;
    
    public cConsulta(){
        Conecta= new cConectaBD("servicio_medico");
        cont= null;
        procedure= null;
        vista= null;
    }
    /*Datos básicos*/
    public String insertaConsultaDatosBasicos(String nombreDoctor, String usuarioDoctor, String nombrePaciente, String nssPaciente,/* String tipoConsulta,*/ String cedulaProfesional){
        cont= Conecta.Conecta();
        String tipoConsultaL= "Normal";
        String msj= "";
        if(cont != null){
            try{
                procedure= cont.prepareCall("{CALL agregaConsulta(?,?,?,?,?,?)}");
                procedure.setString(1, nombreDoctor);
                procedure.setString(2, usuarioDoctor);
                procedure.setString(3, nombrePaciente);
                procedure.setString(4, nssPaciente);
                procedure.setString(5, tipoConsultaL);
                procedure.setString(6, cedulaProfesional);
                
                procedure.execute();
                resul= procedure.getResultSet();
                
                while(resul.next()){
                    msj= resul.getString("msj");
                    System.out.println(msj);
                }
            }catch(SQLException e){
                System.out.println("Error al llamar procedimiento");
            }
        }
        cont= Conecta.cierra(cont);
        Conecta.cierra();
        return msj;
    }
    /*Datos más Profundos*/
    public void insertaConsultaDatosProfundos(float peso, float talla, float perimetro, int fc, int fr, float temp, float tension, int pulso,
                                                String grupoSan, String rh, String agudezaVisual, String observaciones, boolean onicomicosis){
        cont= Conecta.Conecta();
        String unidadPesoL, metricaPesoL, unidadTallaL, metricaTallaL, unidadPerimetroL, metricaPerimetroL, unidadTemperaturaL, metricaTemperaturaL;
        String unidadTensionL, metricaTensionL;
        unidadPesoL= "Kilogramos";
        metricaPesoL= "kg";
        unidadTallaL= "Metros";
        metricaTallaL= "m";
        unidadPerimetroL= "centimetros";
        metricaPerimetroL= "cm";
        unidadTemperaturaL= "Celsius";
        metricaTemperaturaL= "°C";
        unidadTensionL= "Milimetros de Mercurio";
        metricaTensionL= "mm";
        if(cont != null){
            String msj= "";
            try{
                procedure= cont.prepareCall("{CALL agregaConsultaNormalCompleta(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
                procedure.setFloat(1, peso);
                procedure.setString(2, unidadPesoL);
                procedure.setString(3, metricaPesoL);
                procedure.setFloat(4, talla);
                procedure.setString(5, unidadTallaL);
                procedure.setString(6, metricaTallaL);
                procedure.setFloat(7, perimetro);
                procedure.setString(8, unidadPerimetroL);
                procedure.setString(9, metricaPerimetroL);
                procedure.setInt(10, fc);
                procedure.setInt(11, fr);
                procedure.setFloat(12, temp);
                procedure.setString(13, unidadTemperaturaL);
                procedure.setString(14, metricaTemperaturaL);
                procedure.setFloat(15, tension);
                procedure.setString(16, unidadTensionL);
                procedure.setString(17, metricaTensionL);
                procedure.setInt(18, pulso);
                procedure.setString(19, grupoSan);
                procedure.setString(20, rh);
                procedure.setString(21, agudezaVisual);
                procedure.setString(22, observaciones);
                procedure.setBoolean(23, onicomicosis);
                
                procedure.execute();
                resul= procedure.getResultSet();
                
                while(resul.next()){
                    msj= resul.getString("msj");
                    System.out.println(msj);
                }
            }catch(SQLException e){
                System.out.println("Error al llamar procedimiento");
            }
        }
        cont= Conecta.cierra(cont);
        Conecta.cierra();
    }
    /* MBD version 3.0 */
    public String[] buscaConsulta(String numeConsulta){
        cont= Conecta.Conecta();
        String[] nombreColums= {"Num_Consulta", "Nombre_Doc", "Nombre_Pac", "Peso", "Talla",
                                    "PerimetroAbdominal", "Temp", "TipoSangre", "GrupoSanguineo",
                                    "RH", "AgudezaVisual", "Onicomicosis", "FC", "FR"};
        String[] datosConsulta= new String[nombreColums.length];
        if(cont != null){
            try{
                procedure= cont.prepareCall("{CALL buscaPorConsulta(?)}");
                procedure.setInt(1, Integer.parseInt(numeConsulta));
                
                procedure.execute();
                resul= procedure.getResultSet();
                
                while(resul.next()){
                    for(int i= 0; i < datosConsulta.length; i++){
                        datosConsulta[i]= resul.getString(nombreColums[i]);
                    }
                }
            }catch(SQLException e){
                System.out.println("Error al llamar procedimiento");
            }
        }
        cont= Conecta.cierra(cont);
        Conecta.cierra();
        return datosConsulta;
    }
}
