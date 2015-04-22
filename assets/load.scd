//LiveCodeNet Ensamble
//crea, coolabora, comparte tus SCtweets
//variables globales e inicializacion
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
//variables globales
////////////////////
//iteradores
~fileit = 0 ;//guarda archivos con distinto nombre
//ususarios
~numusr = 4;//numero de usuarios
~miusuario = nil;//mi variable
~uid = Array.newClear(~numusr);//lista de usuarios
~comparte = nil;//variable para compartir
//conexion local
~n = ();//array de netaddrs usuarios
~puerto=57120;//puerto base
~netall;//red de todos
~turl;//conexion a twitter
~uurl = [];//array usuarios
////////terminan variables globales/////////////
//aqui las rutas de los archivos ligados al arranque
(~url ++ "gui/tweetensamble_gui.scd").load;
(~url ++ "config/net_config.scd").load;