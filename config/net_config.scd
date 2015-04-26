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
	var maxitems,indx,twodindx;
	maxitems = ~numusr - 1;
	if(~msgit >= maxitems,{//si la lista esta llena, busca por ip
		"Users list full, replacing user name by ip".inform;//lista llena
		indx = ~uid.find([[msg[2]]]);//busca la ip entrante "192.168.0.1"
		indx.postcln;
		/*
		twodindx = [indx - 1,indx] ;//indx entre dos resulta el grupo del id
		~uid.put( twodindx[0] ,[msg[1]]);
		~uid.put( twodindx[1] ,[msg[2]]);
		//~uid.replace(indx-1,"soy nuevo");//menos uno por el orden de lensaje usr->ip
		*/
		},{
			~uid.put(~uid.find([nil]),[msg[1],msg[2]].join(": "));//va llenando la lista
	});
	~msgit = ~msgit + 1;
	//[twodindx[0],indx,twodindx[1]].postcln;
},'/ensamble').fix;
// enviar [ip,~miusuario,id]
~loopback.sendBundle(0.2,['/ensamble',"karlita","192.168.0.5"]);
~loopback.sendBundle(0.2,['/desconecta',"karlita","192.168.0.5"]);
//~uid.find(["192.168.0.3"]);
// ~uid.postln;
//////elimina usuario al desconectarse/////////
OSCdef(\snd, { |msg, time, addr, recvPort|
	var indx;
	4.do{"User " ++ msg[1] ++ " is now offline ".inform};//lista llena
	indx = ~uid.find([[msg[1],msg[2]].join(": ")]);//busca la ip entrante "192.168.0.1"
	indx.postcln;
},'/desconecta').fix;
//////envia texto a todos/////////
OSCdef(\snd, { |msg, time, addr, recvPort|
	{~texto.string = msg[1] ++ "\n//sent by @" ++ ~miusuario;}.defer(0.1);
},'/enviotodos').fix;
///
////
//para desplegar el contenido del WebView
~turl = NetAddr("www.twitter.com",~puerto);//direccion para logear y postear
///
a = (0..10) ++ (0..10);
a.replace([4, 5, 6], 100);
a.replace([4, 5, 6], [1734, 1985, 1860]);
// Help.gui;