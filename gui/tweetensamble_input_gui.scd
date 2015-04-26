//LiveCodeNet Ensamble
//crea, coolabora, comparte tus SCtweets
////GUI que recibe los mensajes de los usuarios
(
~intxt = Window("TweetEnsamble - input",Rect.aboutPoint(Window.screenBounds.center,240,60),false,false,scroll:false);
//texto de entrada
~textoin = TextView(~intxt.asView,Rect(0,0,480,120)).background_(Color.cyan).focus(true);
~textoin.setFont(Font("Khmer OS System",24,true,false),0,1400);
~textoin.syntaxColorize(true);
~textoin.enterInterpretsSelection(false);//evalua el texto
//
~intxt.onClose = {~inputxt.value = 0};
)