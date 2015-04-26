//LiveCodeNet Ensamble
//crea, coolabora, comparte tus SCtweets
//
//GUI componer y compartir
(
~w = Window("TweetEnsamble - Collaborative sctweets",Rect.aboutPoint(Window.screenBounds.center,320,220),false,scroll:false).front;
//texto de entrada
~texto = TextView(~w.asView,Rect(20,20,600,120)).background_(Color.cyan).focus(true);
~texto.setFont(Font("Bitstream Charter",24,true,false),0,140);
~texto.string = "Write, share and evaluate SCtweets here ...";
~texto.syntaxColorize(true);
~texto.enterInterpretsSelection(true);//evalua el texto
//ip de usuario
~iplabel = StaticText(~w,Rect(20,150,200,12)).string = "User IP:(click enter)";
~iplabel.background = Color.black;
~iplabel.stringColor = Color.cyan;
~ip = TextField(~w,Rect(20,162,200,20)).background = Color.cyan;
~ip.action = {|field|
	~mip = field.value;
	4.do{"URI has been set, now add User".inform};
	~usr.string = "";
};
//nombre usuario
~usrlabel = StaticText(~w,Rect(20,185,200,12)).string = "User Name:(click enter)";
~usrlabel.background = Color.black;
~usrlabel.stringColor = Color.cyan;
~usr = TextField(~w,Rect(20,197,200,20)).background = Color.cyan;
~usr.action = {|field|
	~miusuario = field.value;
	4.do{"User has been set, now press connect".inform};
	~usr.string = "";
};
///lista de usuarios
~lstlabel = StaticText(~w,Rect(20,219,200,12)).string = "Ensamble users list:";
~lstlabel.background = Color.black;
~lstlabel.stringColor = Color.cyan;
~usrlist = TextView(~w,Rect(20,231,200,148)).background_(Color.cyan).focus(false);
~usrlist.autohidesScrollers_(true);
~usrlist.editable_(false);
//botones
~conecta = Button(~w,Rect(20,385,200,40));
~conecta.states_([
            ["Connect to ensamble", Color.black, Color.cyan],
				["Disconnect to refresh list", Color.cyan, Color.black]
        ]);
~conecta.action_({|butt|
	if(butt.value == 0, {
		~usrlist.string  = "";
		11.do{"Refreshing ensamble list".warn};
		~loopback.sendMsg("/ensamble","");
	});
	if(butt.value == 1, {
		if(~miusuario !=nil,{
			~loopback.sendBundle("/ensamble", [~miusuario,]);//envia tu nombre, ip, puerto a los demas
			//accion nombre usuario
			~usrlist.setString(~miusuario ++ "\n" ++ ~uid.join("\n"),0); //enlista usuario con las ips conectadas
			~usrlist.setStringColor(Color.magenta,0,~miusuario.size);//colorea miusuario
		},{11.do{"Must set a username before connection".warn};~conecta.value = 0});
	});
});
//
// ~conecta.value.postln;
~labelbut = StaticText(~w,Rect(507,150,113,12)).string_("Text to Users");
~labelbut.background = Color.black;
~labelbut.stringColor = Color.cyan;
~selectsend = Button(~w,Rect(507,162,113,20))
        .states_([
            ["Select 140 chars", Color.black, Color.cyan],
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
            ["Select 140 chars", Color.black, Color.cyan],
			["Save to file", Color.black, Color.green]
        ])
        .action_({|butt|
		if(butt.value == 0, {
			~texto.select(0,140);//por si el texto se deselecciona antes de enviar
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
~w.onClose = { "la ventana se ha cerrado, has sido desconectado de la red del ensamble".inform};
//
"\n GUI Ok!".inform;
);
// Font.availableFonts
/*
~texto.setStringColor(Color.cyan,0,10);//colorizar algunas partes importantes del texto
~texto.setString("\nA string de reemplazo\n",12,6);//este para cambiar el texto por el recibido
*/
//
//Help.gui;