//==========================================
// LiveCodeNet Ensamble
// Crea, colabora y comparte tus SCtweets
// Se necesita conexión a internet
//==========================================

// Evalua la siguiente función, antes cambia la ruta de tweetensamble:

(
s.waitForBoot {
// 1. Cambia la ruta del directorio de /tweetensamble a donde lo clonaste
	~url="/home/ruta/tweetensamble/";
// No edites la siguiente línea de código
	(~url ++ "content/load.scd").load;
	}
);