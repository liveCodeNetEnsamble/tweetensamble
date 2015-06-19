//==========================================
// LiveCodeNet Ensamble
// Crea, coolabora, comparte tus SCtweets
//Se necesita conexion a internet
//==========================================

//Evalua la siguiente funcion:
(
s.waitForBoot {
///////////Configura la ruta del directorio de 'tweetensamble'///////////
	~url="/home/josecaos/Documents/tweetensamble/";
	///////Y Evalua la funcion//////////////////////////////////////////////
	///////////////////////////////////////////////////////////////////////
	////////////no editar/////////////////////////////////////////////////
	(~url ++ "content/load.scd").load;
	}
);