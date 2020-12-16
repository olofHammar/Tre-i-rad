//
//  CheckWinner.swift
//  TicTacToe
//
//  Created by Olof Hammar on 2020-12-16.
//

import Foundation

class CheckWinner {
    
    var winner: Int
    
    init(winner: Int) {
        self.winner = winner
    }
    
    func checkForWinningCombination (board: Array<Int>) -> Int {
        
        let winningCombos = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]

        for combo in winningCombos {
            if board[combo[0]] != 0 && board[combo[0]] == board[combo[1]] &&
                board[combo[1]] == board[combo[2]] {
                
                if board[combo[0]] == 1 {
                    winner = 1
                }
                else {
                    winner = 2
                }
            }
        }
        
        return self.winner
    }
}