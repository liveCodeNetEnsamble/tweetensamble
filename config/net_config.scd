//LiveCodeNet Ensamble
//crea, coolabora, comparte tus SCtweets
/////
/*
twitter IPs
199.59.148.82
199.59.150.7
199.59.149.198
199.59.150.39
*/
//conexion local History + NetAddr
NetAddr.broadcastFlag = true;
~n.addrs = (0..~numusr).collect { |x|
	NetAddr("255.255.255.255", ~puerto + x);
	x.postln;
};
~n.sendAll = { |q ... args|
	q.addrs.do { |addr|
	addr.sendMsg(*args)
}; ""
}
////////////////////
History.start;
//History.makeWin;
OSCdef(\hist, { |msg|
History.enter(msg[2].asString,msg[1]);
}, \hist).fix;
//History.localOff;
History.forwardFunc = { |code|
~n.sendAll(\hist, ~miusuario, code);
};
//
///
////
//para desplegar el contenido del SCnavegador
~turl = NetAddr("",~puerto);//direccion para logear y postear
~uurl = "";//url de usuario
///
//Help.gui;