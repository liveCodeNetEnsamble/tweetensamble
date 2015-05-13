//done with tweetwensamble by nil
play{(1..8).collect({|i|x=(60..880);a=Impulse;t=TChoose;Pulse.ar(t.kr(a.kr(1/i),x)*i,0.5/i,0.5)+LFSaw.ar(t.kr(a.kr(4*i),x/2),0.1,0.5)})}; 
//2015