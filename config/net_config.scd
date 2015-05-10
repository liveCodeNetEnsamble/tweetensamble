//LiveCodeNet Ensamble
//crea, coolabora, comparte tus SCtweets
/////
//conexion local History + NetAddr
NetAddr.broadcastFlag = true;
~n=NetAddr("255.255.255.255", ~puerto);//toda la mascara de subred
//
//para desplegar el contenido del WebView
~turl = NetAddr("tweetensamble.mixfuckedup.net", ~puerto);//direccion para logear y postear //
////aqui irian las direcciones de los usuarios(de alguna manera)

///
//~n.sendMsg(0.1,"hola");//envia tu nombre, ip, puerto a los demas

// Help.gui;