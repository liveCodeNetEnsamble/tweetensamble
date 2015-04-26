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
	4.do{"URI has been set".inform};
	~texto.string = "URI has been set";
	~ip.string = "";
};
//nombre usuario
~usrlabel = StaticText(~w,Rect(20,185,200,12)).string = "User Name:(click enter)";
~usrlabel.background = Color.black;
~usrlabel.stringColor = Color.cyan;
~usr = TextField(~w,Rect(20,197,200,20)).background = Color.cyan;
~usr.action = {|field|
	if(~mip != nil,{
		~miusuario = field.value;
		4.do{"User has been set".inform};
		~texto.string = "User has been set";
		~usr.string = "";
	},{
		4.do{"IP must be set before User".inform};
		~texto.string = "IP must be set before User";
	});

};
///lista de usuarios
~lstlabel = StaticText(~w,Rect(20,219,200,12)).string = "Ensamble list:";
~lstlabel.background = Color.black;
~lstlabel.stringColor = Color.cyan;
~usrlist = TextView(~w,Rect(20,231,200,148)).background_(Color.cyan).focus(false);
~usrlist.autohidesScrollers_(true);
~usrlist.editable_(false);
//botones
~conecta = Button(~w,Rect(20,385,100,40));
~conecta.states_([
            ["Connect", Color.black, Color.cyan],
				["Disconnect", Color.cyan, Color.black]
        ]);
~conecta.action_({|butt|
	if(butt.value == 0, {//resetea valores de usuario
		~usrlist.string  = "";
		~miusuario=nil;
		~mip=nil;
		~texto.string = "You've been disconnected";
	});
	if(butt.value == 1, {
		if(~miusuario !=nil,{
			~loopback.sendMsg("/ensamble",~miusuario);//envia tu nombre, ip, puerto a los demas
			//accion nombre usuario
			~usrlist.setString(~miusuario ++ "\n" ++ ~uid.join("\n"),0); //enlista usr con las ips conectadas
			~usrlist.setStringColor(Color.red,0,~miusuario.size);//colorea miusuario
		},{
				var wcon = "Must set an 'IP' and 'Username' in order to connect";
				11.do{wcon.warn};
				~texto.string = wcon;
				~conecta.value = 0});
	});
});
//botones
~refresca = Button(~w,Rect(120,385,100,40));
~refresca.states_([
            ["Refresh List", Color.black, Color.cyan]
        ]);
~refresca.action_({|butt|
	if(~conecta.value == 1,{
		~usrlist.string = "";
		~usrlist.setString(~miusuario ++ "\n" ++ ~uid.join("\n"),0);
		~usrlist.setStringColor(Color.red,0,~miusuario.size);//colorea miusuario
	},{"Connect first, please.".warn;~texto.string = "Connect first, please.";});
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
~w.onClose = { "window is closed, you've been disconnected".inform};
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