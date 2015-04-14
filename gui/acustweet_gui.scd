//LiveCodeNet Ensamble
//crea, coolabora, comparte tus SCtweets
//acustweet GUI
//GUI del navegador
(
~w = Window("Collaborative sctweets",Rect.aboutPoint(Window.screenBounds.center,320,220),false,scroll:false).front;
//texto de entrada
~texto = TextView(~w.asView,Rect(20,20,600,120)).focus(true);
~texto.string = "Escribe y evalua tu codigo aqui ...";
~texto.setStringColor(Color.cyan,0,10);// para colorizar algunas partes importantes del texto
~texto.enterInterpretsSelection(true);//evalua el texto seleccionado
//cuenta de letras
~numletras = NumberBox(~w,Rect(0,0,20,20));
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
/*
t.pause;
t.resume;
t.reset;
t.stop;
*/
)
~texto.setFont(Font("Courier",12),140,5000);
~texto.setStringColor(Color.red,140,5000);// para colorizar algunas partes importantes del texto
~texto.select(140,500);
~texto.string.size.postln;
~texto.setString("\nA string de reemplazo\n",12,6);//este para cambiar el texto por el recibido
//la ventana
(//esta ventna para enviar el texto a algun companero
//~w = Window("colaborative sctweets",Rect.aboutPoint(Window.screenBounds.center,220,90),false,false,s,false).front;

);
//
Help.gui;