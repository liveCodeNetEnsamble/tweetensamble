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
//cuenta de letras
~numtxt = NumberBox(~w,Rect(587,120,33,20));
~numtxt.background_(Color.green);
~numtxt.value = ~texto.string.size;
//botones
~selectall = Button(~w,Rect(507,150,113,20))
        .states_([
            ["Select your 140", Color.cyan, Color.black],
			["Copy your 140", Color.green, Color.black]
        ])
        .action_({|butt|
		if(butt.value == 1, {
            ~texto.select(0,139);//
                });
		if(butt.value == 0, {
			("echo" + ~texto.selectedText + " | xclip ").unixCmd;
			~texto.string_("xclip".unixCmdGetStdOut, ~texto.selectionStart,~texto.selectionSize);
		});
	});
//acciones
~texto.keyUpAction_({|view,chr,mod,uni,key|
	//~texto.string.size.post;
	if(~texto.string.size > 140,{
		~texto.setFont(Font("Courier",11),140,5000);
		~texto.setStringColor(Color.red,140,5000);//error + 140
		~numtxt.background_(Color.red);//error
	});
	~numtxt.value = ~texto.string.size;
//
	if(~texto.string.size <= 140,{
		~numtxt.background_(Color.green);
	});
	//[view,mod, uni, key].postln;
});

);
/*
~texto.selectedString// para poder compartir texto seleccionado
~texto.setStringColor(Color.cyan,0,10);//colorizar algunas partes importantes del texto
~texto.setFont(Font("Courier",12),140,5000);
~texto.setStringColor(Color.red,140,5000);// para colorizar + de 140 caracteres
~texto.setString("\nA string de reemplazo\n",12,6);//este para cambiar el texto por el recibido
*/
//
Help.gui;