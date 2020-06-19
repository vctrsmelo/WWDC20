//
//  GameConfig.swift
//  TicTacToe
//
//  Created by Victor Melo on 09/05/20.
//  Copyright © 2020 Victor Melo. All rights reserved.
//

import Foundation
import SwiftUI

public struct GameConfig {
    public static let playerSelected: Int = X
    public static let cellWidth: Int = 60
    public static var dimension: Int = 3
    public static var humanPlayer = "👩"
    public static let robotPlayer = "🤖"
    
    public static let minimaxMaxBreadthSearch3x3 = 10
    public static let minimaxMaxDepthSearch3x3 = 6
    
    public static let minimaxMaxBreadthSearch4x4 = 12
    public static let minimaxMaxDepthSearch4x4 = 4
    
    public static let minimaxMaxBreadthSearch5x5 = 16
    public static let minimaxMaxDepthSearch5x5 = 4
}

public enum GameSizes {
    
    public struct SettingsView {
        public static let maxBoardSizeButtonWidth: CGFloat = UIScreen.main.bounds.width * 1/3
        public static let maxCharacterButtonHeight: CGFloat = UIScreen.main.bounds.width * 1/7
    }
    
    public enum GameView {
        public static let fixedSpacerHeight: CGFloat = UIScreen.main.bounds.height * 0.02
    }

}
