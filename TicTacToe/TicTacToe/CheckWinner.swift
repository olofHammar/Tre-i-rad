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
 squares. I then use the method updateGameboard to change these numbers to either 1 for X or
 2 for O. The variable Winner is set to zero by default and changes to 1 if X wins, 2 if O wins
 and 3 if there is a tie.
 */

class CheckWinner {
    
    var winner: Int
    var gameBoard: Array<Int>
    var gameIsActive: Bool
    var playersTurn: String
    
    init() {
        
        self.winner = 0
        self.gameBoard = [0,0,0,0,0,0,0,0,0]
        self.gameIsActive = true
        self.playersTurn = "X"
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
}


