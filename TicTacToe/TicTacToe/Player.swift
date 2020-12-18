//
//  Player.swift
//  TicTacToe
//
//  Created by Olof Hammar on 2020-12-17.
//

import Foundation

class Player {
    var name: String
    var brick: String
    var wins: Int
    
    init(brick: String) {
        self.name = "Anonymous"
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
