pragma circom 2.0.0;

// Import the hash function MiMCSponge
include "./circomlib/mimcsponge.circom";

include "./circomlib/comparators.circom";

template AnotherCard() {  

  
   signal input number;
   signal input suit;
   signal input password;

   signal input firstCardHash;  
   signal input secondCardHash;  

   signal output card;
   
   //not the same card
   component comp = IsEqual();
   comp.in[0] <== firstCardHash;
   comp.in[1] <== secondCardHash;
   comp.out === 0;

   component mimc = MiMCSponge(2, 220, 1);
   mimc.ins[0] <== suit;
   mimc.ins[1] <== password;
   mimc.k <== 0;

   component mimcspongeComponents[13];

   component compComponents1[13];

   component compComponents2[13];

   var equalSumResultFirstCard = 0;

   var equalSumResultSecondCard = 0;
   
   for(var i = 0; i < 13; i++) {
       mimcspongeComponents[i] = MiMCSponge(2, 220, 1);
       mimcspongeComponents[i].ins[0] <== i;
       mimcspongeComponents[i].ins[1] <== mimc.outs[0];
       mimcspongeComponents[i].k <== 0;

       compComponents1[i] = IsEqual();
       compComponents1[i].in[0] <== mimcspongeComponents[i].outs[0];
       compComponents1[i].in[1] <== firstCardHash;

       equalSumResultFirstCard += compComponents1[i].out;

       compComponents2[i] = IsEqual();
       compComponents2[i].in[0] <== mimcspongeComponents[i].outs[0];
       compComponents2[i].in[1] <== secondCardHash;

       equalSumResultSecondCard += compComponents2[i].out;
   }
   
   equalSumResultFirstCard === 1;
   equalSumResultSecondCard === 1;
}

component main {public [firstCardHash, secondCardHash]} = AnotherCard();
