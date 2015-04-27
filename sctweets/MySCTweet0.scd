//done with tweetwensamble by nil
o=Array.series(4,9,31);play{o.collect{|x|{LFTri.ar(o*x,0,0.5)}.dup(3).lag(Phasor.kr(Impulse.kr(XLine.kr(1,128,30)),1,0.01,2))}};
//2015