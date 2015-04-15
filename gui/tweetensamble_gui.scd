//LiveCodeNet Ensamble
//crea, coolabora, comparte tus SCtweets
//
//GUI componer y compartir
(
~w = Window("TweetEnsamble - Collaborative sctweets",Rect.aboutPoint(Window.screenBounds.center,320,220),false,scroll:false).front;
//texto de entrada
~texto = TextView(~w.asView,Rect(20,20,600,120)).background_(Color.cyan).focus(true);
~texto.syntaxColorize;
~texto.string = "Escribe y evalua tu codigo aqui ...";
~texto.enterInterpretsSelection(true);//evalua el texto
~texto.keyUpAction_({|view,chr,mod,uni,key|
	~texto.string.size.post;
	if(~texto.string.size > 140,{
		~texto.setFont(Font("Courier",12),140,5000);
		~texto.setStringColor(Color.red,140,5000);
		~numtxt.background_(Color.red);//fondo del contador de letras + 140 char
	});
	~numtxt.value = ~texto.string.size;
//
	if(~texto.string.size < 140,{
		~numtxt.background_(Color.green);
	});
	//[view,mod, uni, key].postln;
});
//cuenta de letras
~numtxt = NumberBox(~w,Rect(587,120,33,20));


);

/*
~numtxt.increment(100);//aumentara conforme se escriba
~texto.selectedString// para poder compartir texto seleccionado
~texto.setStringColor(Color.cyan,0,10);//colorizar algunas partes importantes del texto
~texto.setFont(Font("Courier",12),140,5000);
~texto.setStringColor(Color.red,140,5000);// para colorizar + de 140 caracteres
~texto.select(0,139);// para seleccionar una copia de los primeros 140 caracteres
~texto.string.size.postln;
~texto.setString("\nA string de reemplazo\n",12,6);//este para cambiar el texto por el recibido

//cambios en el gui
Tdef(\cambiosgui,{
	inf.do({
		if(~texto.string.size > 140,{
			{
				~texto.setFont(Font("Courier",12),140,5000);
				~texto.setStringColor(Color.red,140,5000)
			}.defer(0.1);
		});
		//~texto.string.size.post;
		0.1.wait;
	});
}).play;
*/
(//esta ventana para enviar el texto a algun companero
//~w = Window("colaborative sctweets",Rect.aboutPoint(Window.screenBounds.center,220,90),false,false,s,false).front;

);
//
Help.gui;