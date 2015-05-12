//LiveCodeNet Ensamble
//crea, coolabora, comparte tus SCtweets
////GUI que recibe los mensajes de los usuarios
(
~outmsg = Window("TweetEnsamble - output Msg",Rect.aboutPoint(Window.screenBounds.center,240,60),false,true,scroll:false);
//texto de entrada
~textout = TextView(~outmsg.asView,Rect(0,0,480,120)).background_(Color.cyan).focus(true);
~textout.setFont(Font("Khmer OS System",24,true,false),0,1400);
~textout.syntaxColorize(true);
~textout.enterInterpretsSelection(false);//evalua el texto
~textout.editable_(true);
//
~outmsg.onClose = {~outxt.value = 0};
)