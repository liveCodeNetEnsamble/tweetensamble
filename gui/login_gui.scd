//LiveCodeNet Ensamble
//crea, coolabora, comparte tus SCtweets
//GUI para logear y postear el tweet
~web = Window("Acustweet - colaborative sctweets",Rect(200,200,920,640),true).front;
~browser = WebView(~web,Rect(10,10,700,460));
~browser.url_(~turl.ip);//aqui debeb ir la direccion de login para twittear
~interface = ~url ++ "/assets/html/interface.scd".load;//trae el contenido html
~browser.html = ~interface;
~browser.evaluateJavaScript(
	""
	//posiblemente el login y post tweet con oAuth
	// intentare meterlo con js
	);
~browser.clearCache;
/*
WebView.plainText;
From implementing class
Tries to extract plain text from the displayed content, and returns it.
Returns:
A String.
*/