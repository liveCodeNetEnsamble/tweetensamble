//LiveCodeNet Ensamble
//crea, coolabora, comparte tus SCtweets
//
//GUI componer y compartir
(
~w = Window("TweetEnsamble - Collaborative sctweets",Rect.aboutPoint(Window.screenBounds.center,295,220),false,scroll:false).front;
//SCTweet
~texto = TextView(~w.asView,Rect(20,20,553,100)).background_(Color.cyan).focus(true);
~texto.setFont(Font("Khmer OS System",24,true,false),0,140);
~texto.string = "Write, share and evaluate SCtweets here ...";
~texto.syntaxColorize(true);
~texto.enterInterpretsSelection(true);//evalua el texto
//numero de usuarios
~numlabel = StaticText(~w,Rect(20,125,150,20)).string = "participants: (max 5)";
~numlabel.background = Color.black;
~numlabel.stringColor = Color.cyan;
~numlabel.align_(\center);
~num = NumberBox(~w,Rect(170,125,50,20)).background = Color.cyan;
~num.clipLo = 2;
~num.clipHi = 5;
(
~num.value = 5;//default # integrantes LCNE
~numusr = ~num.value;
~uid = Array.newClear(~numusr-1);//
~othersip = Array.newClear(~numusr-1);
);
~num.align_(\center);
~num.step_(1);
~num.normalColor_(Color.black);
~num.typingColor_(Color(0,200,0));
~num.action ={|num|
	if(~conecta.value == 1,{
		4.do{"Cannot change Participants while connected".postcln};
		{(~url +/+ "gui/tweetensamble_input_gui.scd").load;
		~intxt.front;
		~textoin.string = "Cannot change Participants while connected!!!";
		}.defer(0.1);
		~num.value = ~uid.size+1;//mantiene el valor del ensamble mientras esta conectado
		},{
			("Number of Ensamble Participants set to: " ++ num.value).postln;
			~numusr = num.value;
			~uid = Array.newClear(~numusr-1);//
			~othersip = Array.newClear(~numusr-1);
	});
};
//ip de usuario
~iplabel = StaticText(~w,Rect(20,150,200,12)).string = "User IP:(click enter)";
~iplabel.background = Color.black;
~iplabel.stringColor = Color.cyan;
~ip = TextField(~w,Rect(20,162,200,20)).background = Color.cyan;
~ip.action = {|field|
	if(~conecta.value == 1,{
		4.do{"Cannot change IP while connected".postcln};
		{(~url +/+ "gui/tweetensamble_input_gui.scd").load;
		~intxt.front;
		~textoin.string = "Cannot change IP while connected!!!";
		}.defer(0.1);
		},{
			~mip = field.value;
			4.do{"URI has been set".inform};
			~texto.string = "URI has been set";
			~textoin.string = "URI has been set";
			~numtxt.value = ~texto.string.size;
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
			{(~url +/+ "gui/tweetensamble_input_gui.scd").load;
			~intxt.front;
			~textoin.string = "Cannot change Username while connected!!!";
			}.defer(0.1);
			},{
				~miusuario = field.value;
				4.do{"User has been set, Now! press 'Connect".inform};
				~texto.string = "User has been set, Now! press 'Connect' ";
				~textoin.string = "User has been set, Now! press 'Connect' ";
				~numtxt.value = ~texto.string.size;
				~usr.string = "";
		})},
		{
			4.do{"IP must be set before Username".inform};
			~texto.string = "IP must be set before Username";
			~textoin.string = "IP must be set before Username";
			~numtxt.value = ~texto.string.size;
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
	if(butt.value == 0, { //resetea valores de usuario
		~usrlist.string  = "";
		~texto.string = "You've been disconnected from ensamble list + your code deleted";
		~textoin.string = "You've been disconnected from ensamble list + your code deleted";
		~numtxt.value = ~texto.string.size;
		~n.sendBundle(0.2,['/desconecta',~miusuario,~mip]);// envio mis datos para borrar de la lista de los demas
		~mip=nil;
		~miusuario=nil;
	});
	if(butt.value == 1, {
		if(~miusuario != nil,{
			~n.sendBundle(0.1,['/ensamble',~miusuario,~mip,~puerto]);//envia tu nombre, ip, puerto a los demas
			~usrlist.setString(~miusuario ++ ": "++ ~mip ++ "\n" ++ ~uid.join("\n"),0); //enlista usr con las ips conectadas
			~msgmenu.items = ~uid; //  enlista los usuarios en el menu de mensaue
			~usrlist.setStringColor(Color.red,0,~miusuario.size);//colorea miusuario
			~texto.string = "Compose and share your SCTweets";
			~textoin.string = "Compose and share your SCTweets";
			~numtxt.value = ~texto.string.size;
			},{
				var wcon = "Must set an 'IP' and 'Username' in order to connect";
				4.do{wcon.warn};
				~texto.string = wcon;
				~textoin.string = wcon;
				~numtxt.value = ~texto.string.size;
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
		~msgmenu.items = ~uid;
	},{"Connect first, please.".warn;});
});
//ventana de entrada
~inputxt = Button(~w,Rect(240,385,200,40));
~inputxt.states_([
            ["Open notes", Color.black, Color.cyan],
			["Close notes", Color.cyan, Color.black]
        ]);
~inputxt.action_({|val|
	if(val.value == 1,{
		(~url ++ "gui/tweetensamble_input_gui.scd").load;
		~notas.front;
	},{~notas.close})};
);
//evalua solo
~labelbut3 = StaticText(~w,Rect(460,125,113,12)).string_("Eval local").align_(\center);
~labelbut3.background = Color.black;
~labelbut3.stringColor = Color.cyan;
~selectbut = Button(~w,Rect(460,137,113,28))
        .states_([
            ["Evaluate 140", Color.black, Color.green],
        ])
        .action_({|butt|
		if(butt.value == 0, {
            ~texto.select(0,140/*~texto.string.size*/);//selecciona max 140
			~texto.string.interpretPrint;
		});
	});
//para servidor local
~labelbut4 = StaticText(~w,Rect(460,170,113,12)).string_("Stop server").align_(\center);
~labelbut4.background = Color.black;
~labelbut4.stringColor = Color.cyan;
~stopbut = Button(~w,Rect(460,181,113,28))
        .states_([
            ["Kill that Noise", Color.black, Color.red],
        ])
        .action_({|butt|
		if(butt.value == 0, {
			Server.freeAll;
		});
	});
//evalua a todos los conectados
~labelevall = StaticText(~w,Rect(330,125,113,12)).string_("Eval to all").align_(\center);
~labelevall.background = Color.black;
~labelevall.stringColor = Color.cyan;
~evaltodos = Button(~w,Rect(330,137,113,28))
        .states_([
            ["Eval Everyone", Color.black, Color.green],
        ])
        .action_({|butt|
		if(butt.value == 0, {
		  var texto =  ~texto.select(0,140);
		 ~n.sendBundle(0.001,['\evaltodos',0,texto,~miusuario,~mip]);//envia el codigo y despues evaluarlo
		});
	});
//
~labelstopall = StaticText(~w,Rect(330,170,113,12)).string_("Stop everyone").align_(\center);
~labelstopall.background = Color.black;
~labelstopall.stringColor = Color.cyan;
~stopall = Button(~w,Rect(330,181,113,28))
        .states_([
            ["Kill those Noises", Color.black, Color.red],
        ])
        .action_({|butt|
		if(butt.value == 0, {
		    ~n.sendBundle(0.001,['\evaltodos',1,~miusuario]);
		});
	});
//
~labelbut = StaticText(~w,Rect(460,296,113,12)).string_("Text to All Users").align_(\center);
~labelbut.background = Color.black;
~labelbut.stringColor = Color.cyan;
~selectsend = Button(~w,Rect(460,307,113,28))
        .states_([
            ["Select 140 chars", Color.black, Color.cyan],
			["Send to all", Color.black, Color.green]
        ])
        .action_({|butt|
		if(butt.value == 0, {
			~texto.select(0,140);//
		~n.sendBundle(0.2,['/enviotodos',~texto.selectedString,~miusuario]);//envia texto a todos
        });
		if(butt.value == 1, {
            ~texto.select(0,140);//
		});
	});
//
~labelbut2 = StaticText(~w,Rect(460,340,113,12)).string_("Text to File").align_(\center);
~labelbut2.background = Color.black;
~labelbut2.stringColor = Color.cyan;
~selectsave = Button(~w,Rect(460,352,113,28))
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
			~numtxt.value = ~texto.string.size;
	});
		if(butt.value == 1, {
            ~texto.select(0,140);//
		});
	});
