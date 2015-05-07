//LiveCodeNet Ensamble
//crea, coolabora, comparte tus SCtweets
/////
//conexion local History + NetAddr
//~all = NetAddr.broadcastFlag = true;
~n=NetAddr("255.255.255.255", ~puerto);//toda la mascara de subred
//
/////debug local:
~loopback = NetAddr("127.0.0.1", ~puerto); //para pruebas
//
//para desplegar el contenido del WebView
~turl = NetAddr("tweetensamble.mixfuckedup.net", ~puerto);//direccion para logear y postear //
////aqui irian las direcciones de los usuarios(de alguna manera)

///
// Help.gui;