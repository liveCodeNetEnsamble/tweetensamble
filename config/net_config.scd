//LiveCodeNet Ensamble
//crea, coolabora, comparte tus SCtweets
/////
//Toda la red
NetAddr.broadcastFlag = true;
~n=NetAddr("255.255.255.255", ~puerto);//toda la mascara de subred
//A un usuario
//~comparte = ~othersip[~msgmenu.value];//relaciona array de lista con array de IPs
~direct=NetAddr(~comparte,~puerto);
//para desplegar el contenido del WebView
~turl = NetAddr("tweetensamble.mixfuckedup.net", ~puerto);//direccion para logear y postear //
//
// Help.gui;