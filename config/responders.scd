//LiveCodeNet Ensamble
//crea, coolabora, comparte tus SCtweets
//OSC responders
//////responde a nombre de usuario/////////
OSCdef(\usrs, { |msg, time, addr, recvPort|
	var maxitems,yo;
	yo = msg[1];
	maxitems = ~uid.size;
	if(yo.asString != ~miusuario,{//evito duplicarme
		if(~msgit == maxitems,{//si la lista esta llena
			("Users list full, User " ++ "'" ++ msg[1] ++ "'" ++ " wasn't added, maybe if someone disconnects").inform;//lista llena
			{(~url +/+ "gui/tweetensamble_input_gui.scd").load;
				~intxt.front;
				~textoin.string = "Users list full, User " ++ "'" ++ msg[1] ++ "'" ++ " wasn't added, maybe if someone disconnects";
			}.defer(0.1);
			~msgit = ~uid.size-1;
			},{
				var index = ~uid.find([nil]);
				~uid.put(index,[msg[1],msg[2]].join(": "));//une nombre + ip
				~othersip.put(index,msg[2]);//agrega solo IP en mismo index que lista
				{(~url +/+ "gui/tweetensamble_input_gui.scd").load;
					~intxt.front;
					~textoin.string = "User " ++ "'" ++ msg[1] ++ "'" ++ " was added to the list";
				}.defer(0.1);
		});
	},{
			//"ya no me auto agrego".postln
	});
	~msgit = ~msgit + 1;
},'/ensamble').fix;
//////elimina usuario al desconectarse/////////
OSCdef(\exit, { |msg, time, addr, recvPort|
	var index;
	{(~url +/+ "gui/tweetensamble_input_gui.scd").load;
		~intxt.front;
		~textoin.string = "User " ++ "'" ++ msg[1] ++ "'" ++ " is now offline ";
	}.defer(0.5);
	4.do{("User " ++ msg[1] ++ " is now offline ").inform};//lista llena
	index = ~othersip.find([msg[2]]);//busca la ip
	//~uid.put(indx,nil);
	//~othersip.put(indx,nil);
	index.postcln;
},'/desconecta').fix;
//////elimina usuario al cerrar applicacion
//falta terminar esto, da error al poner nil en el array
OSCdef(\close, { |msg, time, addr, recvPort|
	var indx;
	4.do{("You" ++ "'" ++ msg[1] ++ "'" ++ " are now disconnected ").inform};//lista llena
	indx = ~uid.find([msg[1]]);
	~uid.put(indx,nil);
	~othersip.put(indx,nil);
	msg[1].postln;
},'/off').fix;
//////envia texto a todos/////////
OSCdef(\input, { |msg, time, addr, recvPort|
	//[msg, time, addr, recvPort].postln;
	var quien = msg[2];
	if(quien.asString == ~miusuario, { // para no recibir mi propio mensaje
		//"ya existo".postc;
		},{
			{
				(~url +/+ "gui/tweetensamble_input_gui.scd").load;
				~intxt.front;
				~textoin.string = msg[1] ++ "\n//sent by @" ++ quien;
			}.defer(0.1);
		});
},'/enviotodos').fix;
///
OSCdef.trace(false);
//
// Help.gui;
/*local debug
~n.sendBundle(0.2,['/ensamble',"ricardo","192.168.0.101"]);//ingresa susario
~n.sendBundle(0.2,['/ensamble',"boox","192.168.100.19"]);//ingresa susario
~n.sendBundle(0.2,['/desconecta',"tabano","192.168.2.112"]);//borra usuario
~n.sendMsg('/enviotodos',"Este mensaje es para todos: blablablablabla...");//envia mensaje general
~n.sendBundle(0.1,['/enviotodos',"blablablablabla...",~miusuario]);//envia mensaje general
//
~uid
~othersip
*/
