//
//  Player.swift
//  TicTacToe
//
//  Created by Olof Hammar on 2020-12-17.
//

import Foundation

class Player {
    var name: String
    var wins: Int
    
    init() {
        self.name = ""
        self.wins = 0
    }
    
    func addWin()  {
        wins += 1
    }
}
