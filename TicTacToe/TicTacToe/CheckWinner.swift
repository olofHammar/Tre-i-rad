//
//  CheckWinner.swift
//  TicTacToe
//
//  Created by Olof Hammar on 2020-12-16.
//

import Foundation
import UIKit

/*
 This class handles the game logic. The gameboard is set to all zeros which represents empty
 squares. I then use the function updateGameboard to changes these numbers to either 1 for X or
 for O. Winner is set to zero by default and changes to 1 if X wins, 2 if O wins and 3 if there
 is a tie.
 */

class CheckWinner {
    
    var winner: Int
    var gameBoard: Array<Int>
    var gameIsActive: Bool
    var playersTurn: String
    var tagNr: Int
    
    init() {
        
        self.winner = 0
        self.gameBoard = [0,0,0,0,0,0,0,0,0]
        self.gameIsActive = true
        self.playersTurn = "X"
        self.tagNr = 0
    }
    
    func updateGameboard(i: Int, player: Int) {
        gameBoard[i] = player
    }
    
    func resetGameBoard() {
        gameBoard = [0,0,0,0,0,0,0,0,0]
    }
    
    /*
     This functions checks all possible winning combinations and, if found, returns a winner.
     To check if the game is a tie I check if the gameboard contains any zeros, if so I return
     gameActive = true. Otherwise the game is a tie.
     I reset the winner to zero each time the method is called.
     */
    func checkForWinningCombination () -> (Int, Bool) {
        let board = gameBoard
        //var gameIsActive = true
        winner = 0
        let winningCombos = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]

        for combo in winningCombos {
            if board [combo[0]] != 0 && board[combo[0]] == board[combo[1]] &&
                board[combo[1]] == board[combo[2]] {
                
                if board[combo[0]] == 1 {
                    winner = 1
                    gameIsActive = false
                    return (self.winner, gameIsActive)
                }
                else {
                    winner = 2
                    gameIsActive = false
                    return (self.winner, gameIsActive)
                }
            }
        }
        
        gameIsActive = false
        
        for nr in board {
            if nr == 0 {
                gameIsActive = true
                break
            }
        }
        
        if gameIsActive == false {
            winner = 3
        }
        
