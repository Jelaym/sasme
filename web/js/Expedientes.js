function irConsulta(numero){
    alert(numero);
    /* Aqu� poner para descargar consulta */
}
function getGET()
{
    // capturamos la url
    var loc = document.location.href;
    // si existe el interrogante
    if(loc.indexOf('?')>0)
    {
        // cogemos la parte de la url que hay despues del interrogante
        var getString = loc.split('?')[1];
        // obtenemos un array con cada clave=valor
        var GET = getString.split('&');
        var get = {};
        // recorremos todo el array de valores
        for(var i = 0, l = GET.length; i < l; i++){
            var tmp = GET[i].split('=');
            get[tmp[0]] = unescape(decodeURI(tmp[1]));
        }
        return get;
    }
}

window.onload = function ()
{
    //AGREGADO PARA PASAR VARIABLE
    var valores= getGET();
    if(valores)
    {
        //recogemos los valores que nos envia la URL en variables para trabajar con ellas
        var alerta = valores['a'];

        //SE CREAN LOS OBJETOS BOLETA O RFC
        if(alerta === "E"){
            alert("Paciente no encontrado");
        }
    }
};