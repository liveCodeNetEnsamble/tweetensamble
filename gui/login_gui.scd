//LiveCodeNet Ensamble
//crea, coolabora, comparte tus SCtweets
//GUI para logear y postear el tweet
~web = Window(nil,Rect(200,200,720,480),false);//~browser.title
~browser = WebView(~web,Rect(10,10,700,460));
~browser.url_(~turl.hostname);// login para twittear
~web.onClose = {~outsct.value = 0};
/*
~browser.evaluateJavaScript("");
////
WebView.plainText;
From implementing class
Tries to extract plain text from the displayed content, and returns it.
Returns:
A String.
*/
//~interface = (~url ++ "assets/html/interface.scd").load;//trae el contenido html
//~browser.html = ~interface;
//s