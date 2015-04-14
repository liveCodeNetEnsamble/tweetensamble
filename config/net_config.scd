//LiveCodeNet Ensamble
//crea, coolabora, comparte tus SCtweets
//acustweet History + NetAddr
~q = ();
NetAddr.broadcastFlag = true;
~q.addrs = (0..7).collect { |x|
	NetAddr("255.255.255.255", 57120 + x)
};
~q.sendAll = { |q ... args|
	q.addrs.do { |addr|
	addr.sendMsg(*args)
}; ""
}
////////////////////
History.start;
History.makeWin;
OSCdef(\hist, { |msg|
History.enter(msg[2].asString,msg[1]);
}, \hist).fix;
History.localOff;
History.forwardFunc = { |code|
q.sendAll(\hist, ~miusuario, code);
};
//