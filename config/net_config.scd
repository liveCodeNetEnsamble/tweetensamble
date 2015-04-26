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
	msg[1].postcln;
	if(~msgit > ~numusr,{"Users list full".inform;~msgit=0},{
		~uid.put(~uid.find([nil]),msg[1]);
	});
	~msgit = ~msgit + 1;
},"/ensamble").fix;
// enviar [ip,~miusuario,id]
~loopback.sendMsg("/ensamble",~miusuario);
//~uid.postln;
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