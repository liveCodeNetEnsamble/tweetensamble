//LiveCodeNet Ensamble
//crea, coolabora, comparte tus SCtweets
//variables globales e inicialización
/////////al iniciar://////////
11.do{|i=1|
	var x = (i/16);
	play{EnvGen.ar(Env.perc(0.01,0.05+x),doneAction:2)*LFPulse.ar(i*200,0.05,0.5,0.01)!2};
	if( i>=10,{" ...Tweetensamble is a tool to create coolaborative SCTweets".post;},
		{"Tweetensamble is a tool to create coolaborative SCTweets".scramble.post;}
	);
	i+1;
	0.125+x.wait;
};
/////////////////////
// defaults
////////////////////
//iteradores
~fileit = 0 ;//guarda archivos con distinto nombre
~msgit = 0;// llena array de usuarios
//ususarios
~numusr = 0;//numero de usuarios,localhost siempre es index 0
~miusuario = nil;//mi nombre
~mip = nil;
~uid = nil;//lista de usuarios //no contiene usuario local
~othersip = nil;// array de ips de usuarios conectados
~comparte = nil;//se iguala
//conexion local
//~n = ();//array de netaddrs usuarios
~puerto = 57120;//puerto base
~turl = nil;//conexion a twitter
~uurl = [];//array usuarios
~tituloweb = nil;//titulo WebView
//twitter
~server = nil;//"tweetensamble.mixfuckedup.net";
////////terminan variables globales/////////////
//aqui las rutas de los archivos ligados al arranque
(~url +/+ "content/net_config.scd").load;
(~url +/+ "content/responders.scd").load;
(~url +/+ "content/functions.scd").load;
(~url +/+ "gui/tweetensamble_input_gui.scd").load;
//(~url +/+ "gui/login_gui.scd").load;
(~url +/+ "gui/tweetensamble_gui.scd").load;