//mensaje directo
~labelmsg = StaticText(~w,Rect(240,219,200,16)).string_("Send / Receive").align_(\center);
~labelmsg.background = Color.black;
~labelmsg.stringColor = Color.cyan;
~labelpop = StaticText(~w,Rect(240,239,200,12)).string_("Message to:");
~labelpop.background = Color.black;
~labelpop.stringColor = Color.cyan;
~msgmenu = PopUpMenu(~w,Rect(240,251,200,30)).background_(Color.cyan);
//~msgmenu.items = ~uid;
~outxt = Button(~w,Rect(240,280,200,40));
~outxt.states_([
    ["Open Output", Color.black, Color.cyan],
	["Send Msg to ...", Color.white, Color.green],
	["Close", Color.cyan, Color.black]
        ]);
~outxt.action_({|val|
	if(~conecta.value != 0,{//
		if(val.value == 1,{
			~comparte = ~othersip[~msgmenu.value];// relaciona array de lista con array de IPs
			(~url ++ "gui/tweetensamble_out_gui.scd").load;~outmsg.front;
		});
		if(val.value == 2,{~direct.sendBundle(0.5,["/directo",~textout.string,~miusuario,"uno"]);//envia mensaje con id
		});
		if(val.value == 0,{~outmsg.close});
		},{
			~outxt.value=0;
			~texto.string = "Must be connected to message someone";
			~numtxt.value = ~texto.string.size;
			~textoin.string = "Must be connected to message someone";"Must be connected to message someone".postln;
	});
});
//envia mensaje a todos
~labelpop2 = StaticText(~w,Rect(240,327,200,12)).string_("Message All:");
~labelpop2.background = Color.black;
~labelpop2.stringColor = Color.cyan;
~outxtall = Button(~w,Rect(240,339,200,40));
~outxtall.states_([
    ["Open Output", Color.black, Color.cyan],
	["Send Msg All", Color.white, Color.green],
	["Close", Color.cyan, Color.black]
        ]);
