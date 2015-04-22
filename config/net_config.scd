//LiveCodeNet Ensamble
//crea, coolabora, comparte tus SCtweets
/////
//conexion local History + NetAddr
NetAddr.broadcastFlag = true;
~n.addrs = (0..~numusr).collect { |x|
	~netall = NetAddr("255.255.255.255", ~puerto + x);
};
////////////////////
/////debug local:
~loopback = NetAddr("127.0.0.1", ~puerto); //
//////responde a nombre de usuario/////////
OSCdef(\tweet, { |msg, time, addr, recvPort,i|
	//[msg,recvPort].postcln;
	//falta recibir el id de cada conexion(nombre de usuario y postearlo en la lista
	//rellena ese array con los nombres de usuarios
	~uid.put(i,msg);
	i = i + 1;
	//esto deberia incrustar el array con la lista de usuarios capturados
	//~usrlist.setString(~uid.join,~miususario.size + 1,~uid.join.size);
	i.postcln;
},'/ensamble').fix;
//
///
////
//para desplegar el contenido del WebView
~turl = NetAddr("www.twitter.com",~puerto);//direccion para logear y postear
///
//Help.gui;