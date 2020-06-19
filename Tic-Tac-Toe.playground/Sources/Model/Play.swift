//
//  Play.swift
//  TicTacToe
//
//  Created by Victor Melo on 10/05/20.
//  Copyright © 2020 Victor Melo. All rights reserved.
//

import Foundation

public protocol PlayType {
    func play(_ board: inout Board)
}


public struct Play {
    
    public static func play(_ type: PlayType, board: inout Board) {
        type.play(&board)
    }
    
}

public struct MarkPlay: PlayType {
    
    public let x: Int
    public let y: Int
    public let player: Player
    
    public func play(_ board: inout Board) {
        board.play(player, x: x, y: y)
    }
}

public struct ShiftPlay: PlayType {
    
    public enum ShiftDirection: String {
        case top
        case left
        case right
        case bottom
        case none
    }
    
    public let direction: ShiftDirection
    
    public func play(_ board: inout Board) {

        var newBoard: Board
        switch self.direction {
        case .left:
            newBoard = shift(board.matrix, rightShift: board.matrix.count-1, bottomShift: 0)
        case .right:
            newBoard = shift(board.matrix, rightShift: 1, bottomShift: 0)
        case .bottom:
            newBoard = shift(board.matrix, rightShift: 0, bottomShift: 1)
        case .top:
            newBoard = shift(board.matrix, rightShift: 0, bottomShift: board.matrix.count-1)
        case .none:
            newBoard = board
        }
        board = newBoard
    }
    
    private func shift(_ matrix: [[Player]], rightShift: Int, bottomShift: Int) -> Board {
        var board = Board(dimension: matrix.count)
                
        for x in 0 ..< matrix.count {
            for y in 0 ..< matrix.count {
                let newX = (x+rightShift) % matrix.count
                let newY = (y+bottomShift) % matrix.count
                board.play(matrix[x][y], x: newX, y: newY)
            }
        }
        
        return board
    }
    
}


public struct ShiftColPlay: PlayType {
    
    public let direction: ShiftPlay.ShiftDirection
    public let col: Int
    
    
    public func play(_ board: inout Board) {

        var newBoard: Board
        
        switch self.direction {
        case .bottom:
            newBoard = shift(board.matrix, bottomShift: 1)
        case .top:
            newBoard = shift(board.matrix, bottomShift: board.matrix.count-1)
        default:
            newBoard = board
        }
        board = newBoard
    }
    
    private func shift(_ matrix: [[Player]], bottomShift: Int) -> Board {
        var board = Board(dimension: matrix.count)
        
        for y in 0 ..< matrix.count {
                let newY = (y+bottomShift) % matrix.count
                board.play(matrix[col][y], x: col, y: newY)
        }
        
        for x in 0 ..< matrix.count {
            if x == col { continue }
            for y in 0 ..< matrix.count {
                board.play(matrix[x][y], x: x, y: y)
            }
        }
        
        return board
    }
    
}

public struct ShiftRowPlay: PlayType {
    
    public let direction: ShiftPlay.ShiftDirection
    public let row: Int
    
    public func play(_ board: inout Board) {

        var newBoard: Board
        switch self.direction {
        case .right:
            newBoard = shift(board.matrix, rightShift: 1)
        case .left:
            newBoard = shift(board.matrix, rightShift: board.matrix.count-1)
        default:
            newBoard = board
        }
        board = newBoard
    }
    
    private func shift(_ matrix: [[Player]], rightShift: Int) -> Board {
        var board = Board(dimension: matrix.count)
        
        for x in 0 ..< matrix.count {
            let newX = (x+rightShift) % matrix.count
            board.play(matrix[x][row], x: newX, y: row)
        }
        
        for x in 0 ..< matrix.count {
            for y in 0 ..< matrix.count {
                if y == row { continue }
                board.play(matrix[x][y], x: x, y: y)
            }
        }
        
        return board
    }
    
}
