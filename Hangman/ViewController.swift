//
//  ViewController.swift
//  Hangman
//
//  Created by Hazen on 4/11/15.
//  Copyright (c) 2015 Hazen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var pickedButtons = [UIButton]()
    let stagePictures = [
        UIImage(named: "gallows"),
        UIImage(named: "head"),
        UIImage(named: "body"),
        UIImage(named: "left-arm"),
        UIImage(named: "right-arm"),
        UIImage(named: "left-leg"),
        UIImage(named: "right-leg"),
        UIImage(named: "hands"),
        UIImage(named: "feet")
    ]
    var gameOver = false
    var model = HangmanModel()
    @IBOutlet weak var newGameButton: UIButton!
    
    @IBOutlet weak var gallows: UIImageView!
    @IBOutlet weak var word: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newGameButton.enabled = false
        model.loadWords()
        model.pickWord()
        updatePicture()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func updatePicture() {
        gallows.image = stagePictures[model.badGuess]
        
        if model.charactersLeft == 0 {
            word.text = ("You Win! " + model.word)
            newGameButton.enabled = true
            gameOver = true
        } else if model.badGuess == stagePictures.count - 1 {
            word.text = ("You Lose! " + model.word)
            newGameButton.enabled = true
            gameOver = true
        }else {
            word.text = model.userView
        }
    }
    
    @IBAction func letterPushed(sender: UIButton) {
        println("User pushed " + sender.currentTitle!)
        if gameOver == false{
            sender.enabled = false
            pickedButtons.append(sender)
            model.guessLetter(sender.currentTitle!)
            updatePicture()
        }
        //This function responds to buttons pushed
    }
    
    @IBAction func newGame(sender: UIButton) {
        println("New game")
        newGameButton.enabled = false
        gameOver = false
        for i in pickedButtons{
            i.enabled = true
        }
        pickedButtons = []
        model.pickWord()
        updatePicture()
        //this starts a new game
    }
}

