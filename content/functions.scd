//LiveCodeNet Ensamble
//crea, coolabora, comparte tus SCtweets
//Declaracion de variables y funciones
//////////////////////////////////////
//estoy vivo
~rutina=Routine{
	loop{~n.sendBundle(0.1,['/ensamble',~miusuario,~mip,~puerto]);
		0.5.wait};
};
//