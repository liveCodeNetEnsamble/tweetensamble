//LiveCodeNet Ensamble
//crea, coolabora, comparte tus SCtweets
/////
//conexion local History + NetAddr
~all = NetAddr.broadcastFlag = true;
~n.addrs = (0..~numusr).collect { |x| //array con distintos puertos
	NetAddr("255.255.255.255", ~puerto + x);//toda la mascara de subred
};
////////////////////
/////debug local:
~loopback = NetAddr("127.0.0.1", ~puerto); //
//////responde a nombre de usuario/////////
OSCdef(\usrs, { |msg, time, addr, recvPort|
	if(~msgit >= ~numusr,{//si la lista esta llena, busca por ip
		"Users list full".inform;
		var search = ~uid.find(["pandota"]);
		~uid.put(search,["pandota","192.168.0.5","soy nuevo"]);
		},{
			~uid.put(~uid.find([nil]),[msg[1],msg[2]].join(", "));//va llenando la lista
	});
	~msgit = ~msgit + 1;
},'/ensamble').fix;
// enviar [ip,~miusuario,id]
~loopback.sendBundle(0.2,['/ensamble',"pand","192.168.0.4",~puerto]);
// ~uid.postln;
//
///
////
//para desplegar el contenido del WebView
~turl = NetAddr("www.twitter.com",~puerto);//direccion para logear y postear
///
//Help.gui;