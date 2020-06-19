//
//  BoardView.swift
//  TicTacToe
//
//  Created by Victor Melo on 09/05/20.
//  Copyright © 2020 Victor Melo. All rights reserved.
//

import SwiftUI
import Combine

public struct BoardView: View {
    
    @Binding public var board: Board
    @Binding public var currentShiftingDirection: ShiftPlay.ShiftDirection
    @Binding public var gameState: GameState
    
    public var isAIPlaying: Bool {
        return gameState == .robotPlaying
    }
    
    public let ai = AIPlayer()

    public var body: some View {
        ZStack {
                VStack(spacing: 0) {
                    ForEach((0 ..< self.board.dimension), id: \.self) { y in
                        HStack(spacing: 0) {
                            ForEach((0 ..< self.board.dimension), id: \.self) { x in
                                self.getCellView(matrix: self.board.matrix, x: x, y: y)
                                    .onTapGesture {
                                        guard self.gameState == .playerPlaying || self.gameState == .playerHacking else { return }
                                        
                                        if self.board.currentPlayer() != 1 {
                                            self.board.switchPlayer()
                                        }
                                        
                                        if self.currentShiftingDirection != ShiftPlay.ShiftDirection.none {
                                            self.playShifting(self.currentShiftingDirection, x: x, y: y)
                                            self.gameState = self.gameState.getNext(self.board, nextExpected: .robotPlaying)
                                            self.aiPlay()
                        
                                        } else if self.board.isEmpty(x: x, y: y) {
                                            Play.play(MarkPlay(x: x, y: y, player: self.board.currentPlayer()), board: &self.board)
                                            self.gameState = self.gameState.getNext(self.board, nextExpected: .robotPlaying)
                                            self.aiPlay()
                                        }
                                }
                            }
                        }
                    }
                }
            }.onAppear {
                self.currentShiftingDirection = .none
            }
    }
    
    private func playShifting(_ direction: ShiftPlay.ShiftDirection, x: Int, y: Int) {
        board.switchPlayer()
        
        switch direction {
        case .top, .bottom:
            Play.play(ShiftColPlay(direction: direction, col: x), board: &self.board)
        case .left, .right:
            Play.play(ShiftRowPlay(direction: direction, row: y), board: &self.board)
            
        default:
            break
        }

        self.currentShiftingDirection = .none
    }
    
    private func getCellView(matrix: [[Player]], x: Int, y: Int) -> BoardCellView {
        
        BoardCellView(value: Character(formattedPlayer(matrix[x][y])), size: CGSize(width: GameConfig.cellWidth, height: GameConfig.cellWidth))
    }
    
    
    private func aiPlay() {
        guard gameState == .robotPlaying else { return }
        DispatchQueue.global(qos: .default).async {
            if self.board.terminal() { return }

            let action = self.ai.play(board: self.board)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                self.board.play(self.ai.player, x: action!.x, y: action!.y)
                self.gameState = self.gameState.getNext(self.board, nextExpected: .playerPlaying)
            }
        }
    }
    
    private func formattedPlayer(_ value: Int) -> String {
        let player = value == 1 ? GameConfig.humanPlayer : (value == -1 ? GameConfig.robotPlayer : " ")
        
        return player
    }
}

// MARK: BoardCellView

public struct BoardCellView: View {
    
    public var value: Character = "E"
    public let size: CGSize
    public let color: Color
    
    public init(value: Character, size: CGSize) {
        self.value = value
        self.size = size
        self.color = String(value) == GameConfig.humanPlayer ? .blue : ( String(value) == GameConfig.robotPlayer ? .red : .clear)
    }
    
    public var body: some View {
        Text(String(value))
            .frame(width: size.width, height: size.height, alignment: .center)
            .font(Font.system(size: 40, weight: .regular, design: .default))
            .contentShape(Rectangle())
            .border(Color.black)
            .background(color)

    }
    
}