        return (self.winner, gameIsActive)
    }
    
    //This method displays the winner-message and adds a win to the winning player.
    func printWinner(scoreLabelX: UILabel, scoreLabelO: UILabel, gameLabel: UILabel, playerX: Player, playerO: Player) {
        
        if winner == 1 {
            gameIsActive = false
            gameLabel.isHidden = false
            gameLabel.text = "\(playerX.name) wins the game"
            playerX.addWin()
            scoreLabelX.text = String(playerX.wins)
        }
        
        else if winner == 2 {
            gameIsActive = false
            gameLabel.isHidden = false
            gameLabel.text = "\(playerO.name) wins the game"
            playerO.addWin()
            scoreLabelO.text = String(playerO.wins)
        }
        
        else if winner == 3 {
            gameIsActive = false
            gameLabel.isHidden = false
            gameLabel.text = "The game is a tie"
        }
    }
    
    func aiLogic() -> Int {
        
        tagNr = 0

        if gameBoard[4] == 0 {
            tagNr = 4
            return tagNr
        }
        //Block top row X X 0
        if gameBoard[0] == 1 && gameBoard[1] == 1 && gameBoard[2] == 0 {
            tagNr = 2
            return tagNr
        }
        //Block top row 0 X X
        if gameBoard[1] == 1 && gameBoard[2] == 1 && gameBoard[0] == 0 {
           tagNr = 0
           return tagNr
        }
        //Block top row X 0 X
        if gameBoard[0] == 1 && gameBoard[2] == 1 && gameBoard[1] == 0 {
            tagNr = 1
            return tagNr
        }
        //Block center row X X 0
        if gameBoard[3] == 1 && gameBoard[4] == 1 && gameBoard[5] == 0 {
            tagNr = 5
            return tagNr
        }
        //Block center row 0 X X
        if gameBoard[5] == 1 && gameBoard[4] == 1 && gameBoard[3] == 0 {
            tagNr = 3
            return tagNr
        }
        //Block top row X 0 X
        if gameBoard[3] == 1 && gameBoard[5] == 1 && gameBoard[4] == 0 {
            tagNr = 4
            return tagNr
        }
        //Block bottom row X X 0
        if gameBoard[6] == 1 && gameBoard[7] == 1 && gameBoard[8] == 0 {
           tagNr = 8
            return tagNr
        }
        //Block bottom row 0 X X
        if gameBoard[8] == 1 && gameBoard[7] == 1 && gameBoard[6] == 0 {
            tagNr = 6
            return tagNr
        }
        //Block bottom row X 0  X
        if gameBoard[6] == 1 && gameBoard[8] == 1 && gameBoard[7] == 0 {
            tagNr = 7
            return tagNr
        }
        //Block cross-line from top left
        if gameBoard[0] == 1 && gameBoard[4] == 1 && gameBoard[8] == 0 {
            tagNr = 8
            return tagNr
        }
        //Block cross-line from bottom left
        if gameBoard[8] == 1 && gameBoard[4] == 1 && gameBoard[0] == 0 {
            tagNr = 0
            return tagNr
        }
        //Block center for cross-line left to right
        if gameBoard[0] == 1 && gameBoard[8] == 1 && gameBoard[4] == 0 {
            tagNr = 4
            return tagNr
        }
        //Block cross-line from top right
        if gameBoard[2] == 1 && gameBoard[4] == 1 && gameBoard[6] == 0 {
            tagNr = 6
            return tagNr
        }
        //Block cross-line from bottom right
        if gameBoard[6] == 1 && gameBoard[4] == 1 && gameBoard[2] == 0 {
            tagNr = 2
            return tagNr
        }
        //Block center for cross-line right to left
        if gameBoard[2] == 1 && gameBoard[6] == 1 && gameBoard[4] == 0 {
            tagNr = 4
            return tagNr
        }
        //Block left row square 6
        if gameBoard[0] == 1 && gameBoard[3] == 1 && gameBoard[6] == 0 {
            tagNr = 6
            return tagNr
        }
        //Block left row square 3
        if gameBoard[0] == 1 && gameBoard[6] == 1 && gameBoard[3] == 0 {
            tagNr = 3
            return tagNr
        }
        //Block left row square 0
        if gameBoard[3] == 1 && gameBoard[6] == 1 && gameBoard[0] == 0 {
            tagNr = 0
            return tagNr
        }
        //Block center row square 7
        if gameBoard[1] == 1 && gameBoard[4] == 1 && gameBoard[7] == 0 {
            tagNr = 7
            return tagNr
        }
        //Block center row square 4
        if gameBoard[1] == 1 && gameBoard[7] == 1 && gameBoard[4] == 0 {
            tagNr = 4
            return tagNr
        }
        //Block center row square 1
        if gameBoard[4] == 1 && gameBoard[7] == 1 && gameBoard[1] == 0 {
            tagNr = 1
            return tagNr
        }
        //Block right row square 8
        if gameBoard[2] == 1 && gameBoard[5] == 1 && gameBoard[8] == 0 {
            tagNr = 8
            return tagNr
        }
        //Block top row square 5
        if gameBoard[2] == 1 && gameBoard[8] == 1 && gameBoard[5] == 0 {
            tagNr = 5
            return tagNr
        }
        //Block top row square 2
        if gameBoard[5] == 1 && gameBoard[8] == 1 && gameBoard[2] == 0 {
            tagNr = 2
            return tagNr
        }

        else {
            var listOfZeros = [Int]()
            var zero = 0
            
            for index in gameBoard {
                if index == 0 {
                    zero = tagNr
                    listOfZeros.append(zero)
                }
                tagNr += 1
            }
            listOfZeros.shuffle()
            if listOfZeros.count >= 2 && gameIsActive == true {
            tagNr = listOfZeros[0]
                print(tagNr)
                return tagNr
                
            }
            
        }

        return tagNr
    }    
}


