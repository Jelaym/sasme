/* 
 * David Madrigal Buendía (Touchier)
 * OwlVirTech
 */

var tipo= "";
function tipoIdentificador(usuario){
    if(usuario === "Estudiante"){
        cambiaTipo(usuario);
    }else{
        if(usuario === "Docente"){
            cambiaTipo(usuario);
        }else{
            if(usuario === "Externo"){
                cambiaTipo(usuario);
            }else{
                document.getElementById("parte2").className="esconde";
                alert("Elige un tipo de usuario.");
            }
        }
    }
}
function cambiaTipo(usuario){
    document.getElementById("parte2").className="aparece";
    tipo= usuario;
}
