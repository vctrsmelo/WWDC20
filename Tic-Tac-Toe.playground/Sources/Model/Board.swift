public typealias Player = Int

public let E = 0
public let X = 1
public let O = -1

public struct Board {
    
    private var data: Array<Int>
    public var matrix: [[Player]] {
        
        var v: [[Player]] = [[Player]](repeating: [Player](repeating: 0, count: dimension), count: dimension)
        
        for i in 0 ..< dimension {
            for j in 0 ..< dimension {
                v[i][j] = self.getValueAt(i, j)
            }
        }
        
        return v
    }
    
    public var dimension: Int {
        didSet {
            data = [Int].init(repeating: 0, count: dimension*dimension)
            isBoardEmpty = true
        }
    }
    
    private var isXPlaying = true
    private(set) var isBoardEmpty = true
    
    public init(dimension: Int) {
        self.dimension = dimension
        data = [Int].init(repeating: 0, count: dimension*dimension)
    }
    
    public mutating func play(_ player: Player, x: Int, y: Int) {
        data[index(x, y)] = player
        isXPlaying.toggle()
        if isBoardEmpty {
            isBoardEmpty = false
        }
    }
    
    public mutating func switchPlayer() {
        isXPlaying.toggle()
    }
    
    public func currentPlayer() -> Player {
        return isXPlaying ? X : O
    }
    
    public func lastPlayer() -> Player {
        return isXPlaying ? O : X
    }
    
    public func isEmpty(x: Int, y: Int) -> Bool {
        return data[index(x, y)] == E
    }
    
    public func actions() -> [(x: Int, y: Int)] {

        var actions: [(x: Int, y: Int)] = []
      
        for x in 0 ..< dimension {
            for y in 0 ..< dimension {
                let point = (x: x, y: y)
                if isEmpty(x: point.x, y: point.y) {
                    actions.append(point)
                }
            }
        }

        return actions
    }
    
    public func getAllCol(x: Int) -> [Player] {
        (0 ..< dimension).map { data[index(x, $0)] }
    }
    
    public func getAllRow(y: Int) -> [Player] {
        (0 ..< dimension).map { data[index($0, y)] }
    }
    
    
    public func colContains(x: Int, player: Player) -> Bool {
        for y in 0 ..< dimension {
            if getValueAt(x, y) == player {
                return true
            }
        }
        
        return false
    }
    
    public func rowContains(y: Int, player: Player) -> Bool {
        for x in 0 ..< dimension {
            if getValueAt(x, y) == player {
                return true
            }
        }
        
        return false
    }
    
    public func getAllDiag() -> [Player] {
       var allDiag: [Player] = []
       
       for x in (0..<dimension) {
           allDiag.append(data[index(x, x)])
       }
        
        return allDiag
    }
    
    public func getAllNegDiag() -> [Player] {
        var allDiag: [Player] = []
        
        for x in (0..<dimension) {
            allDiag.append(data[index(x, dimension-1-x)])
        }
        
        return allDiag
    }
    
    public func diagContains(player: Player) -> Bool {
       var allDiag: [Player] = []
       
       for x in (0..<dimension) {
           allDiag.append(data[index(x, x)])
       }
        
        return allDiag.contains(player)
    }
    
    public func negDiagContains(player: Player) -> Bool {
        var allDiag: [Player] = []
        
        for x in (0..<dimension) {
            allDiag.append(data[index(x, dimension-1-x)])
        }
        
        return allDiag.contains(player)
    }
    
    public func winner() -> Player {

        var returnedWinner = E
        
        let winnerX = X * dimension
        let winnerO = O * dimension

        let diagonalSum = getAllDiag().reduce(0, +)
        
        if diagonalSum == winnerX { return X }
        if diagonalSum == winnerO { return O }

        let negDiagonalSum = getAllNegDiag().reduce(0, +)
        if negDiagonalSum == winnerX { return X }
        if negDiagonalSum == winnerO { return O }
    
        for i in 0 ..< dimension {
        
            let lineSum = getAllRow(y: i).reduce(0, +)
            let colSum = getAllCol(x: i).reduce(0, +)
            
            if lineSum == winnerX || colSum == winnerX { returnedWinner =  X }
            if lineSum == winnerO || colSum == winnerO { returnedWinner =  O }
            
        }
        
        return returnedWinner
    }
    
    public func result(action: (x: Int, y: Int)) -> Board {
        var newBoard = self
        newBoard.play(currentPlayer(), x: action.x, y: action.y)
        
        return newBoard
    }
    
    public func utility() -> Int {
        return winner()
    }
    
    public func terminal() -> Bool {
        data.contains(where: { $0 == E }) == false || self.winner() != E
        
    }
    
    private func getValueAt(_ x: Int, _ y: Int) -> Int {
        return data[index(x,y)]
    }
    
    private func index(_ x: Int, _ y: Int) -> Int {
        x*dimension + y
    }
    
    private func index(_ p: (x: Int, y: Int)) -> Int {
        index(p.x, p.y)
    }
}

extension Board: CustomStringConvertible {
    public var description: String {
        var str = "|"
        for y in 0 ..< dimension {
            for x in 0 ..< dimension {
                str += " \(data[x*dimension+y]) "
            }
            str += "|\n|"
        }
        
        return String(str.dropLast().dropLast())
    }
}
