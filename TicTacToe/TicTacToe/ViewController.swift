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
    let checkWinner = CheckWinner(winner: 0)
    var gameIsActive = true
    var playersTurn = "X"
    var playerOneVictorys = 0
    var playerTwoVictorys = 0
    var gameBoard = [0, 0, 0, 0, 0, 0, 0, 0, 0]

    override func viewDidLoad() {
        super.viewDidLoad()
            }
    
    @IBAction func buttonSelectedSquare(_ sender: UIButton) {
       
        if gameBoard[sender.tag] == 0 && gameIsActive == true {
        print(gameBoard)
        if playersTurn == "X" {
            sender.setTitle("X", for: .normal)
            sender.setTitleColor(.black, for: .normal)
            gameBoard[sender.tag] = 1
            playersTurn = "O"
        }
        else {
            sender.setTitle("O", for: .normal)
            sender.setTitleColor(.systemRed, for: .normal)
            gameBoard[sender.tag] = 2
            playersTurn = "X"
        }
        }
        checkWinner.checkForWinningCombination(board: gameBoard)
        if checkWinner.winner == 1 {
            gameIsActive = false
            gameLabel.text = "X has won!"
        }
        else if checkWinner.winner == 2 {
            gameIsActive = false
            gameLabel.text = "O has won!"
        }
        else if checkWinner.winner == 3 {
            gameIsActive = false
            gameLabel.text = "The game is a tie."
        }
    }
    
    @IBAction func resetGameBoardButtonPressed(_ sender: Any) {
        
        gameBoard =  [0, 0, 0, 0, 0, 0, 0, 0, 0]
        gameIsActive = true
        squareOne.setTitle("", for: .normal)
        squareTwo.setTitle("", for: .normal)
        squareThree.setTitle("", for: .normal)
        squareFour.setTitle("", for: .normal)
        squareFive.setTitle("", for: .normal)
        squareSix.setTitle("", for: .normal)
        squareSeven.setTitle("", for: .normal)
        squareEight.setTitle("", for: .normal)
        squareNine.setTitle("", for: .normal)
        gameLabel.text?.removeAll()
        playersTurn = "X"
    }
    
    }


