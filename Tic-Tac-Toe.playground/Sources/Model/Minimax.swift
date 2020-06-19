import Foundation

public enum MinimaxResult {
    case action(_ tuple: (x: Int, y: Int))
    case utility(Int)
}

public func minimax(board: Board) -> MinimaxResult {
    if board.terminal() {
        return .utility(board.utility())
    }
    
    let isMaxPlayer = board.currentPlayer() == X
    
    var maxActionBreadth = board.dimension == 3 ? GameConfig.minimaxMaxBreadthSearch3x3 : (board.dimension == 4 ? GameConfig.minimaxMaxBreadthSearch4x4 : GameConfig.minimaxMaxBreadthSearch5x5)
    let maxDepthSearch = board.dimension == 3 ? GameConfig.minimaxMaxDepthSearch3x3 : (board.dimension == 4 ? GameConfig.minimaxMaxDepthSearch4x4 : GameConfig.minimaxMaxDepthSearch5x5)
    
    
    if isMaxPlayer {
        var value = -99999
        var currentAction: (x: Int, y: Int) = board.actions().randomElement()!
    
        for action in board.actions().shuffled() {
            
            if maxActionBreadth == 0 {
                return .action(currentAction)
            }
            maxActionBreadth -= 1
            
            let v = minValuePruning(board.result(action: action), alpha: -99999, beta: 99999, movement: maxDepthSearch)
            if v > value {
                value = v
                currentAction = action
            }
        }
        
        return .action(currentAction)
        
    } else {
        var value = 99999
        var currentAction: (x: Int, y: Int) = board.actions().randomElement()!
        for action in board.actions().shuffled() {
            
            if maxActionBreadth == 0 {
                return .action(currentAction)
            }
            maxActionBreadth -= 1
            
            let v = maxValuePruning(board.result(action: action), alpha: -99999, beta: 99999, movement: maxDepthSearch)
            if v < value {
                value = v
                currentAction = action
            }
        }
        
        return .action(currentAction)
    }
}

public func maxValuePruning(_ board: Board, alpha inAlpha: Int, beta inBeta: Int, movement: Int) -> Int {
    if board.terminal() {
        let result = board.utility()
        return result
    }
    
    if movement == 0 {
        return fitness(board: board)
    }
    
    var v = -99999
    var alpha = inAlpha
    let beta  = inBeta
    
    var currentBreadth = board.dimension == 3 ? GameConfig.minimaxMaxBreadthSearch3x3 : (board.dimension == 4 ? GameConfig.minimaxMaxBreadthSearch4x4 : GameConfig.minimaxMaxBreadthSearch5x5)
    for action in board.actions() {
        
        if currentBreadth == 0 {
            return fitness(board: board)
        }
        
        currentBreadth -= 1
        
        v = max(v, minValuePruning(board.result(action: action), alpha: alpha, beta: beta, movement: movement - 1))
        if v >= beta {
            return v
        }
        
        alpha = max(alpha, v)
    }
    
    return v
    
}

public func minValuePruning(_ board: Board, alpha inAlpha: Int, beta inBeta: Int, movement: Int) -> Int {
    if board.terminal() {
        let result = board.utility()
        return result
    }
    
    if movement == 0 {
        return fitness(board: board)
    }
    
    var v = 99999
    let alpha = inAlpha
    var beta  = inBeta
    
    var currentBreadth = board.dimension == 3 ? GameConfig.minimaxMaxBreadthSearch3x3 : (board.dimension == 4 ? GameConfig.minimaxMaxBreadthSearch4x4 : GameConfig.minimaxMaxBreadthSearch5x5)
    for action in board.actions() {
        
        if currentBreadth == 0 {
            return fitness(board: board)
        }
        
        currentBreadth -= 1
        
        v = min(v, maxValuePruning(board.result(action: action), alpha: alpha, beta: beta, movement: movement - 1))
        if v <= alpha {
            return v
        }
        
        beta = min(beta, v)
    }

    return v
}


/// Diferença entre maxX e minY.
private func fitness(board: Board) -> Int {

    var maxX = 0
    var minY = 0

    for i in 0 ..< board.dimension {
        let colVal = board.getAllCol(x: i).reduce(0, +)
        let rowVal = board.getAllRow(y: i).reduce(0, +)
        
        if board.colContains(x: i, player: O) == false && colVal > maxX {
            maxX = colVal
        }
        
        if board.colContains(x: i, player: X) == false && colVal < minY {
            minY = colVal
        }
        
        if board.rowContains(y: i, player: O) == false && rowVal > maxX {
            maxX = rowVal
        }
        
        if board.rowContains(y: i, player: X) == false && rowVal < minY {
            minY = rowVal
        }
    }
    
    let diagVal = board.getAllDiag().reduce(0, +)
    let negDiagVal = board.getAllNegDiag().reduce(0, +)
    
    if board.diagContains(player: O) == false && diagVal > maxX {
        maxX = diagVal
    }
    
    if board.diagContains(player: X) == false && diagVal < minY {
        minY = diagVal
    }
    
    if board.negDiagContains(player: O) == false && negDiagVal > maxX {
        maxX = negDiagVal
    }
    
    if board.negDiagContains(player: X) == false && negDiagVal < minY {
        minY = negDiagVal
    }
    
    return maxX + minY
}
