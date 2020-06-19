//
//  AIPlayer.swift
//  TicTacToe
//
//  Created by Victor Melo on 09/05/20.
//  Copyright © 2020 Victor Melo. All rights reserved.
//

import Foundation

public struct AIPlayer {
    
    public var player: Player {
        return (GameConfig.playerSelected == X) ? O : X
    }
    
    public func play(board: Board) -> (x: Int, y: Int)? {
        let minMaxResult = minimax(board: board)
        switch minMaxResult {
        case .action(let action):
            return action
        case .utility(let utility):
            print("End game: \(utility)")
        }
        
        return nil
    }
    
}
