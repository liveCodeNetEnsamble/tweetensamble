//LiveCodeNet Ensamble
//crea, coolabora, comparte tus SCtweets
////GUI que recibe los mensajes de los usuarios
(
~intxt = Window("TweetEnsamble - input",Rect.aboutPoint(Window.screenBounds.center,240,60),false,true,scroll:false);
//texto de entrada
~textoin = TextView(~intxt.asView,Rect(0,0,480,120)).background_(Color.cyan).focus(true);
~textoin.setFont(Font("Khmer OS System",24,true,false),0,1400);
~textoin.syntaxColorize(true);
~textoin.enterInterpretsSelection(false);//evalua el texto
~textoin.editable_(false);
//
);
//
(
~notas = Window("TweetEnsamble - Self Notes",Rect.aboutPoint(Window.screenBounds.center,240,60),false,true,scroll:false);
//texto de entrada
~notain = TextView(~notas.asView,Rect(0,0,480,120)).background_(Color.cyan).focus(true);
~notain.setFont(Font("Khmer OS System",24,true,false),0,1400);
~notain.syntaxColorize(true);
~notain.enterInterpretsSelection(false);//evalua el texto
~notain.editable_(true);
//
~notas.onClose = {~inputxt.value = 0};
);