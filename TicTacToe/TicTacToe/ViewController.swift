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
    @IBOutlet weak var resetGameButton: UIButton!
    @IBOutlet weak var playerTwoUserView: UIView!
    @IBOutlet weak var playerOneUserView: UIView!
    @IBOutlet weak var playVsComputer: UIButton!
    @IBOutlet weak var playerXScore: UILabel!
    @IBOutlet weak var playerOScore: UILabel!
    
    let gamePlay = CheckWinner()
    let playerX = Player()
    let playerO = Player()

    override func viewDidLoad() {
        super.viewDidLoad()
        addBorder(view: playerOneUserView)
        addBorder(view: playerTwoUserView)
        resetGameButton.layer.cornerRadius = 15
        playVsComputer.layer.cornerRadius = 15
        gameLabel.isHidden = true
            }
    
    @IBAction func buttonSelectedSquare(_ sender: UIButton) {
       
        if gamePlay.gameBoard[sender.tag] == 0 && gamePlay.gameIsActive == true {
            print(gamePlay.gameBoard)
            if gamePlay.playersTurn == "X" {
            sender.setTitle("X", for: .normal)
            //sender.setTitleColor(.black, for: .normal)
            gamePlay.updateGameboard(i: sender.tag, player: 1)
            gamePlay.playersTurn = "O"
        }
            
        else {
            sender.setTitle("O", for: .normal)
            //sender.setTitleColor(.systemOrange, for: .normal)
            gamePlay.updateGameboard(i: sender.tag, player: 2)
            gamePlay.playersTurn = "X"
        }
        }
        
        gamePlay.checkForWinningCombination()
        
        if gamePlay.winner == 1 {
            gamePlay.gameIsActive = false
            gameLabel.isHidden = false
            gameLabel.text = "X WINS THE GAME"
            playerX.addWin()
            playerXScore.text = String(playerX.wins)
        }
        
        else if gamePlay.winner == 2 {
            gamePlay.gameIsActive = false
            gameLabel.isHidden = false
            gameLabel.text = "O WINS THE GAME"
            playerO.addWin()
            playerOScore.text = String(playerO.wins)
        }
        
        else if gamePlay.winner == 3 {
            gamePlay.gameIsActive = false
            gameLabel.isHidden = false
            gameLabel.text = "THE GAME IS A TIE"
        }
    }
    
    @IBAction func resetGameBoardButtonPressed(_ sender: Any) {
        
        gameLabel.isHidden = true
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
    private func addBorder(view: UIView) {
        let bottomBorder = UIView(frame: CGRect(x: 0, y: view.frame.size.height-1, width:
        view.frame.width, height: 1.0))
        bottomBorder.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        view.addSubview(bottomBorder)
        
        let topBorder = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 1.0))
        topBorder.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        view.addSubview(topBorder)
    }
    
    }


