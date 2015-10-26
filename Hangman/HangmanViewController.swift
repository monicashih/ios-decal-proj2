//
//  ViewController.swift
//  Hangman
//
//  Created by Gene Yoo on 10/13/15.
//  Copyright © 2015 cs198-ios. All rights reserved.
//

import UIKit

class HangmanViewController: UIViewController {
    
    @IBOutlet weak var enterText: UITextField!
    @IBOutlet weak var previousGuess: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var matchedLetters: UILabel!
    
    var hangman = Hangman()
    var numFailedGuesses: Int = 0
    var started: Bool = false
    var initialString: String = ""


    @IBAction func newGame(sender: AnyObject) {

        hangman.start()
        started = true
        numFailedGuesses = 0
        image.image = UIImage(named:"hangman1.gif")
        previousGuess.text = ""
        initialString = hangman.knownString!
        matchedLetters.text = hangman.knownString
        
    }
    
    @IBAction func restart(sender: AnyObject) {
        if started {
            started = true
            numFailedGuesses = 0
            image.image = UIImage(named:"hangman1.gif")
            hangman.guessedLetters = NSMutableArray()
            hangman.knownString = initialString
            previousGuess.text = ""
            matchedLetters.text = ""
        }
    }
    
    @IBAction func check (sender: AnyObject) {
        if !started || enterText.text == "" {
            self.view.endEditing(true)
            return
        }
        
        
        if enterText.text?.lowercaseString >= "a"  && enterText.text?.lowercaseString <= "z" && enterText.text?.characters.count == 1 {
            
            let guessedLetter = enterText.text!
            enterText.text = ""
            if !hangman.guessLetter(guessedLetter.uppercaseString) {
                numFailedGuesses += 1
                image.image = UIImage(named:"hangman\(numFailedGuesses+1).gif")
                previousGuess.text = hangman.guesses()
                if numFailedGuesses == 6 {
                    let lost = UIAlertController(title: "You lost!", message: "Play again?", preferredStyle: UIAlertControllerStyle.Alert)
                    lost.addAction(UIAlertAction(title: "Okie", style: UIAlertActionStyle.Cancel, handler: nil))
                    self.presentViewController(lost, animated: true, completion: nil)
                    numFailedGuesses = 0
                    started = false
                    return
                }
            }
        
        
            else {
                matchedLetters.text = hangman.knownString
                if hangman.knownString == hangman.answer {
                    let won = UIAlertController(title: "You win!!!", message: "Play again?", preferredStyle: UIAlertControllerStyle.Alert)
                    won.addAction(UIAlertAction(title: "Okie", style: UIAlertActionStyle.Cancel, handler: nil))
                    self.presentViewController(won, animated: true, completion: nil)
                    numFailedGuesses = 0
                    started = false
                    return
                    
                }
            }
            previousGuess.text = hangman.guesses()
            matchedLetters.text = hangman.knownString
            self.view.endEditing(true)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hangman.start()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

