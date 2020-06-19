//
//  GameState.swift
//  TicTacToe
//
//  Created by Victor Melo on 13/05/20.
//  Copyright © 2020 Victor Melo. All rights reserved.
//

import Foundation

public enum GameState: String {
    
    case playerPlaying
    case playerHacking
    case robotPlaying
    case playerWin
    case robotWin
    case draw
    
    public func getNext(_ board: Board, nextExpected: GameState) -> GameState {
        if board.terminal() {
            return GameState.getWinner(board.winner())
        }
        
        if self == .robotPlaying && nextExpected != .playerPlaying {
            assertionFailure("\(self.rawValue) should transition only to .playerPlaying, not to \(nextExpected.rawValue)")
        }
        
        if self == .playerPlaying && nextExpected != .playerHacking && nextExpected != .robotPlaying {
            assertionFailure("\(self.rawValue) should transition only to .playerHacking or .robotPlaying, not to \(nextExpected.rawValue)")
        }
        
        if self == .playerHacking && nextExpected != .robotPlaying {
            assertionFailure("\(self.rawValue) should transition only to .robotPlaying, not to \(nextExpected.rawValue)")
        }
        
        return nextExpected
    }
    
    public static func getWinner(_ player: Player) -> GameState {
        if player == X {
            return .playerWin
        } else if player == O {
            return .robotWin
        } else {
            return .draw
        }
    }
}
