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
        
        if playersTurn == "X" {
            sender.setTitle("X", for: .normal)
            sender.setTitleColor(.black, for: .normal)
            gameBoard[sender.tag] = 1
            //sender.isEnabled = false
            //if gameBoard.contains(0){
            playersTurn = "O"
            //}
        }
        else {
            sender.setTitle("O", for: .normal)
            sender.setTitleColor(.systemRed, for: .normal)
            gameBoard[sender.tag] = 2
            //sender.isEnabled = false
            //if gameBoard.contains(0) {
            playersTurn = "X"
            //}
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
        /*
        for combo in winningCombos {
            if gameBoard[combo[0]] != 0 && gameBoard[combo[0]] == gameBoard[combo[1]] &&
                gameBoard[combo[1]] == gameBoard[combo[2]] {
                
                gameIsActive = false
                if gameBoard[combo[0]] == 1 {
                    gameLabel.text = "X has won!"
                }
                else {
                    gameLabel.text = "O has won!"
                }
                
            }
        }
 */
        
    }
    }


