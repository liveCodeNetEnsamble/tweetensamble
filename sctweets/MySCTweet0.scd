//done with tweetwensamble by nil
play{f=Phasor.kr(Impulse.kr(0.01),1,60,20000);BPF.ar(LFPulse.ar({|i|[f/150,60*i]*i}.dup(4),0.5,0.01,0.01),f,0.5)!2}

//2015