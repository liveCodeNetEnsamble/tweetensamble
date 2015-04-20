//LiveCodeNet Ensamble
//crea, coolabora, comparte tus SCtweets
//variables globales e inicializacion
/////////al iniciar//////////
8.do{|i=1|
	var x = (i/16);
	play{EnvGen.ar(Env.perc(0.01,0.05+x),doneAction:2)*LFPulse.ar(i*200,0.05,0.5,0.05)!2};
	"Tweetensamble es una herramienta para crear SCTweets coolaborativos".post;
	i+1;
	0.125+x.wait;
};
//
//mi variable
~miusuario = nil;
//variable para compartir
~comparte = nil;
//
(~url ++ "gui/tweetensamble_gui.scd").load;