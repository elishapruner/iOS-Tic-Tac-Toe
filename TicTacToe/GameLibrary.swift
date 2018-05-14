//
//  GameLibrary.swift
//  TicTacToe
//
//  Created by Elisha Pruner on 2017-06-13.
//  Copyright © 2017 Elisha Pruner. All rights reserved.
//

import Foundation

protocol GameLibraryDelegate {
    func gameCreated(index: Int)
    func gameBoardChanged(index: Int)
}

class GameLibrary: GameDelegate {
    
    public static let Instance: GameLibrary = GameLibrary()
    
    private init() {}

    private var _games: [Game] = []
    
    public var delegate: GameLibraryDelegate? = nil
    

    public var count: Int {
        return _games.count
    }
    
    public func createNewGame() {
        let game: Game = Game()
        game.delegates.append(self)
        _games.append(game)
        delegate?.gameCreated(index: _games.count - 1)
    }
    
    public func deleteGame(index: Int) {
        _games.remove(at: index)
    }
    
    public func game(index: Int) -> Game {
        return _games[index]
    }
    
    
    public func load() {
        // Load from JSON file
        _games.removeAll()
        
        let jsonData: Data = try! Data(contentsOf: URL.init(fileURLWithPath: "Library.json"))
        
        let gameDictionaries: [NSDictionary] = try! JSONSerialization.jsonObject(with: jsonData, options: []) as! [NSDictionary]
        
        for gameDictionary: NSDictionary in gameDictionaries {
            let game: Game = Game(dictionary: gameDictionary)
            game.delegates.append(self)
            _games.append(game)
        }
    }
    
    public func save() {
        // Save to JSON file
        var gameDictionaries: [NSDictionary] = []
        for game: Game in _games {
            gameDictionaries.append(game.dictionaryRepresentation)
        }
        
        let jsonData = try! JSONSerialization.data(withJSONObject: gameDictionaries, options: .prettyPrinted)
        try! jsonData.write(to: URL.init(fileURLWithPath: "Library.json"))
    }
    
    
    // MARK: - GameDelegate Methods
    func game(_ game: Game, boardChangedAtCol col: Int, andRow row: Int) {
        let gameIndex: Int? = _games.index(where: { searchGame in searchGame === game })
        if gameIndex != nil {
            delegate?.gameBoardChanged(index: gameIndex!)
        }
    }
    
}
