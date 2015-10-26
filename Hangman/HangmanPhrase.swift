//
//  HangmanPhrase.swift
//  Hangman
//
//  Created by Gene Yoo on 10/13/15.
//  Copyright © 2015 cs198-ios. All rights reserved.
//

import Foundation

class HangmanPhrase {
    var phrases : NSArray!

    init() {
        let path = NSBundle.mainBundle().pathForResource("phrases", ofType: "plist")
        phrases = NSArray.init(contentsOfFile: path!)
    }
    
    func getRandomPhrase() -> String! {
        let ind = Int(arc4random_uniform(UInt32(phrases.count)))
        return phrases.objectAtIndex(ind) as! String
    }

}