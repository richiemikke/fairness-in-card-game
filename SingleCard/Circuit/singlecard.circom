pragma circom 2.0.0;


include "./circomlib/mimcsponge.circom";

// There are 52 cards

template SingleCard() {  

   // card number 0-51
   signal input number;  // private
   signal input password; // private

   signal input cardHash; //public

 
   signal output card; // output

   component mimc = MiMCSponge(2, 220, 1);
   mimc.ins[0] <== number;
   mimc.ins[1] <== password;
   mimc.k <== 0;

   card <== mimc.outs[0];
 
   cardHash === card;
}

component main {public [cardHash]} = SingleCard();