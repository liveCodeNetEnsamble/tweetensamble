//LiveCodeNet Ensamble
//crea, coolabora, comparte tus SCtweets
//
(
s.waitForBoot {
///////////configura la ruta del directorio de la aplicacion///////////
	~url="/home/josecaos/Documents/Repos/tweetensamble/";
	(~url ++ "assets/load.scd").load;
}
)
Help.gui;