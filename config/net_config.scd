//LiveCodeNet Ensamble
//crea, coolabora, comparte tus SCtweets
/////
//conexion local History + NetAddr
NetAddr.broadcastFlag = true;
~n.addrs = (0..~numusr).collect { |x| //array con distintos puertos
	NetAddr("255.255.255.255", ~puerto + x);//toda la mascara de subred
};
////////////////////
/////debug local:
~loopback = NetAddr("127.0.0.1", ~puerto); //
//////responde a nombre de usuario/////////
OSCdef(\usrs, { |msg, time, addr, recvPort|
	~uid.put(~msgit,msg[1] ++ ~msgit);//llena array de usuarios
	~msgit = ~msgit + 1;
	[msg,recvPort].postcln;
	//~msgit.postcln;
},'/ensamble').fix;
// enviar [ip,~miusuario,id]
Task({//escucha por nuevos usuarios cada segundo
	({

		1.wait;
	}).loop;
});
//
///
////
//para desplegar el contenido del WebView
~turl = NetAddr("www.twitter.com",~puerto);//direccion para logear y postear
///
//Help.gui;