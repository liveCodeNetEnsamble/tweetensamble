//LiveCodeNet Ensamble
//crea, coolabora, comparte tus SCtweets
//
//GUI componer y compartir
(
~w = Window("TweetEnsamble - Collaborative sctweets",Rect.aboutPoint(Window.screenBounds.center,320,220),false,scroll:false).front;
//SCTweet
~texto = TextView(~w.asView,Rect(20,20,600,100)).background_(Color.cyan).focus(true);
~texto.setFont(Font("Khmer OS System",24,true,false),0,140);
~texto.string = "Write, share and evaluate SCtweets here ...";
~texto.syntaxColorize(true);
~texto.enterInterpretsSelection(true);//evalua el texto
//numero de usuarios
~numlabel = StaticText(~w,Rect(20,125,150,20)).string = "participants: (max 5)";
~numlabel.background = Color.black;
~numlabel.stringColor = Color.cyan;
~num = NumberBox(~w,Rect(170,125,50,20)).background = Color.cyan;
~num.clipLo = 2;
~num.clipHi = 5;
(
~num.value = 5;//default # integrantes LCNE
~numusr = ~num.value;
~uid = Array.newClear(~numusr-1);//
);
~num.align_(\center);
~num.step_(1);
~num.normalColor_(Color.black);
~num.typingColor_(Color(0,200,0));
~num.action ={|num|
	if(~conecta.value == 1,{
		4.do{"Cannot change Participants while connected".postcln};
		~num.value = ~uid.size+1;//mantiene el valor del ensamble mientras esta conectado
		},{
			("Number of Ensamble Participants set to: " ++ num.value).postln;
			~numusr = num.value;
			~uid = Array.newClear(~numusr-1);//
	});
};
//ip de usuario
~iplabel = StaticText(~w,Rect(20,150,200,12)).string = "User IP:(click enter)";
~iplabel.background = Color.black;
~iplabel.stringColor = Color.cyan;
~ip = TextField(~w,Rect(20,162,200,20)).background = Color.cyan;
~ip.action = {|field|
	if(~conecta.value == 1,{
		4.do{"Cannot change IP while connected".postcln;}
		},{
			~mip = field.value;
			4.do{"URI has been set".inform};
			~texto.string = "URI has been set";
			~textoin.string = "URI has been set";
			~ip.string = "";
	});
};
//nombre usuario
~usrlabel = StaticText(~w,Rect(20,185,200,12)).string = "User Name:(click enter)";
~usrlabel.background = Color.black;
~usrlabel.stringColor = Color.cyan;
~usr = TextField(~w,Rect(20,197,200,20)).background = Color.cyan;
~usr.action = {|field|
	if(~mip != nil,{
		if(~conecta.value == 1,{
			4.do{"Cannot change Username while connected".postcln};
			},{
				~miusuario = field.value;
				4.do{"User has been set, Now! press 'Connect".inform};
				~texto.string = "User has been set, Now! press 'Connect' ";
				~textoin.string = "User has been set, Now! press 'Connect' ";
				~usr.string = "";
		})},
		{
			4.do{"IP must be set before Username".inform};
			~texto.string = "IP must be set before Username";
			~textoin.string = "IP must be set before Username";
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
		~texto.string = "You've been disconnected from ensamble list";
		~textoin.string = "You've been disconnected from ensamble list";
		~loopback.sendBundle(0.2,['/desconecta',~miusuario,~mip]);//manda id para ser desconectado
	});
	if(butt.value == 1, {
		if(~miusuario != nil,{
			~n.sendBundle(0.1,['/ensamble',~miusuario,~mip,~puerto]);//envia tu nombre, ip, puerto a los demas
			~usrlist.setString(~miusuario ++ ": "++ ~mip ++ "\n" ++ ~uid.join("\n"),0); //enlista usr con las ips conectadas
			~usrlist.setStringColor(Color.red,0,~miusuario.size);//colorea miusuario
		},{
				var wcon = "Must set an 'IP' and 'Username' in order to connect";
				11.do{wcon.warn};
				~texto.string = wcon;
				~textoin.string = wcon;
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
		~usrlist.setString(~miusuario ++ ": "++ ~mip ++ "\n" ++ ~uid.join("\n"),0);
		~usrlist.setStringColor(Color.red,0,~miusuario.size);//colorea miusuario
	},{"Connect first, please.".warn;});
});
//ventana de entrada
~inputxt = Button(~w,Rect(240,385,100,40));
~inputxt.states_([
            ["Open input", Color.black, Color.cyan],
			["Close Input", Color.cyan, Color.black]
        ]);
~inputxt.action_({|val|
	if(val.value == 1,{(~url ++ "gui/tweetensamble_input_gui.scd").load;~intxt.front},{~intxt.close})};
);
//
// ~conecta.value.postln;
~labelbut = StaticText(~w,Rect(507,125,113,12)).string_("Text to All Users");
~labelbut.background = Color.black;
~labelbut.stringColor = Color.cyan;
~selectsend = Button(~w,Rect(507,137,113,20))
        .states_([
            ["Select 140 chars", Color.black, Color.cyan],
			["Send to all", Color.black, Color.green]
        ])
        .action_({|butt|
		if(butt.value == 0, {
			~texto.select(0,140);//
			~loopback.sendMsg('/enviotodos',~texto.selectedString);//envia texto a todos
        });
		if(butt.value == 1, {
            ~texto.select(0,140);//
		});
	});
//
~labelbut2 = StaticText(~w,Rect(507,160,113,12)).string_("Text to File");
~labelbut2.background = Color.black;
~labelbut2.stringColor = Color.cyan;
~selectsave = Button(~w,Rect(507,172,113,20))
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
			{(~url +/+ "gui/tweetensamble_input_gui.scd").load;
			~intxt.front;
			~textoin.string = "The Selection has been saved to: " ++ n;
			}.defer(0.1);
			4.do{("The Selection has been saved to: " ++ n).inform};
	});
		if(butt.value == 1, {
            ~texto.select(0,140);//
		});
	});
//cuenta de letras
~numtxt = NumberBox(~w,Rect(587,100,33,20));
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
~w.onClose = { "window is closed, you've been disconnected".inform;~uid = Array.newClear(~numusr);~msgit=0};
//
"\nGUI Ok!".inform;
);
// Font.availableFonts
// Help.gui;