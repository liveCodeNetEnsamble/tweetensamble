//LiveCodeNet Ensamble
//crea, coolabora, comparte tus SCtweets
//OSC responders
//////responde a nombre de usuario/////////
OSCdef(\usrs, { |msg, time, addr, recvPort|
	var maxitems,indx,twodindx;
	maxitems = ~numusr - 1;
	if(~msgit > maxitems,{//si la lista esta llena, busca por ip
		"Users list full, User " ++ msg[1] ++ " wasn't added, maybe if some one disconnects".inform;//lista llena
		{(~url +/+ "gui/tweetensamble_input_gui.scd").load;
			~intxt.front;
			~textoin.string = "Users list full, User " ++ msg[1] ++ " wasn't added, maybe if someone disconnects";
		}.defer(0.1);
		~msgit = maxitems;
		},{
			~uid.put(~uid.find([nil]),[msg[1],msg[2]].join(": "));//va llenando la lista
			{(~url +/+ "gui/tweetensamble_input_gui.scd").load;
				~intxt.front;
				~textoin.string = "User " ++ msg[1] ++ " was added to the list";
			}.defer(0.1);
	});
	~msgit = ~msgit + 1;
},'/ensamble').fix;
/*local debug
~loopback.sendBundle(0.2,['/ensamble',"Koarlita","192.168.0.111"]);//ingresa susario
~loopback.sendBundle(0.2,['/desconecta',"Koarlita","192.168.0.111"]);//borra usuario
~loopback.sendMsg('/enviotodos',"Este mensaje es para todos: blablablablabla...");//envia mensaje general
*/
//////elimina usuario al desconectarse/////////
OSCdef(\exit, { |msg, time, addr, recvPort|
	var indx;
	{(~url +/+ "gui/tweetensamble_input_gui.scd").load;
	~intxt.front;
		~textoin.string = "User " ++ msg[1] ++ " is now offline ";}.defer(0.1);
	4.do{("User " ++ msg[1] ++ " is now offline ").inform};//lista llena
	indx = ~uid.find([[msg[1],msg[2]].join(": ")]);//busca la ip entrante "192.168.0.1"
	~uid.put(indx,nil);
},'/desconecta').fix;
//////envia texto a todos/////////
OSCdef(\snd, { |msg, time, addr, recvPort|
	{
		(~url +/+ "gui/tweetensamble_input_gui.scd").load;
		~intxt.front;
		~textoin.string = msg[1] ++ "\n//sent by @" ++ ~miusuario;}.defer(0.1);
},'/enviotodos').fix;
///