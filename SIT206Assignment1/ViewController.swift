//
//  ViewController.swift
//  SIT206Assignment1
//
//  Created by Kelvin Salim on 27/3/18.
//  Copyright © 2018 Kelvin Salim. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    // Variables
    var musicPlayer : AVAudioPlayer?
    var elapsedTime : TimeInterval = 0
    var activePlayer = 1 //Player1 - Cross
    var gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    
    // Winning Combination
    let winCombo = [[0, 1, 2, 3], [4, 5, 6, 7], [8, 9 ,10, 11], [12, 13, 14, 15], // Horizontal
                    [0, 4, 8, 12], [1, 5, 9, 13], [2, 6, 10, 14], [3, 7, 11, 15], // Vertical
                    [0, 5, 10, 15], [3, 6, 9, 12]] // Diagonal
    
    var gameIsActive = true
    
    // Outlet
    @IBOutlet weak var resultGame: UILabel!
    @IBOutlet weak var p1score: UILabel!
    @IBOutlet weak var p2score: UILabel!
    @IBOutlet weak var historyView: UITextView!
    @IBOutlet weak var playerOName: UILabel!
    @IBOutlet weak var playerXName: UILabel!
    @IBOutlet weak var playerXImage: UIImageView!
    @IBOutlet weak var playerOImage: UIImageView!
    @IBOutlet weak var multiPlayerIcon: UIImageView!
    @IBOutlet weak var compPlayerIcon: UIImageView!
    @IBOutlet weak var oIcon: UIImageView!
    @IBOutlet weak var xIcon: UIImageView!
    
    //CurrentScore
    var p1scorenum : Int = 0
    var p2scorenum : Int = 0
    
    @IBAction func xoAction(_ sender: UIButton)
    {
        if (gameState[sender.tag-1] == 0 && gameIsActive == true)
        {
            gameState[sender.tag-1] = activePlayer
            
            // Player Turn
            if (activePlayer == 1)
            {
                sender.setImage(UIImage(named: "x"), for: .normal)
                activePlayer = 2
            }
            else
            {
                sender.setImage(UIImage(named: "o"), for: .normal)
                activePlayer = 1
            }
        }
        
        for combination in winCombo
        {
            // Checking the Combination
            if gameState[combination[0]] != 0 && gameState[combination[0]] == gameState[combination[1]] && gameState[combination[1]] == gameState[combination[2]] && gameState[combination[2]] == gameState[combination[3]]
            {
                gameIsActive = false
                
                if gameState[combination[0]] == 1 // Check if Player 1 Win
                {
                    //Player 1 Won
                    resultGame.text = "Player X WON"
                    p1scorenum += 1
                    p1score.text = "\(p1scorenum)"
                    historyView.insertText("\nPlayer X WIN")
                }
                else
                {
                    // Player 2 Won
                    resultGame.text = "Player O WON"
                    p2scorenum += 1
                    p2score.text = "\(p2scorenum)"
                    historyView.insertText("\nPlayer O WIN")
                }
                
                resetButton.isHidden = false
                resultGame.isHidden = false
            }
        }
        
        gameIsActive = false
        
        for i in gameState
        {
            if i == 0
            {
                gameIsActive = true
                break
            }
        }
        
        // Check if the Game Draw
        if gameIsActive == false
        {
            resultGame.text = "DRAW!"
            historyView.insertText("\nDRAW!")
            resultGame.isHidden = false
            resetButton.isHidden = false
        }
    }
    
    
    // Reset Game
    @IBOutlet weak var resetButton: UIButton!
    @IBAction func resetButton(_ sender: UIButton) {
        gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        gameIsActive = true
        activePlayer = 1
        
        resetButton.isHidden = false
        resultGame.isHidden =  false
        
        for i in 1...16
        {
            let button = view.viewWithTag(i) as! UIButton
            button.setImage(nil, for: .normal)
        }
    }
    
    // Choosing Icon for Player 1
    @IBOutlet weak var iconChoose: UISwitch!
    @IBAction func iconChoose(_ sender: UISwitch) {
        if sender.isOn {
            activePlayer = 2 // O Chosen
        }
        else {
            activePlayer = 1 // X Chosen
        }
    }
    
    // Music
    @IBAction func musicOff(_ sender: UIButton) {
        if musicPlayer != nil{
            elapsedTime = musicPlayer!.currentTime
            musicPlayer!.pause()
        }
    }
    
    @IBAction func musicOn(_ sender: UIButton) {
        if musicPlayer != nil{
            musicPlayer!.currentTime = elapsedTime
            musicPlayer!.play()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // URL of the Song name and type
        let path = Bundle.main.path(forResource: "dirtybullet", ofType: "mp3")
        
        let url = URL(fileURLWithPath: path!)
        
        do {
            // set up the player by loading the sound file
            try musicPlayer = AVAudioPlayer(contentsOf: url)
        }
            // catch the error if playback fails
        catch { print("file not availalbe")}
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


