//==========================================
// LiveCodeNet Ensamble
// Crea, colabora y comparte tus SCtweets
// Se necesita conexión a internet
//==========================================

// Evalúa la siguiente función:

(
s.waitForBoot {
	~url = thisProcess.nowExecutingPath.dirname;
	(~url +/+ "content/load.scd").load
	}
);