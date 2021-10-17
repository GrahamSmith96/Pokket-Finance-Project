//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;
import "./cores/SimpleGame.sol";
import "./cores/ComplexGame.sol";

/* Tasks:
1. Knight piece is already supported by libraries
2. Add support for Bishop piece
3. Add support for Queen piece
Do not modify code in libraries folder

For each move of the game, the GameRunner will choose a piece at random, and move it to a randomly selected valid position.


*/
contract GameRunner is Initializable {
    function runSimple() external {
      SimpleGame game = new SimpleGame(); 
      game.setup();
      game.play(10);
    }
        
    function runComplex() external {
      ComplexGame game = new ComplexGame(); 
      //todo: Put your code here.
      game.complexSetup();
      game.complexPlay(10);
    }
}
 