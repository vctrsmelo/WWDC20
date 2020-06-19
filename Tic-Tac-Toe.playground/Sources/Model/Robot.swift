//
//  Robot.swift
//  TicTacToe
//
//  Created by Victor Melo on 13/05/20.
//  Copyright © 2020 Victor Melo. All rights reserved.
//

import Foundation

public class Robot {
    
    public let faceImageName: String = "RobotFace"
    
    public var playerPlayingMessage: String {
        randomMessageFrom([
            "Your turn",
            "Now you play",
            "Your move",
            "It's your turn, 70% water thing.",
            "Your move, biped.",
            "Your play, human.",
            "Your turn, human number 1100101010101",
            "Your play, carbon.",
            "Your play, descendant of monkey.",
            "It's your turn. I will research the whole internet while I wait.. Done!",
            "Now you play, carbon based 'life'."
        ])
    }
    
    public var playerHackingMessage: String {
        randomMessageFrom([
            "Hey, what is it? This is not in game rules."
        ])
    }
    
    public var robotPlayingMessage: String {
        randomMessageFrom([
            "Hmm...",
            "Let's see..."
        ])
    }
    
    public var playerWinMessage: String {
        randomMessageFrom([
            "This is impossible! I lost for this... bunch of meat!",
            "Oh no! I lost for this bag of mostly water!",
            "BzzZZz... ouch my circuits. This is impossible!"
        ])
    }
    
    public var robotWinMessage: String {
        randomMessageFrom([
            "Just as expected! Silicon > Carbon",
            "I'm a superior being, human. Accept it!"
        ])
    }
    
    public var drawMessage: String {
        randomMessageFrom([
            "You can't win, human. My silicon predicts all your moves.",
            "Another draw. I can't be beaten, not by something made of carbon lol."
        ])
    }
    
    public func getMessage(_ state: GameState) -> String {
        switch state {
        case .playerPlaying: return playerPlayingMessage
        case .playerHacking: return playerHackingMessage
        case .robotPlaying: return robotPlayingMessage
        case .playerWin: return playerWinMessage
        case .robotWin: return robotWinMessage
        case .draw: return drawMessage
        }
        
    }
    
    public func randomMessageFrom(_ messages: [String]) -> String {
        messages[Int.random(in: 0..<messages.count)]
    }
    
}
