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
    let gamePlay = CheckWinner()
    //var gameIsActive = true
    //var playersTurn = "X"
    var playerOneVictorys = 0
    var playerTwoVictorys = 0
    //var gameBoard = [0, 0, 0, 0, 0, 0, 0, 0, 0]

    override func viewDidLoad() {
        super.viewDidLoad()
            }
    
    @IBAction func buttonSelectedSquare(_ sender: UIButton) {
       
        if gamePlay.gameBoard[sender.tag] == 0 && gamePlay.gameIsActive == true {
            print(gamePlay.gameBoard)
            if gamePlay.playersTurn == "X" {
            sender.setTitle("X", for: .normal)
            sender.setTitleColor(.black, for: .normal)
            gamePlay.updateGameboard(i: sender.tag, player: 1)
            //[sender.tag] = 1
                gamePlay.playersTurn = "O"
        }
        else {
            sender.setTitle("O", for: .normal)
            sender.setTitleColor(.systemRed, for: .normal)
            gamePlay.updateGameboard(i: sender.tag, player: 2)
            //[sender.tag] = 2
            gamePlay.playersTurn = "X"
        }
        }
        gamePlay.checkForWinningCombination()
        if gamePlay.winner == 1 {
            gamePlay.gameIsActive = false
            gameLabel.text = "X has won!"
        }
        else if gamePlay.winner == 2 {
            gamePlay.gameIsActive = false
            gameLabel.text = "O has won!"
        }
        else if gamePlay.winner == 3 {
            gamePlay.gameIsActive = false
            gameLabel.text = "The game is a tie."
        }
    }
    
    @IBAction func resetGameBoardButtonPressed(_ sender: Any) {
        
        gamePlay.resetGameBoard()
        gamePlay.gameIsActive = true
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
        gamePlay.playersTurn = "X"
    }
    
    }


