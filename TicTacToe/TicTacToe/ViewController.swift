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
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var playerXScore: UILabel!
    @IBOutlet weak var playerOScore: UILabel!
    @IBOutlet weak var playerONameLabel: UILabel!
    @IBOutlet weak var playerXNameLabel: UILabel!
    @IBOutlet weak var startNewGameButton: UIButton!
    @IBOutlet weak var resetScoreButton: UIButton!
    @IBOutlet weak var changePlayerModeButton: UIButton!
    let gamePlay = CheckWinner()
    let playerX = Player()
    let playerO = Player()
    var aiIsActivated = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addBorderToView(view: playerOneUserView, color: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
        addBorderToView(view: playerTwoUserView, color: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
        addBorderToView(view: topView, color: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
        addBorderToView(view: bottomView, color: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
        addBorderToLabel(view: gameLabel)
        gameLabel.isHidden = true
            }
    
    //The functions below until the next comment manages ui-actions
    @IBAction func buttonSelectedSquare(_ sender: UIButton) {
       
        if gamePlay.gameBoard[sender.tag] == 0 && gamePlay.gameIsActive == true {
        
            if gamePlay.playersTurn == "X" {
            sender.setTitle("X", for: .normal)
            gamePlay.updateGameboard(i: sender.tag, player: 1)
            
                if aiIsActivated == true {
                
                    var tagNr = 0
                    var listOfZeros = [Int]()
                    var zero = 0
                    
                    for index in gamePlay.gameBoard {
                        if index == 0 {
                            zero = tagNr
                            listOfZeros.append(zero)
                        }
                        tagNr += 1
                    }
                    listOfZeros.shuffle()
                    //print(listOfZeros)
                    if listOfZeros.count >= 2 {
                    tagNr = listOfZeros[0]
                    setAiButton(tag: tagNr)
                    }
                    gamePlay.playersTurn = "X"
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
        if aiIsActivated == false {
            aiIsActivated = true
            resetGameBoard()
            resetScores()
            playerONameLabel.text = "Robot"
            playerO.updateName(newName: "Robot")
            changePlayerModeButton.setTitle("2 PLAYERS", for: .normal)
            
        }
        else {
            aiIsActivated = false
            resetGameBoard()
            resetScores()
            playerONameLabel.text = "Anonymous"
            playerO.updateName(newName: "Anonymous")
            changePlayerModeButton.setTitle("SINGLE PLAYER", for: .normal)
        }
    }
    
    
    @IBAction func resetGameBoardButtonPressed(_ sender: Any) {
        
        resetGameBoard()
    }
    @IBAction func ResetScoreButtonPressed(_ sender: Any) {
        gameLabel.isHidden = true
        gamePlay.resetGameBoard()
        gamePlay.gameIsActive = true
        resetGameBoard()
        gamePlay.playersTurn = "X"
        resetScores()
    }
    
    @IBAction func StartNewGameButtonPressed(_ sender: Any) {
        
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
                    if self.aiIsActivated == false {
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
    //This function takes the randomly selected int from ai-player and matches it to a button.tag. It then changes the title of the button and updates the gameboard in the correct place.
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
    
    //This function resets the gameboard
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
    
    //This function resets the score on both players
    private func resetScores() {
    
        playerX.resetPlayerScore()
        playerO.resetPlayerScore()
        playerXScore.text = String(playerX.wins)
        playerOScore.text = String(playerO.wins)
    }
    
    //The functions below handles ui-design
    private func addBorderToView(view: UIView, color: UIColor) {
        let bottomBorder = UIView(frame: CGRect(x: 0, y: view.frame.size.height-1, width:
        view.frame.width, height: 1.0))
        bottomBorder.backgroundColor = color
        view.addSubview(bottomBorder)
        
        let topBorder = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 1.0))
        topBorder.backgroundColor = color
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
    }


