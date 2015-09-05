//LiveCodeNet Ensamble
//crea, coolabora, comparte tus SCtweets
//GUI para logear y postear el tweet
~web = Window(nil,Rect(200,200,720,480),false);//~browser.title
~browser = WebView(~web,Rect(10,10,700,460));
~browser.url_(~turl.hostname);// login para twittear
~web.onClose = {~outsct.value = 0};
