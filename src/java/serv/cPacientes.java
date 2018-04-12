package serv;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.CallableStatement; /*PROCEDIMIENTOS*/
import java.sql.Statement; /*VIEWS*/
import java.sql.ResultSet;
import BD.cConectaBD;
/**
 *
 * @author David Madrigal Buendía (Touchier)
 * @version 2.0
 */
public class cPacientes {
    cConectaBD Conecta;
    Connection cont;
    CallableStatement procedure;
    Statement vista;
    ResultSet resul;
    
    public cPacientes(){
        Conecta= new cConectaBD("servicio_medico");
        cont= null;
        procedure= null;
        vista= null;
    }
    
    public void insertaPaciente(String nombre, String institucion, String sexo, int edad, String nss, String tipoPaciente, String identificador){
        cont= Conecta.Conecta();
        if(cont != null){
            String msj= "";
            try{
                procedure= cont.prepareCall("{CALL agregaPaciente(?,?,?,?,?,?,?)}");
                procedure.setString(1, nombre);
                procedure.setString(2, institucion);
                procedure.setString(3, sexo);
                procedure.setInt(4, edad);
                procedure.setString(5, nss);
                procedure.setString(6, tipoPaciente);
                procedure.setString(7, identificador);
                
                procedure.execute();
                resul= procedure.getResultSet();
                
                while(resul.next()){
                    msj= resul.getString("msj");
                }
            }catch(SQLException e){
                System.out.println("Error al llamar procedimiento");
            }
            System.out.println(msj);
        }
        cont= Conecta.cierra(cont);
        Conecta.cierra();
    }
    
    public String[][] PacientesTotales(){
        String[][] pacientes= new String[0][0]; 
        String nombreVista= "todoPacientes";
        String vistaMaxDoc= "maxPacientes";
        cont= Conecta.Conecta();
        int valores, nume, maxDoc, maxVal;
        nume= valores= maxDoc= maxVal= 0;
        if(cont  != null){
            try{
                vista= cont.createStatement();
                resul= vista.executeQuery("SELECT * FROM " + vistaMaxDoc);
                while(resul.next()){
                    maxDoc= Integer.parseInt(resul.getString("Num_Paciente"));
                    maxVal= 6;
                }
                pacientes= new String[maxDoc][maxVal];
                try{
                    vista= cont.createStatement();
                    resul= vista.executeQuery("SELECT * FROM " + nombreVista);

                    String[] nombreColums= {"Num_Paciente","Nombre","NSS","Edad","Institucion","Genero"};
                    
                    while(resul.next()){
                        for(valores= 0; valores < nombreColums.length; valores++){
                            pacientes[nume][valores]= resul.getString(nombreColums[valores]);
                            System.out.println(pacientes[nume][valores]);
                        }
                        nume++;
                    }
                }catch(SQLException e){
                    System.out.println("Error al llamar vista");
                }
            }catch(SQLException e){
                System.out.println("Error al declarar el maximo del String");
            }
        }
        cont= Conecta.cierra(cont);
        Conecta.cierra();
        
        return pacientes;
    }
    
    public String[] buscaPaciente(String nss){
        /*Por posición en este arreglo se guardara el dato en el string[] doctor*/
        String[] nombreColums= {"Num_Paciente","Nombre","NSS","Edad","Institucion","Genero"};
        String[] paciente= new String[nombreColums.length];
        String proce= "buscaPaciente";
        cont= Conecta.Conecta();
        paciente[0]= "0";
        if(cont != null){
            String msj= "";
            try{
                procedure= cont.prepareCall("{CALL " + proce + "(?)}");
                procedure.setString(1, nss);
                
                procedure.execute();
                resul= procedure.getResultSet();
                
                int numero= 1;
                
                while(resul.next()){
                    for(int i= 0; i < nombreColums.length; i++){
                        paciente[i]= resul.getString(nombreColums[i]);
                        if(nombreColums.equals("Num_Paciente")){
                            numero= Integer.parseInt(paciente[i]);
                            if(numero == 0){
                                i= nombreColums.length;
                            }
                        }
                        System.out.println(paciente[i]);
                    }
                }
                /* Valida si el doctor existe o no */
                /*if(numero == 0){
                    System.out.println("El paciente no existe");
                    paciente= new String[1];
                    paciente[0]= "";
                }*/
            }catch(SQLException e){
                System.out.println("Error al llamar procedimiento");
            }
        }
        cont= Conecta.cierra(cont);
        Conecta.cierra();
        
        return paciente;
    }
    
