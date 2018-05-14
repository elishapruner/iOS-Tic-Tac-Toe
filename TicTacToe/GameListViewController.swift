//
//  GameListViewController.swift
//  TicTacToe
//
//  Created by Elisha Pruner on 2017-06-15.
//  Copyright © 2017 Elisha Pruner. All rights reserved.
//

import UIKit

class GameListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, GameLibraryDelegate {

    // MARK: - UIViewController Overrides
    override func loadView() {
        view = UITableView()
    }
    
    override func viewDidLoad() {
        title = "Tic-Tac-Toe"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPressed))
        GameLibrary.Instance.delegate = self
        gameListTableView.dataSource = self
        gameListTableView.delegate = self
    }
    
    
    // MARK: - GameListViewController Elements
    var gameListTableView: UITableView {
        return view as! UITableView
    }
    
    func addPressed() {
        GameLibrary.Instance.createNewGame()
    }
    
    
    // MARK: - UITableViewDataSource Overrides
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return GameLibrary.Instance.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let gameIndex: Int = indexPath.row
        let game: Game = GameLibrary.Instance.game(index: gameIndex)
        
        let cell: UITableViewCell = UITableViewCell(style: .value1, reuseIdentifier: nil)
        cell.textLabel?.text = "\(game.currentPlayerIsX ? "X" : "O")'s Turn"
        cell.detailTextLabel?.text = "\(game.movesTaken) moves"
        
        return cell
    }
    
    
    // MARK: - UITableViewDelegate Methods
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let gameIndex: Int = indexPath.row
        let game: Game = GameLibrary.Instance.game(index: gameIndex)
        
        let gameViewController: GameViewController = GameViewController(game: game)
        navigationController?.pushViewController(gameViewController, animated: true)
    }
    
    
    // MARK: - GameLibraryDelegate Methods
    func gameCreated(index: Int) {
        GameLibrary.Instance.save()
        gameListTableView.reloadData()
    }
    
    func gameBoardChanged(index: Int) {
        GameLibrary.Instance.save()
        let indexPath: IndexPath = IndexPath(row: index, section: 0)
        gameListTableView.reloadRows(at: [indexPath], with: .none)
    }
}
