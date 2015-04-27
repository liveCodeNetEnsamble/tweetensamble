//LiveCodeNet Ensamble
//crea, coolabora, comparte tus SCtweets
/////
//conexion local History + NetAddr
~all = NetAddr.broadcastFlag = true;
~n.addrs = (0..~numusr).collect { |x| //array con distintos puertos
	NetAddr("255.255.255.255", ~puerto + x);//toda la mascara de subred
};
/////debug local:
~loopback = NetAddr("127.0.0.1", ~puerto); //
////
//twitter keys
~consumerkey= "DBakhgZwugfpTKjHqViT65JHI";
~consumersecret= "A5CWLGi4TY4Fhudc9ebndbq337hrG3bN5qHdUhVkfNucLnahvP";
~accesstoken= "783824684-s3k3Xk1TNvXj92jwJtP2BNz3jh3T0jMo7GXonNyk";
~accesstokensecret="yZIYoeBN4sug091XIr7qjcBkgPUfWx16her9GRuZdNen2";
///
//para desplegar el contenido del WebView
~turl = NetAddr("www.twitter.com",~puerto);//direccion para logear y postear
// Help.gui;