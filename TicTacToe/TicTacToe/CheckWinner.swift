//
//  CheckWinner.swift
//  TicTacToe
//
//  Created by Olof Hammar on 2020-12-16.
//

import Foundation
import UIKit

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
}
