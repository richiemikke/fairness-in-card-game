pragma circom 2.0.0;

include "./circomlib/mimcsponge.circom";

template Card() {  

  

   // Private inputs
   signal input number;  
   signal input suit;  
   signal input password;

   // Public input
   signal input cardHash;

   // Output
   signal output card;

   component mimc1 = MiMCSponge(2, 220, 1);
   mimc1.ins[0] <== suit;
   mimc1.ins[1] <== password;
   mimc1.k <== 0;

   component mimc2 = MiMCSponge(2, 220, 1);
   mimc2.ins[0] <== number;
   mimc2.ins[1] <== mimc1.outs[0];
   mimc2.k <== 0;

   card <== mimc2.outs[0];
 
   cardHash === card;
}

component main {public [cardHash]} = Card();