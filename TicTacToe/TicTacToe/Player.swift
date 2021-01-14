//
//  Player.swift
//  TicTacToe
//
//  Created by Olof Hammar on 2020-12-17.
//

import Foundation

/*
 This is the class that handles the games players. The name and wins are set to default values
 and the brick variable is set the X for one player and O for the other in ViewController.
*/
class Player {
    
    var name: String
    var brick: String
    var wins: Int
    
    init(brick: String) {
        
        self.name = "---"
        self.brick = brick
        self.wins = 0
    }
    
    func updateName(newName: String) {
        
        self.name = newName
    }
    
    func addWin()  {
        
        wins += 1
    }
    
    func resetPlayerScore() {
        
        wins = 0
    }
}

class AiPlayer: Player {
    
    func makeMove(gamePlay: CheckWinner) -> Int {
        
        var tagNr = 0

        if gamePlay.gameBoard[4] == 0 {
            tagNr = 4
            return tagNr
        }
        //Block top row X X 0
        if gamePlay.gameBoard[0] == 1 && gamePlay.gameBoard[1] == 1 && gamePlay.gameBoard[2] == 0 {
            tagNr = 2
            return tagNr
        }
        //Block top row 0 X X
        if gamePlay.gameBoard[1] == 1 && gamePlay.gameBoard[2] == 1 && gamePlay.gameBoard[0] == 0 {
           tagNr = 0
           return tagNr
        }
        //Block top row X 0 X
        if gamePlay.gameBoard[0] == 1 && gamePlay.gameBoard[2] == 1 && gamePlay.gameBoard[1] == 0 {
            tagNr = 1
            return tagNr
        }
        //Block center row X X 0
        if gamePlay.gameBoard[3] == 1 && gamePlay.gameBoard[4] == 1 && gamePlay.gameBoard[5] == 0 {
            tagNr = 5
            return tagNr
        }
        //Block center row 0 X X
        if gamePlay.gameBoard[5] == 1 && gamePlay.gameBoard[4] == 1 && gamePlay.gameBoard[3] == 0 {
            tagNr = 3
            return tagNr
        }
        //Block top row X 0 X
        if gamePlay.gameBoard[3] == 1 && gamePlay.gameBoard[5] == 1 && gamePlay.gameBoard[4] == 0 {
            tagNr = 4
            return tagNr
        }
        //Block bottom row X X 0
        if gamePlay.gameBoard[6] == 1 && gamePlay.gameBoard[7] == 1 && gamePlay.gameBoard[8] == 0 {
           tagNr = 8
            return tagNr
        }
        //Block bottom row 0 X X
        if gamePlay.gameBoard[8] == 1 && gamePlay.gameBoard[7] == 1 && gamePlay.gameBoard[6] == 0 {
            tagNr = 6
            return tagNr
        }
        //Block bottom row X 0  X
        if gamePlay.gameBoard[6] == 1 && gamePlay.gameBoard[8] == 1 && gamePlay.gameBoard[7] == 0 {
            tagNr = 7
            return tagNr
        }
        //Block cross-line from top left
        if gamePlay.gameBoard[0] == 1 && gamePlay.gameBoard[4] == 1 && gamePlay.gameBoard[8] == 0 {
            tagNr = 8
            return tagNr
        }
        //Block cross-line from bottom left
        if gamePlay.gameBoard[8] == 1 && gamePlay.gameBoard[4] == 1 && gamePlay.gameBoard[0] == 0 {
            tagNr = 0
            return tagNr
        }
        //Block center for cross-line left to right
        if gamePlay.gameBoard[0] == 1 && gamePlay.gameBoard[8] == 1 && gamePlay.gameBoard[4] == 0 {
            tagNr = 4
            return tagNr
        }
        //Block cross-line from top right
        if gamePlay.gameBoard[2] == 1 && gamePlay.gameBoard[4] == 1 && gamePlay.gameBoard[6] == 0 {
            tagNr = 6
            return tagNr
        }
        //Block cross-line from bottom right
        if gamePlay.gameBoard[6] == 1 && gamePlay.gameBoard[4] == 1 && gamePlay.gameBoard[2] == 0 {
            tagNr = 2
            return tagNr
        }
        //Block center for cross-line right to left
        if gamePlay.gameBoard[2] == 1 && gamePlay.gameBoard[6] == 1 && gamePlay.gameBoard[4] == 0 {
            tagNr = 4
            return tagNr
        }
        //Block left row square 6
        if gamePlay.gameBoard[0] == 1 && gamePlay.gameBoard[3] == 1 && gamePlay.gameBoard[6] == 0 {
            tagNr = 6
            return tagNr
        }
        //Block left row square 3
        if gamePlay.gameBoard[0] == 1 && gamePlay.gameBoard[6] == 1 && gamePlay.gameBoard[3] == 0 {
            tagNr = 3
            return tagNr
        }
        //Block left row square 0
        if gamePlay.gameBoard[3] == 1 && gamePlay.gameBoard[6] == 1 && gamePlay.gameBoard[0] == 0 {
            tagNr = 0
            return tagNr
        }
        //Block center row square 7
        if gamePlay.gameBoard[1] == 1 && gamePlay.gameBoard[4] == 1 && gamePlay.gameBoard[7] == 0 {
            tagNr = 7
            return tagNr
        }
        //Block center row square 4
        if gamePlay.gameBoard[1] == 1 && gamePlay.gameBoard[7] == 1 && gamePlay.gameBoard[4] == 0 {
            tagNr = 4
            return tagNr
        }
        //Block center row square 1
        if gamePlay.gameBoard[4] == 1 && gamePlay.gameBoard[7] == 1 && gamePlay.gameBoard[1] == 0 {
            tagNr = 1
            return tagNr
        }
        //Block right row square 8
        if gamePlay.gameBoard[2] == 1 && gamePlay.gameBoard[5] == 1 && gamePlay.gameBoard[8] == 0 {
            tagNr = 8
            return tagNr
        }
        //Block top row square 5
        if gamePlay.gameBoard[2] == 1 && gamePlay.gameBoard[8] == 1 && gamePlay.gameBoard[5] == 0 {
            tagNr = 5
            return tagNr
        }
        //Block top row square 2
        if gamePlay.gameBoard[5] == 1 && gamePlay.gameBoard[8] == 1 && gamePlay.gameBoard[2] == 0 {
            tagNr = 2
            return tagNr
        }

        else {
            var listOfZeros = [Int]()
            var zero = 0
            
            for index in gamePlay.gameBoard {
                if index == 0 {
                    zero = tagNr
                    listOfZeros.append(zero)
                }
                tagNr += 1
            }
            listOfZeros.shuffle()
            if listOfZeros.count >= 2 && gamePlay.gameIsActive == true {
            tagNr = listOfZeros[0]
                print(tagNr)
                return tagNr
                
            }
        }

        return tagNr
    }
}
