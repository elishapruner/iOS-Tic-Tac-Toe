//
//  Game.swift
//  TicTacToe
//
//  Created by Elisha Pruner on 2017-06-11.
//  Copyright © 2017 Elisha Pruner. All rights reserved.
//

import Foundation

protocol GameDelegate {
    func game(_ game: Game, boardChangedAtCol col: Int, andRow row: Int)
}

class Game {
    
    // MARK: - Static Members
    public enum Token {
        case none
        case x
        case o
    }
    
    
    // MARK: - Instance Data
    private var _board: [[Token]] = [
        [.none, .none, .none],
        [.none, .none, .none],
        [.none, .none, .none]
    ]
    
    
    // MARK: - Constructors
    init() {
    }
    
    public var delegates: [GameDelegate] = []
    
    
    // MARK: - Attributes
    public var board: [[Token]] {
        return _board
    }
    
    public var movesTaken: Int {
        var count: Int = 0
        for boardRow: [Token] in _board {
            for cell: Token in boardRow {
                if (cell != .none) {
                    count += 1
                }
            }
        }
        
        return count
    }
    
    public var currentPlayerIsX: Bool {
        return movesTaken % 2 == 0
    }
    
    public var winner: Token {
        // TODO: Win logic
        return .none
    }
    
    // MARK: - Moves
    public func takeMove(col: Int, row: Int) {
        if (_board[row][col] == .none) {
            _board[row][col] = currentPlayerIsX ? .x : .o
            
            for delegate: GameDelegate in delegates {
                delegate.game(self, boardChangedAtCol: col, andRow: row)
            }
        }
    }

    public var dictionaryRepresentation: NSDictionary {
        return [
            "Board": [
                "\(_board[0][0])", "\(_board[1][0])", "\(_board[2][0])",
                "\(_board[0][1])", "\(_board[1][1])", "\(_board[2][1])",
                "\(_board[0][2])", "\(_board[1][2])", "\(_board[2][2])",
            ]
        ]
    }
    
    public init(dictionary: NSDictionary) {
        let tokenStrings: NSArray = dictionary.object(forKey: "Board") as! NSArray
        _board[0][0] = tokenFromString(tokenString: tokenStrings.object(at: 0) as! String)
        _board[1][0] = tokenFromString(tokenString: tokenStrings.object(at: 1) as! String)
        _board[2][0] = tokenFromString(tokenString: tokenStrings.object(at: 2) as! String)
        _board[0][1] = tokenFromString(tokenString: tokenStrings.object(at: 3) as! String)
        _board[1][1] = tokenFromString(tokenString: tokenStrings.object(at: 4) as! String)
        _board[2][1] = tokenFromString(tokenString: tokenStrings.object(at: 5) as! String)
        _board[0][2] = tokenFromString(tokenString: tokenStrings.object(at: 6) as! String)
        _board[1][2] = tokenFromString(tokenString: tokenStrings.object(at: 7) as! String)
        _board[2][2] = tokenFromString(tokenString: tokenStrings.object(at: 8) as! String)
    }
    
    private func stringFromToken(token: Token) -> String {
        switch (token) {
            case .none : return "none"
            case .x : return "x"
            case .o : return "o"
        }
    }
    
    private func tokenFromString(tokenString: String) -> Token {
        switch (tokenString) {
            case "none" : return .none
            case "x" : return .x
            case "o" : return .o
            default: return .none
        }
    }
    

    
}
