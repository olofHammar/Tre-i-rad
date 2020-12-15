//
//  ViewController.swift
//  TicTacToe
//
//  Created by Olof Hammar on 2020-12-15.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var squareOne: UIButton!
    @IBOutlet weak var squareTwo: UIButton!
    @IBOutlet weak var squareThree: UIButton!
    @IBOutlet weak var squareFour: UIButton!
    @IBOutlet weak var squareFive: UIButton!
    @IBOutlet weak var squareSix: UIButton!
    @IBOutlet weak var squareSeven: UIButton!
    @IBOutlet weak var squareEight: UIButton!
    @IBOutlet weak var squareNine: UIButton!
    @IBOutlet weak var gameLabel: UILabel!
    
    //Denna variabel berättar vilken spelares tur det är.
    var playersTurn = "X"
    var playerOneVictorys = 0
    var playerTwoVictorys = 0
    var gameBoard = [0, 0, 0, 0, 0, 0, 0, 0, 0]

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func buttonSelectedSquare(_ sender: UIButton) {
        
        if playersTurn == "X" {
            sender.setTitle("X", for: .normal)
            sender.setTitleColor(.systemBlue, for: .normal)
            let position = Int(sender.tag)
            gameBoard[position-1] = 1
            sender.isEnabled = false
            if gameBoard.contains(0){
            playersTurn = "O"
            }
            else {
                gameLabel.text = "Spelet är slut."
            }
        }
        else {
            sender.setTitle("O", for: .normal)
            sender.setTitleColor(.red, for: .normal)
            let position = Int(sender.tag)
            gameBoard[position-1] = 2
            sender.isEnabled = false
            if gameBoard.contains(0) {
            playersTurn = "X"
            }
            else {
                gameLabel.text = "Spelet är slut."
            }
        }
        for item in gameBoard {
            print(String(item))
        }
            
        }
    }


