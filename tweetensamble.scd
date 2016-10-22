//==========================================
// LiveCodeNet Ensamble
// Crea, colabora y comparte tus SCtweets
// Se necesita conexión a internet
//==========================================

// Evalua la siguiente función, antes cambia la ruta de tweetensamble:

(
s.waitForBoot {
	~url = thisProcess.nowExecutingPath.dirname;
//
	(~url ++ "content/load.scd").load;
	}
);