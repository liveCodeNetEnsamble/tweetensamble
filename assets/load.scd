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
//mi variable
~miusuario = nil;
//numero de usuarios
~numusr = 4;
//variable para compartir
~comparte = nil;
//iterador
~fileit = 0 ;
//conexion local
~n = ();
~puerto=57120;
////////terminan variables globales/////////////
//aqui las rutas de los archivos ligados al arranque
(~url ++ "gui/tweetensamble_gui.scd").load;
(~url ++ "config/net_config.scd").load;