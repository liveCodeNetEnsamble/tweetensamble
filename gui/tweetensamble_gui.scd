//LiveCodeNet Ensamble
//crea, coolabora, comparte tus SCtweets
//
//GUI componer y compartir
(
~w = Window("TweetEnsamble - Collaborative sctweets",Rect.aboutPoint(Window.screenBounds.center,320,220),false,scroll:false).front;
//texto de entrada
~texto = TextView(~w.asView,Rect(20,20,600,120)).background_(Color.cyan).focus(true);
~texto.syntaxColorize;
~texto.setFont(Font("Bitstream Charter",15,true,false),0,140);
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
		if(butt.value == 0, {
			("echo " + ~texto.selectedString + " | xsel ").unixCmd;
			~texto.string_("xsel".unixCmdGetStdOut, ~texto.selectionStart,~texto.selectionSize);
                });
		if(butt.value == 1, {
            ~texto.select(0,140);//
		});
	});
//acciones
~texto.keyUpAction_({|view,chr,mod,uni,key|
	//~texto.string.size.post;
	if(~texto.string.size > 140,{
		~texto.setFont(Font("Bitstream Charter",9,false,true),140,140*2);
		~texto.setStringColor(Color.red,140,140*2);//error + 140
		~numtxt.background_(Color.red);//error + 140
	});
//
	~numtxt.value = ~texto.string.size;
//
	if(~texto.string.size <= 140,{
		~numtxt.background_(Color.green);
	});
	//[view,mod, uni, key].postln;
});

);
// Font.availableFonts
/*
~texto.selectedString// para poder compartir texto seleccionado
~texto.setStringColor(Color.cyan,0,10);//colorizar algunas partes importantes del texto
~texto.setFont(Font("Courier",12),140,5000);
~texto.setStringColor(Color.red,140,5000);// para colorizar + de 140 caracteres
~texto.setString("\nA string de reemplazo\n",12,6);//este para cambiar el texto por el recibido
*/
//
Help.gui;