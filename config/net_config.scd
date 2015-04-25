//LiveCodeNet Ensamble
//crea, coolabora, comparte tus SCtweets
/////
/*
//conexion local History + NetAddr
NetAddr.broadcastFlag = true;
~n.addrs = (0..~numusr).collect { |x|
	~netall = NetAddr("255.255.255.255", ~puerto + x);
};
*/
~loopback.ip
~n.post
////////////////////
/////debug local:
~loopback = NetAddr("127.0.0.1", ~puerto); //
//////responde a nombre de usuario/////////
OSCdef(\tweet, { |msg, time, addr, recvPort,i|
	//[msg,recvPort].postcln;
	~uid.put(~msgit,msg[1] ++ ~msgit);
	~msgit = ~msgit + 1;
	//~msgit.postcln;
},'/ensamble').fix;
//
///
////
//para desplegar el contenido del WebView
~turl = NetAddr("www.twitter.com",~puerto);//direccion para logear y postear
///
//Help.gui;