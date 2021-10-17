//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;
import "../interfaces/IGame.sol";
import "../libraries/KnightMove.sol";
import "../libraries/QueenMove.sol"; //added 
import "../libraries/BishopMove.sol"; //added
import "../libraries/SystemTypes.sol";
import "../libraries/Randomizer.sol"; 
import "hardhat/console.sol";

//added for upgradeability
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
/*
Extend this GameRunner to set up an 8\times8 square game board containing several different pieces in predefined positions
(by implementing the ComplexGame contract and implement runComplex where it's used) 
For each move of the game, the GameRunner will choose a piece at random, and move it to a randomly selected valid position.

Tasks:
1. Knight piece is already supported by libraries
2. Add support for Bishop piece
3. Add support for Queen piece
Do not modify code in the libraries folder
 */


contract ComplexGame is IGame, Initializable {

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

    // new pieces added after upgrading from SimpleGame to ComplexGame 
    SystemTypes.Position private bishopPosition;
    SystemTypes.Position private queenPosition;

    // function added after upgrading the SimpleGame contract to ComplexGame contract
    function complexPlay(uint256 _moves) override external { 
         // todo: Put your code here.
         KnightMove knight = new KnightMove();
         BishopMove bishop = new BishopMove();
         QueenMove queen = new QueenMove();
         
         SystemTypes.Position memory currentKnightPosition = knightPosition;
         Systemtypes.Position memory currentBishopPosition = bishopPosition;
         Systemtypes.Position memory currentQueenPosition = queenPosition;

         Systemtypes.Position[] memory possiblePieces = [knightPosition, bishopPosition, queenPosition];

         console.log("0: Knight position is (%d, %d)", currentKnightPosition.X, currentKnightPosition.Y);
         console.log("0: Bishop position is (%d, %d)", currentBishopPosition.X, currentBishopPostion.Y);
         console.log("0: Queen position is (%d, %d)", currentQueenPosition.X, currentQueenPosition.Y);
         
         for (uint i = 0; i < _moves; i++) {
            uint randomPiece = Randomizer.random(possiblePieces.length) % possiblePieces.length;
            if(possiblePieces[randomPiece] == knightPosition) {
                SystemTypes.Position[] memory possibles = knight.validMovesFor(currentKnightPosition);
                uint r = Randomizer.random(possibles.length) % possibles.length; 
                currentKnightPosition = possibles[r];
                while( (currentKnightPosition == currentBishopPosition) || (currentKnightPosition == currentQueenPosition) ) {
                    r = Randomizer.random(possibles.length) % possibles.length; 
                    currentKnightPosition = possibles[r];
                }
                console.log("%d: Knight Position moved to (%d,%d)", i, currentKnightPosition.X, currentKnightPosition.Y);
                
            }

            if(possiblePieces[randomPiece] == bishopPosition) {
                SystemTypes.Position[] memory possibles = knight.validMovesFor(currentBishopPosition);
                uint r = Randomizer.random(possibles.length) % possibles.length; 
                currentBishopPosition = possibles[r];
                while( (currentKnightPosition == currentBishopPosition) || (currentBishopPosition == currentQueenPosition) ) {
                    r = Randomizer.random(possibles.length) % possibles.length; 
                    currentBishopPosition = possibles[r];
                }
                console.log("%d: Bishop Position moved to (%d,%d)", i, currentBishopPosition.X, currentBishopPosition.Y);
                
            }

             if(possiblePieces[randomPiece] == queenPosition) {
                SystemTypes.Position[] memory possibles = knight.validMovesFor(currentQueenPosition);
                uint r = Randomizer.random(possibles.length) % possibles.length; 
                currentQueenPosition = possibles[r];
                while( (currentQueenPosition == currentBishopPosition) || (currentKnightPosition  == currentQueenPosition) ) {
                    r = Randomizer.random(possibles.length) % possibles.length; 
                    currentQueenPosition = possibles[r];
                }
                console.log("%d: Queen Position moved to (%d,%d)", i, currentQueenPosition.X, currentQueenPosition.Y);
                
            }
        }
    }
    
    function complexSetup() override external {
        // todo: Put your code here.
        knightPosition = SystemTypes.Position(3,3);
        bishopPosition = SystemTypes.Position(1,3);
        queenPosition = SystemTypes.Position(2,3);

    }

    // If you wish to add more pieces, one may deploy a novel version of this contract with code like this:

    /*
    
    SystemTypes.Position private rookPosition;

    function gameV2play() {...}

    function gameV2setup() {...}

    */


} 