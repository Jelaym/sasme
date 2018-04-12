package Doctor;

import BD.cConectaBD;
import BD.cDatosSaker;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.CallableStatement; /*PROCEDIMIENTOS*/
import java.sql.Statement; /*VIEWS*/
import java.sql.ResultSet;

/**
 *
 * @author David Madrigal Buendía
 */
public class cDoctor {
    cConectaBD Conecta;
    Connection cont;
    CallableStatement procedure;
    Statement vista;
    ResultSet resul;
    
    public cDoctor(){
        Conecta= new cConectaBD("servicio_medico");
        cont= null;
        procedure= null;
    }
    /*AGREGA DOCTORES*/
    public String insertaDoctor(String nombre, String contra, String usuario, String[] dias, int horaInicio, int horaTermino,
            String tipoDoctor, String sexo,String Mail,String Celular,String[] Permisos){
        String msj= "";
        String todosDias = "";
        String nota = "";
        for(int j=0;j<dias.length;j++){
            todosDias+= nota+dias[j];
            nota=",";
        }
        cont= Conecta.Conecta();
        if(cont != null){
            try{
                cDatosSaker sk = new cDatosSaker();
                sk.conectar();
                sk.insertar("call AgregaUsr('"+usuario+"','"+contra+"');");
                sk.cierraConexion();
                
                procedure= cont.prepareCall("{CALL agregaDoctor(?,?,?,?,?,?,?)}");
                procedure.setString(1, nombre);
                procedure.setString(2, usuario);
                procedure.setString(3, todosDias);
                procedure.setInt(4, horaInicio);
                procedure.setInt(5, horaTermino);
                procedure.setString(6, tipoDoctor);
                procedure.setString(7, sexo);

                procedure.execute();
                resul= procedure.getResultSet();

                while(resul.next()){
                    //msj= resul.getString("msj");
                }
                //Contacto
                procedure= cont.prepareCall("CALL agregaContacto(?,?,?)");
                procedure.setString(1, usuario);
                procedure.setInt(2,1);
                procedure.setString(3,Mail);

                procedure.execute();
                procedure= cont.prepareCall("CALL agregaContacto(?,?,?)");
                procedure.setString(1, usuario);
                procedure.setInt(2,2);
                procedure.setString(3,Celular);

                procedure.execute();
                
                procedure= cont.prepareCall("CALL agregaPermisoDoctor(?,?)");
                
                for(int i=0;i<Permisos.length;i++){
                    procedure.setString(1, usuario);
                    procedure.setInt(2,Integer.parseInt(Permisos[i]));
                    procedure.execute();
                }
                
            }catch(Exception e){
                System.out.println("Error al llamar procedimientos - insertaDoctor - cDoctor");
                System.out.println(e.getMessage());
                msj=e.getMessage();
            }
            cont= Conecta.cierra(cont);
            Conecta.cierra();
            System.out.println(msj);
        }
        return msj;
    }
    /*TRAE TODOS LOS DOCTORES*/
    public String[][] DoctoresTotales(){
        String[][] doctores= new String[0][0]; 
        String nombreVista= "todoDoctores";
        String nombreVista2= "contactoDoctores";
        String vistaMaxDoc= "maxDoctores";
        cont= Conecta.Conecta();
        int valores, nume, maxDoc, maxVal;
        nume= valores= maxDoc= maxVal= 0;
        if(cont  != null){
            try{
                vista= cont.createStatement();
                resul= vista.executeQuery("SELECT * FROM " + vistaMaxDoc);
                while(resul.next()){
                    maxDoc= Integer.parseInt(resul.getString("Num_Doctor"));
                    maxVal= 9;
                }
                doctores= new String[maxDoc][maxVal];
                try{
                    vista= cont.createStatement();
                    resul= vista.executeQuery("SELECT * FROM " + nombreVista);

                    String[] nombreColums= {"Num_Doctor","Nombre","Usuario","Dias_Laborales","Hora_Entrada",
                                            "Hora_Salida","Tipo_Doctor","Genero"};
                    
                    while(resul.next()){
                        for(valores= 0; valores < nombreColums.length; valores++){
                            doctores[nume][valores]= resul.getString(nombreColums[valores]);
                            System.out.println(doctores[nume][valores]);
                        }
                        nume++;
                    }
                }catch(SQLException e){
                    System.out.println("Error al llamar vista");
                    System.out.println(e.getMessage());
                }
            }catch(SQLException e){
                System.out.println("Error al declarar el maximo del String");
            }
        }
        cont= Conecta.cierra(cont);
        Conecta.cierra();
        
        return doctores;
    }
    /*TRAE TODOS LOS CONTACTOS*/
    public String[] ContactoDoctores(){
        String[] contactos= new String[0];
        String vistaContacto= "contactoDoctores";
        String maxContacto= "maxContacto";
        cont= Conecta.Conecta();
        
        if(cont  != null){
            try{
                vista= cont.createStatement();
                resul= vista.executeQuery("SELECT * FROM " + maxContacto);
                int max= 0;
                while(resul.next()){
                    max= Integer.parseInt(resul.getString("MaxContacto"));
                    System.out.println(max);
                }
                contactos= new String[max];
                resul= vista.executeQuery("SELECT * FROM " + vistaContacto);
                int i= 0;
                while(resul.next()){
                    contactos[i]= resul.getString("Num_Doctor") + "," + resul.getString("Tipo_Contacto") + "," + resul.getString("Contacto");
                    System.out.println(contactos[i]);
                    i++;
                }
            }catch(SQLException e){
                System.out.println("Error al declarar el maximo del String");
            }
        }
        cont= Conecta.cierra(cont);
        Conecta.cierra();
        
        return contactos;
    }
    /*BUSCA UN SOLO DOCTOR*/
    public String[] buscaDoctor(String usuarioDoctor){
        String[] nombreColums= {"Num_Doctor","Nombre","Usuario","Dias_Laborales","Hora_Entrada",
                                            "Hora_Salida","Tipo_Doctor","Genero","Permisos"};
        String[] doctor= new String[nombreColums.length];
        String proce= "buscaDoctor";
        cont= Conecta.Conecta();
        if(cont != null){
            String msj= "";
            try{
                procedure= cont.prepareCall("{CALL " + proce + "(?)}");
                procedure.setString(1, usuarioDoctor);
                
                procedure.execute();
                resul= procedure.getResultSet();
                
                int numero= 1;
                
                while(resul.next()){
                    for(int i= 0; i < nombreColums.length; i++){
                        doctor[i]= resul.getString(nombreColums[i]);
                        if(nombreColums.equals("Num_Doctor")){
                            numero= Integer.parseInt(doctor[i]);
                            if(numero == 0){
                                i= nombreColums.length;
                            }
                        }
                        System.out.println(doctor[i]);
                    }
                }
                /* Valida si el doctor existe o no */
                if(numero == 0){
                    System.out.println("El doctor no existe");
                    doctor= new String[1];
                    doctor[0]= "No existe";
                }
            }catch(SQLException e){
                System.out.println("Error al llamar procedimiento");
            }
        }
        cont= Conecta.cierra(cont);
        Conecta.cierra();
        
        return doctor;
    }
    /*BUSCA UN SOLO CONTACTO DE UN SOLO DOCTOR*/
    public String[] buscaContactoDoctor(String usuarioDoctor){
        String[] contactos= new String[0];
        String proce= "buscaDoctorContactos";
        String maxContacto= "maxContacto";
        cont= Conecta.Conecta();
        if(cont != null){
            String msj= "";
            try{
                vista= cont.createStatement();
                resul= vista.executeQuery("SELECT * FROM " + maxContacto);
                int max= 0;
                while(resul.next()){
                    max= Integer.parseInt(resul.getString("MaxContacto"));
                    System.out.println(max);
                }
                contactos= new String[max];
                
                procedure= cont.prepareCall("{CALL " + proce + "(?)}");
                procedure.setString(1, usuarioDoctor);
                
                procedure.execute();
                resul= procedure.getResultSet();
                int i= 0;
                while(resul.next()){
                    contactos[i]= resul.getString("Contacto");
                    System.out.println(contactos[i]);
                    i++;
                }
            }catch(SQLException e){
                System.out.println("Error al llamar procedimiento");
            }
        }
        cont= Conecta.cierra(cont);
        Conecta.cierra();
        return contactos;
    }
    /*MODIFICA UN DOCTOR*/
    public void modificaDoctor(String nombre, String contra, String usuario, String dias, int horaInicio, int horaTermino, String tipoDoctor, String sexo){
        cont= Conecta.Conecta();
        
        if(cont != null){
            String msj= "";
            try{
                procedure= cont.prepareCall("{CALL modificaDoctor(?,?,?,?,?,?,?,?)}");
                procedure.setString(1, nombre);
                procedure.setString(2, contra);
                procedure.setString(3, usuario);
                procedure.setString(4, dias);
                procedure.setInt(5, horaInicio);
                procedure.setInt(6, horaTermino);
                procedure.setString(7, tipoDoctor);
                procedure.setString(8, sexo);
                
                procedure.execute();
                resul= procedure.getResultSet();
                
                while(resul.next()){
                    msj= resul.getString("msj");
                }
            }catch(SQLException e){
                System.out.println("Error al llamar procedimiento");
            }
        }
        
        cont= Conecta.cierra(cont);
        Conecta.cierra();
    }
}