    public void modificaPaciente(String nombre, String institucion, String sexo, int edad, String nss, String tipoPaciente, String identificador){
        cont= Conecta.Conecta();
        
        if(cont != null){
            String msj= "";
            try{
                procedure= cont.prepareCall("{CALL modificaPaciente(?,?,?,?,?,?,?)}");
                procedure.setString(1, nombre);
                procedure.setString(2, institucion);
                procedure.setString(3, sexo);
                procedure.setInt(4, edad);
                procedure.setString(5, nss);
                procedure.setString(6, tipoPaciente);
                procedure.setString(7, identificador);
                
                procedure.execute();
                resul= procedure.getResultSet();
                
                while(resul.next()){
                    msj= resul.getString("msj");
                }
            }catch(SQLException e){
                System.out.println("Error al llamar procedimiento");
            }
            System.out.println(msj);
        }
        
        cont= Conecta.cierra(cont);
        Conecta.cierra();
    }
    /* VERSIÓN 2 -------------------------------------------------------------------------------------------------- */
    public String[][] consultasDeUnPaciente(String nss){
        String[] nombreColums= {"Num_Consulta","Fecha","TipoConsulta","Num_Doctor","Observaciones"};
        String[][] consultas= new String[maxConsultaPaciente(nss)][nombreColums.length];
        String proce= "buscaConsultasPaciente";
        cont= Conecta.Conecta();
        if(cont != null){
            String msj= "";
            try{
                procedure= cont.prepareCall("{CALL " + proce + "(?)}");
                procedure.setString(1, nss);
                
                resul= procedure.executeQuery();
                int conta= 0;
                while(resul.next()){
                    for(int i= 0; i < consultas[0].length; i++){
                        consultas[conta][i]= resul.getString(nombreColums[i]);
                    }
                    conta++;
                }
            }catch(SQLException e){
                System.out.println("Error al llamar procedimiento");
            }
        }
        return consultas;
    }
    public int maxConsultaPaciente(String nss){
        String proce= "maxConsultasPaciente";
        int max= 0;
        cont= Conecta.Conecta();
        if(cont != null){
            String msj= "";
            try{
                procedure= cont.prepareCall("{CALL " + proce + "(?)}");
                procedure.setString(1, nss);
                
                resul= procedure.executeQuery();
                while(resul.next()){
                    max= Integer.parseInt(resul.getString("Total"));
                }
            }catch(SQLException e){
                System.out.println("Error al llamar procedimiento");
            }
        }
        return max;
    }
    
    public String[] ultimoTratamiento(String nss){
        String[] nombreColums= {"Num_Plan","Num_Consulta","Fecha"};
        String[] referencia= new String[nombreColums.length];
        String proce= "ultimoTratamientoPac";
        referencia[0]= "";
        if(cont != null){
            try{
                procedure= cont.prepareCall("{CALL " + proce + "(?)}");
                procedure.setString(1, nss);
                
                resul= procedure.executeQuery();
                while(resul.next()){
                    for(int i= 0; i < nombreColums.length; i++){
                        referencia[i]= resul.getString(nombreColums[i]);
                    }
                }
            }catch(SQLException e){
                System.out.println("Error al llamar procedimiento");
            }
        }
        return referencia;
    }
}
