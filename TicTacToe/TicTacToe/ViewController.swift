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
    @IBOutlet weak var playerTwoUserView: UIView!
    @IBOutlet weak var playerOneUserView: UIView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var gameLabel: UILabel!
    @IBOutlet weak var playerXScoreLabel: UILabel!
    @IBOutlet weak var playerOScoreLabel: UILabel!
    @IBOutlet weak var playerXNameLabel: UILabel!
    @IBOutlet weak var playerONameLabel: UILabel!
    @IBOutlet weak var resetGameButton: UIButton!
    @IBOutlet weak var startNewGameButton: UIButton!
    @IBOutlet weak var resetScoreButton: UIButton!
    @IBOutlet weak var changePlayerModeButton: UIButton!
    
    private let gamePlay = CheckWinner()
    private let playerX = Player(brick: "X")
    private let playerO = Player(brick: "O")
    private var aiIsActivated = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        playerXNameLabel.text = playerX.name
        playerONameLabel.text = playerO.name
        
        addBorderToView(view: playerOneUserView, color: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
        addBorderToView(view: playerTwoUserView, color: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
        addBorderToView(view: topView, color: .black)
        addBorderToView(view: bottomView, color: .black)
        addBorderToLabel(view: gameLabel)
        
        gameLabel.isHidden = true
        
    }
    
    /*
     When square is clicked this function sets the buttons title to X or O, updates the gameboard
     and then checks if there is a winner. It also handles the play for the computer in single player mode.
     */
    @IBAction func buttonSelectedSquare(_ sender: UIButton) {
       
        if gamePlay.gameBoard[sender.tag] == 0 && gamePlay.gameIsActive == true {
        
            if gamePlay.playersTurn == playerX.brick {
                
                animatePlayerMove(button: sender)
                sender.setTitle(playerX.brick, for: .normal)
                gamePlay.updateGameboard(i: sender.tag, player: 1)
                gamePlay.checkForWinningCombination()
                
                if aiIsActivated == true {

                    if gamePlay.gameIsActive == true {
                        
                        gamePlay.tagNr = gamePlay.aiLogic()
                        setAiButton(tag: gamePlay.tagNr)
                        gamePlay.playersTurn = playerX.brick
                    }
                }
                
                else {
                    
                    gamePlay.playersTurn = playerO.brick
                }
            }
            
            else {
                
                animatePlayerMove(button: sender)
                sender.setTitle(playerO.brick, for: .normal)
                gamePlay.updateGameboard(i: sender.tag, player: 2)
                gamePlay.playersTurn = playerX.brick
            }
            
            gamePlay.checkForWinningCombination()
            gamePlay.printWinner(scoreLabelX: playerXScoreLabel, scoreLabelO: playerOScoreLabel,
                                 gameLabel: gameLabel, playerX: playerX, playerO: playerO)
        }
    }
    
    //This function switches from 1 and 2 player mode when button is clicked.
    @IBAction func ChangePlayerModeButtonPressed(_ sender: Any) {
        
        if aiIsActivated == false {
            
            aiIsActivated = true
            resetGameBoard()
            resetScores()
            playerO.updateName(newName: "Robot")
            playerONameLabel.text = playerO.name
            changePlayerModeButton.setTitle("2 PLAYERS", for: .normal)
            
        }
        else {
            
            aiIsActivated = false
            resetGameBoard()
            resetScores()
            playerO.updateName(newName: "Username")
            playerONameLabel.text = playerO.name
            changePlayerModeButton.setTitle("SINGLE PLAYER", for: .normal)
        }
    }
    
    //This function resets the gameboard when button is clicked.
    @IBAction func resetGameBoardButtonPressed(_ sender: Any) {
        
        resetGameBoard()
    }
    
    //This function resets the score for both players when button is clicked.
    @IBAction func ResetScoreButtonPressed(_ sender: Any) {
        
        gameLabel.isHidden = true
        gamePlay.resetGameBoard()
        gamePlay.gameIsActive = true
        resetGameBoard()
        gamePlay.playersTurn = playerX.brick
        resetScores()
    }
    
    /*
     This function start a new game. When button is clicked an alertbox is displayed where
     the player/players can set their names. It the resets the board and scores.
     */
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
    
    /*
     This function takes the randomly selected int from ai-player and matches it to a button.tag.
     It then changes the title of the button and updates the gameboard in the correct place.
    */
    private func setAiButton(tag: Int) {
        
        if tag == squareOne.tag {
            
            animatePlayerMove(button: squareOne)
            squareOne.setTitle("O", for: .normal)
            gamePlay.updateGameboard(i: squareOne.tag, player: 2)
        }
        
        if tag == squareTwo.tag {
            
            animatePlayerMove(button: squareTwo)
            squareTwo.setTitle("O", for: .normal)
            gamePlay.updateGameboard(i: squareTwo.tag, player: 2)
        }
        
        if tag == squareThree.tag {
            
            animatePlayerMove(button: squareThree)
            squareThree.setTitle("O", for: .normal)
            gamePlay.updateGameboard(i: squareThree.tag, player: 2)
        }
        
        if tag == squareFour.tag {
            
            animatePlayerMove(button: squareFour)
            squareFour.setTitle("O", for: .normal)
            gamePlay.updateGameboard(i: squareFour.tag, player: 2)
        }
        
        if tag == squareFive.tag {
            
            animatePlayerMove(button: squareFive)
            squareFive.setTitle("O", for: .normal)
            gamePlay.updateGameboard(i: squareFive.tag, player: 2)
        }
        
        if tag == squareSix.tag {
            
            animatePlayerMove(button: squareSix)
            squareSix.setTitle("O", for: .normal)
            gamePlay.updateGameboard(i: squareSix.tag, player: 2)
        }
        
        if tag == squareSeven.tag {
            
            animatePlayerMove(button: squareSeven)
            squareSeven.setTitle("O", for: .normal)
            gamePlay.updateGameboard(i: squareSeven.tag, player: 2)
        }
        
        if tag == squareEight.tag {
            
            animatePlayerMove(button: squareEight)
            squareEight.setTitle("O", for: .normal)
            gamePlay.updateGameboard(i: squareEight.tag, player: 2)
        }
        
        if tag == squareNine.tag {
            
            animatePlayerMove(button: squareNine)
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
        gamePlay.playersTurn = playerX.brick

    }
    
    //This function resets the score on both players
    private func resetScores() {
    
        playerX.resetPlayerScore()
        playerO.resetPlayerScore()
        playerXScoreLabel.text = String(playerX.wins)
        playerOScoreLabel.text = String(playerO.wins)
    }
    
    //The functions below handles ui-design
    private func addBorderToView(view: UIView, color: UIColor) {
        
        let bottomBorder = UIView(frame: CGRect(x: 0, y: view.frame.size.height-1, width: view.frame.width, height: 1.0))
        bottomBorder.backgroundColor = color
        view.addSubview(bottomBorder)
        
        let topBorder = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 1.0))
        topBorder.backgroundColor = color
        view.addSubview(topBorder)
    }
    
    private func addBorderToLabel(view: UILabel) {
        
        let bottomBorder = UIView(frame: CGRect(x: -1, y: view.frame.size.height-20, width: view.frame.size.width, height: 1.0))
        bottomBorder.backgroundColor = .systemBlue
        view.addSubview(bottomBorder)
        
        let topBorder = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 1.0))
        topBorder.backgroundColor = .systemBlue
        view.addSubview(topBorder)
    }
    
    //This function does a short animation so that the displayed brick fades in smooth
    private func animatePlayerMove (button: UIButton) {
        
        button.titleLabel?.alpha = 0
        UIView.animate(withDuration: 0.1, animations: {button.titleLabel?.alpha = 1.0})
    }
    
    /*
      This function loads the tutorial the first time the app is used. I use the
      userDefaults to save a boolean which only shows the tutorial if bool is true.
    */
 
    override func viewDidAppear(_ animated: Bool) {
        /*
        if UserDefaults.standard.bool(forKey: "walkthroughHasBeenSeen") {
            return
        }
 */

        let storyBoard = UIStoryboard(name: "onBoarding", bundle: nil)
        if let walkthtroughViewController = storyBoard.instantiateViewController(identifier: "WalkthroughViewController") as? WalkthroughViewController {
            
            present(walkthtroughViewController, animated: true, completion: nil)
        }
    }
}



