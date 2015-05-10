//LiveCodeNet Ensamble
//crea, coolabora, comparte tus SCtweets
//OSC responders
//////responde a nombre de usuario/////////
OSCdef(\usrs, { |msg, time, addr, recvPort|
	var maxitems,yo;
	yo = msg[1];
	maxitems = ~uid.size;
	if(yo.asString != ~miusuario,{
		if(~msgit > maxitems,{//si la lista esta llena
			"Users list full, User " ++ "'" ++ msg[1] ++ "'" ++ " wasn't added, maybe if someone disconnects".inform;//lista llena
			{(~url +/+ "gui/tweetensamble_input_gui.scd").load;
				~intxt.front;
				~textoin.string = "Users list full, User " ++ "'" ++ msg[1] ++ "'" ++ " wasn't added, maybe if someone disconnects";
			}.defer(0.1);
			~msgit = maxitems;
			},{
				~uid.put(~uid.find([nil]),[msg[1],msg[2]].join(": "));//va llenando la lista
				{(~url +/+ "gui/tweetensamble_input_gui.scd").load;
					~intxt.front;
					~textoin.string = "User " ++ "'" ++ msg[1] ++ "'" ++ " was added to the list";
				}.defer(0.1);
		});
	},{
			//"ya no me auto agregue".postln
	});
	~msgit = ~msgit + 1;
},'/ensamble').fix;
//////elimina usuario al desconectarse/////////
OSCdef(\exit, { |msg, time, addr, recvPort|
	var indx;
	{(~url +/+ "gui/tweetensamble_input_gui.scd").load;
		~intxt.front;
		~textoin.string = "User " ++ "'" ++ msg[1] ++ "'" ++ " is now offline ";
	}.defer(0.1);
	4.do{("User " ++ msg[1] ++ " is now offline ").inform};//lista llena
	indx = ~uid.find([[msg[1],msg[2]].join(": ")]);//busca la ip entrante "192.168.0.1"
	~uid.put(indx,nil);
},'/desconecta').fix;
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
~n.sendBundle(0.2,['/ensamble',"dos","192.168.0.2"]);//ingresa susario
~n.sendBundle(0.2,['/desconecta',"cinco","192.168.0.5"]);//borra usuario
~n.sendMsg('/enviotodos',"Este mensaje es para todos: blablablablabla...");//envia mensaje general
~n.sendBundle(0.1,['/enviotodos',"blablablablabla...",~miusuario]);//envia mensaje general

*/