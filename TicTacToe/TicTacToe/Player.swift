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
