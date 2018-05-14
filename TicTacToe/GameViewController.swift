//
//  GameViewController.swift
//  TicTacToe
//
//  Created by Elisha Pruner on 2017-06-13.
//  Copyright © 2017 Elisha Pruner. All rights reserved.
//

import UIKit

class GameViewController: UIViewController, GameViewDelegate, GameDelegate {
    
    // MARK: - Instance Data
    private let _game: Game
    
    
    // MARK: - Constructors
    init(game: Game) {
        _game = game
        super.init(nibName: nil, bundle: nil)
        _game.delegates.append(self)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        fatalError("init(nibName: bundle:) has not been implemented. Use init(game:) instead")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented. Use init(game:) instead")
    }
    
    
    // MARK: - UIViewController Overrides
    override func loadView() {
        view = GameView()
    }
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor.red
        gameView.delegate = self
        refresh()
    }
    
    
    // MARK: - GameViewController Methods
    var gameView: GameView {
        return view as! GameView
    }
    
    func refresh() {
        title = "\(_game.currentPlayerIsX ? "X" : "O")'s Turn"
        
        var viewTokens: [String] = []
        
        for boardRow: Int in 0 ..< _game.board.count {
            for boardCol: Int in 0 ..< _game.board[boardRow].count {
                let token: Game.Token = _game.board[boardRow][boardCol]
                
                switch token {
                case .none : viewTokens.append(" ")
                case .x : viewTokens.append("X")
                case .o : viewTokens.append("O")
                }
            }
        }
        
        gameView.tokens = viewTokens
    }
    
    
    // MARK: - GameViewDelegate Overrides
    func cellSelected(col: Int, row: Int) {
        _game.takeMove(col: col, row: row)
    }
    
    
    // MARK: - GameDelegate Override
    func game(_ game: Game, boardChangedAtCol col: Int, andRow row: Int) {
        refresh()
    }
    
    func gameBoardChanged(index: Int) {
    }
    
}
