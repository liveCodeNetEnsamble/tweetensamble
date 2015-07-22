//==========================================
// LiveCodeNet Ensamble
// Crea, colabora y comparte tus SCtweets
// Se necesita conexión a internet
//==========================================

// Evalua la siguiente función:
(
s.waitForBoot {
// 1. Configura la ruta del directorio de 'tweetensamble'//
	~url="/home/josecaos/Documents/tweetensamble/";
	// 2. Evalua la función //
// No edites la siguiente línea de código //
	(~url ++ "content/load.scd").load;
	}
);