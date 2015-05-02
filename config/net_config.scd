//LiveCodeNet Ensamble
//crea, coolabora, comparte tus SCtweets
/////
//conexion local History + NetAddr
~all = NetAddr.broadcastFlag = true;
~n.addrs = (0..~numusr).collect { |x| //array con distintos puertos
	NetAddr("255.255.255.255", ~puerto + x);//toda la mascara de subred
};
/////debug local:
~loopback = NetAddr("127.0.0.1", ~puerto); //
////
//twitter keys
~consumerkey= "";
~consumersecret= "";
~accesstoken= "";
~accesstokensecret="";
///
//para desplegar el contenido del WebView
~turl = NetAddr("weblab.mixfuckedup.net",~puerto);//direccion para logear y postear //
// Help.gui;