~outxtall.action_({|val|
	if(~conecta.value != 0,{
		if(val.value == 1,{(~url ++ "gui/tweetensamble_out_gui.scd").load;~outmsg.front;
		});
		if(val.value == 2,{~n.sendBundle(0.5,["/directo",~textout.string,~miusuario,"todos"]);//envia mensaje con id
		});
		if(val.value == 0,{~outmsg.close});
		},{
			~outxtall.value=nil;
			~texto.string = "Must be connected to message everybody";
			~numtxt.value = ~texto.string.size;
			~textoin.string = "Must be connected to message everybody";"Must be connected to message everybody".postln;
	});
});
//loggin a twitter
~outsct = Button(~w,Rect(460,385,113,40));
~outsct.states_([
            ["Post SCTweet", Color.black, Color.green],
			["Close Browser", Color.green, Color.black]
        ]);
~outsct.action_({|val|
	if(val.value == 1,{
		(~url ++ "gui/login_gui.scd").load;
		~web.front;
		//~server = "tweetensamble.mixfuckedup.net";
		{~web.name=~browser.title}.defer(3);
		},{
			~web.close
		}
	);
});
//cuenta de letras
~numtxt = NumberBox(~w,Rect(540,100,33,20));
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
//cuando se cierra la ventana
~w.onClose = {
	"window is closed, you've been disconnected".inform;
	~uid = Array.newClear(~numusr -1);
	~othersip = Array.newClear(~numusr -1);
	~n.sendBundle(0.2,['/off',~mip,~miusuario]);
	~msgit=0;Server.freeAll;
};
//
"\nGUI Ok!".inform;
);
// Font.availableFonts
// Help.gui;