//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;
import "../interfaces/IGame.sol";
import "../libraries/KnightMove.sol";
import "../libraries/SystemTypes.sol";
import "../libraries/Randomizer.sol"; 
import "hardhat/console.sol";
// importing OpenZeppelin's proxy library
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

contract SimpleGame is IGame, Initializable {

    SystemTypes.Position private knightPosition;

    function play(uint256 _moves) override external {
        KnightMove knight = new KnightMove();
        SystemTypes.Position memory currentKnightPosition = knightPosition; 
        console.log("0: My Position is (%d,%d)", currentKnightPosition.X, currentKnightPosition.Y);
        for (uint i = 0; i < _moves; i++) {
            SystemTypes.Position[] memory possibles = knight.validMovesFor(currentKnightPosition);
            uint r = Randomizer.random(possibles.length) % possibles.length; 
            currentKnightPosition = possibles[r]; 
            console.log("%d: My Position is (%d,%d)", i, currentKnightPosition.X, currentKnightPosition.Y); 
        }
    }
    
    function setup() override external {
      knightPosition = SystemTypes.Position(3,3);
    }
}
