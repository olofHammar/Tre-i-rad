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
    @IBOutlet weak var playerONameLabel: UILabel!
    @IBOutlet weak var playerXNameLabel: UILabel!
    @IBOutlet weak var ResetScoreBarItem: UIBarButtonItem!
    @IBOutlet weak var StartNewGameBarItem: UIBarButtonItem!
    @IBOutlet weak var changePlayerModeButton: UIButton!
    let gamePlay = CheckWinner()
    let playerX = Player()
    let playerO = Player()
    var aiDeciding = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addBorderToView(view: playerOneUserView)
        addBorderToView(view: playerTwoUserView)
        addBorderToLabel(view: gameLabel)
        resetGameButton.layer.cornerRadius = 15
        playVsComputer.layer.cornerRadius = 15
        gameLabel.isHidden = true
            }
    
    @IBAction func buttonSelectedSquare(_ sender: UIButton) {
       
        if gamePlay.gameBoard[sender.tag] == 0 && gamePlay.gameIsActive == true {
        
            if gamePlay.playersTurn == "X" {
            sender.setTitle("X", for: .normal)
            gamePlay.updateGameboard(i: sender.tag, player: 1)
            
                if aiDeciding == true {
                
                    var tagNr = 0
                    for index in gamePlay.gameBoard {
                            
                        if index == 0 {
                            break
                    
                        }
                        tagNr += 1
                        
                    }
                    setAiButton(tag: tagNr)
                    gamePlay.playersTurn = "X"
                    print(gamePlay.gameBoard)
                       
                }
                else {
                    gamePlay.playersTurn = "O"
                }
            }
            
        else {
        
            sender.setTitle("O", for: .normal)
            gamePlay.updateGameboard(i: sender.tag, player: 2)
            gamePlay.playersTurn = "X"
            
            }
        }
        
        gamePlay.checkForWinningCombination()
        
        if gamePlay.winner == 1 {
            gamePlay.gameIsActive = false
            gameLabel.isHidden = false
            gameLabel.text = "\(playerX.name) wins the game"
            playerX.addWin()
            playerXScore.text = String(playerX.wins)
        }
        
        else if gamePlay.winner == 2 {
            gamePlay.gameIsActive = false
            gameLabel.isHidden = false
            gameLabel.text = "\(playerO.name) wins the game"
            playerO.addWin()
            playerOScore.text = String(playerO.wins)
        }
        
        else if gamePlay.winner == 3 {
            gamePlay.gameIsActive = false
            gameLabel.isHidden = false
            gameLabel.text = "The game is a tie"
        }
    }
    
    @IBAction func ChangePlayerModeButtonPressed(_ sender: Any) {
        if aiDeciding == false {
            aiDeciding = true
            resetGameBoard()
            resetScores()
            playerONameLabel.text = "I am AI"
            changePlayerModeButton.setTitle("Change to two players", for: .normal)
            
        }
        else {
            aiDeciding = false
            resetGameBoard()
            resetScores()
            playerONameLabel.text = "Anonymous"
            changePlayerModeButton.setTitle("Change to single player", for: .normal)
        }
    }
    
    
    @IBAction func resetGameBoardButtonPressed(_ sender: Any) {
        
        resetGameBoard()
    }
    @IBAction func ResetScoreBarItemPressed(_ sender: Any) {
        gameLabel.isHidden = true
        gamePlay.resetGameBoard()
        gamePlay.gameIsActive = true
        resetGameBoard()
        gamePlay.playersTurn = "X"
        resetScores()
    }
    
    @IBAction func StartNewGameBarItemPressed(_ sender: Any) {
        
        let alert = UIAlertController(title: "New game", message: "Enter player names", preferredStyle: .alert)
                
                let playAction = UIAlertAction(title: "Play", style: .default) { action in
                    
                    guard let textFieldX = alert.textFields?.first else { return}
                    guard let playerXNewName = textFieldX.text else {return}
                    if playerXNewName == "" {return}
                    
                    guard let textFieldO = alert.textFields?[1] else {return}
                    guard let playerONewName = textFieldO.text else {return}
                    if playerONewName == "" {return}
                    
                    self.playerXNameLabel.text = playerXNewName
                    self.playerONameLabel.text = playerONewName
                    self.resetScores()
                    self.resetGameBoard()
                    self.playerX.updateName(newName: playerXNewName)
                    self.playerO.updateName(newName: playerONewName)
                }
                
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
                
                alert.addAction(playAction)
                alert.addAction(cancelAction)
                alert.addTextField { textField in
                    textField.placeholder = "Name player X"
                    textField.autocapitalizationType = .words
                }
                alert.addTextField { textField in
                    if self.aiDeciding == false {
                        textField.placeholder = "Name player O"
                        textField.autocapitalizationType = .words
                    }
                    else {
                        textField.placeholder = "Name AI-computer"
                        textField.autocapitalizationType = .words
                    }
                }
                
                present(alert, animated: true)
    }
    
    private func setAiButton(tag: Int) {
        if tag == squareOne.tag {
            squareOne.setTitle("O", for: .normal)
            gamePlay.updateGameboard(i: squareOne.tag, player: 2)

        }
        if tag == squareTwo.tag {
            squareTwo.setTitle("O", for: .normal)
            gamePlay.updateGameboard(i: squareTwo.tag, player: 2)
        }
        if tag == squareThree.tag {
            squareThree.setTitle("O", for: .normal)
            gamePlay.updateGameboard(i: squareThree.tag, player: 2)
        }
        if tag == squareFour.tag {
            squareFour.setTitle("O", for: .normal)
            gamePlay.updateGameboard(i: squareFour.tag, player: 2)
        }
        if tag == squareFive.tag {
            squareFive.setTitle("O", for: .normal)
            gamePlay.updateGameboard(i: squareFive.tag, player: 2)
        }
        if tag == squareSix.tag {
            squareSix.setTitle("O", for: .normal)
            gamePlay.updateGameboard(i: squareSix.tag, player: 2)
        }
        if tag == squareSeven.tag {
            squareSeven.setTitle("O", for: .normal)
            gamePlay.updateGameboard(i: squareSeven.tag, player: 2)
        }
        if tag == squareEight.tag {
            squareEight.setTitle("O", for: .normal)
            gamePlay.updateGameboard(i: squareEight.tag, player: 2)
        }
        if tag == squareNine.tag {
            squareNine.setTitle("O", for: .normal)
            gamePlay.updateGameboard(i: squareNine.tag, player: 2)
        }
    }
    
    private func addBorderToView(view: UIView) {
        let bottomBorder = UIView(frame: CGRect(x: 0, y: view.frame.size.height-1, width:
        view.frame.width, height: 1.0))
        bottomBorder.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        view.addSubview(bottomBorder)
        
        let topBorder = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 1.0))
        topBorder.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        view.addSubview(topBorder)
    }
    
    private func addBorderToLabel(view: UILabel) {
        let bottomBorder = UIView(frame: CGRect(x: -1, y: view.frame.size.height-20, width: view.frame.size.width, height: 1))
        bottomBorder.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        view.addSubview(bottomBorder)
        
        let topBorder = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 1.0))
        topBorder.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        view.addSubview(topBorder)
    }
    
    private func resetGameBoard() {
        
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
    private func resetScores() {
    
        playerX.resetPlayerScore()
        playerO.resetPlayerScore()
        playerXScore.text = String(playerX.wins)
        playerOScore.text = String(playerO.wins)
    }
    
    }


