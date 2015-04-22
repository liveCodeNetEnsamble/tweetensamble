//LiveCodeNet Ensamble
//crea, coolabora, comparte tus SCtweets
//
//GUI componer y compartir
(
~w = Window("TweetEnsamble - Collaborative sctweets",Rect.aboutPoint(Window.screenBounds.center,320,220),false,scroll:false).front;
//texto de entrada
~texto = TextView(~w.asView,Rect(20,20,600,120)).background_(Color.cyan).focus(true);
~texto.setFont(Font("Bitstream Charter",15,true,false),0,140);
~texto.string = "Escribe y evalua tu codigo aqui ...";
~texto.syntaxColorize(true);
~texto.enterInterpretsSelection(true);//evalua el texto
//nombre usuario
~usrlabel = StaticText(~w,Rect(20,150,200,12)).string = "User Name:";
~usrlabel.background = Color.black;
~usrlabel.stringColor = Color.cyan;
~usr = TextField(~w,Rect(20,162,200,20)).background = Color.cyan;
///lista de usuarios
~lstlabel = StaticText(~w,Rect(20,187,200,12)).string = "Ensamble users list:";
~lstlabel.background = Color.black;
~lstlabel.stringColor = Color.cyan;
~usrlist = TextView(~w,Rect(20,199,200,180)).background_(Color.cyan).focus(false);
~usrlist.autohidesScrollers_(true);
~usrlist.editable_(false);
//botones
~conecta = Button(~w,Rect(20,385,200,40));
~conecta.states_([
            ["Connect to ensamble", Color.black, Color.cyan],
				["Disconnect from ensamble", Color.cyan, Color.black]
        ]);
~conecta.action_({|butt|
	if(~miusuario !=nil,{
		~loopback.sendMsg("/ensamble",~miusuario);//manda tu nombre a los demas
	},{8.do{"Must set a username before connection".warn};~conecta.value = 0});
	//accion nombre usuario
	~usr.action = {|field|
		~miusuario = field.value;
		~usrlist.setString(~miusuario ++ "\n" ++ ~uid.join ++ "\n",0);
		~usrlist.setStringColor(Color.magenta,0,~miusuario.size);
	};
	//~usr.string = "";
});
//
~labelbut = StaticText(~w,Rect(507,150,113,12)).string_("Text to Users");
~labelbut.background = Color.black;
~labelbut.stringColor = Color.cyan;
~selectsend = Button(~w,Rect(507,162,113,20))
        .states_([
            ["Select text 140", Color.black, Color.cyan],
			["Send to all", Color.black, Color.green]
        ])
        .action_({|butt|
		if(butt.value == 0, {
			~texto.select(0,140);//
			~loopback.sendMsg("/ensamble",~miusuario);
        });
		if(butt.value == 1, {
            ~texto.select(0,140);//
		});
	});
//
~labelbut2 = StaticText(~w,Rect(507,185,113,12)).string_("Text to File");
~labelbut2.background = Color.black;
~labelbut2.stringColor = Color.cyan;
~selectsave = Button(~w,Rect(507,197,113,20))
        .states_([
            ["Select text 140", Color.black, Color.cyan],
			["Save to file", Color.black, Color.green]
        ])
        .action_({|butt|
		if(butt.value == 0, {
			~texto.select(0,140);//
			n=~url ++ "sctweets/MySCTweet" ++ ~fileit ++ ".scd";
			a=File(n,"w");
			a.write("//done with tweetwensamble by " ++ ~miusuario ++ "\n" ++ ~texto.selectedString ++ "\n" ++ "//2015");
			a.close;
			~fileit = ~fileit+1;
			11.do{("The Selection has been saved to: " ++ n).inform};
        });
		if(butt.value == 1, {
            ~texto.select(0,140);//
		});
	});
if(~texto.focus != true, {~selectsave.value = 0});//regresar boton a estado 0
//cuenta de letras
~numtxt = NumberBox(~w,Rect(587,120,33,20));
~numtxt.background_(Color.green);
~numtxt.value = ~texto.string.size;
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
//
);
// Font.availableFonts
/*
~texto.setStringColor(Color.cyan,0,10);//colorizar algunas partes importantes del texto
~texto.setString("\nA string de reemplazo\n",12,6);//este para cambiar el texto por el recibido
*/
//
//Help.gui;