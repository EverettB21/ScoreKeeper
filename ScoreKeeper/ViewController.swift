//
//  ViewController.swift
//  ScoreKeeper
//
//  Created by Everett Brothers on 10/16/23.
//

import UIKit

class ViewController: UITableViewController, DetailViewControllerDelegate {

    var players: [Player] = []
    var selectedPlayer: Player?
    var selectedIndex: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        players = Player.load()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPlayer))
    }
    
    @IBSegueAction func segueToDetail(_ coder: NSCoder) -> DetailViewController? {
        let vc = DetailViewController(coder: coder)
        vc?.delegate = self
        vc?.player = selectedPlayer
        vc?.indexPath = selectedIndex
        return vc
    }
    
    @IBAction func unwindToTable(segue: UIStoryboardSegue) {
        
    }
    
    func recieve(_: DetailViewController, score: Int, index: IndexPath) {
        players[index.row].score = score
        save()
        tableView.reloadData()
    }
    
    @objc func addPlayer() {
        let ac = UIAlertController(title: "Add Player", message: nil, preferredStyle: .alert)
        
        ac.addTextField { text in
            text.placeholder = "Name:"
        }
        
        ac.addAction(UIAlertAction(title: "Done", style: .default) { [weak self, weak ac] _ in
            guard let text = ac?.textFields?[0].text else { return }
            self?.players.insert(Player(name: text, score: 0), at: 0)
            self?.save()
            self?.tableView.reloadData()
        })
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(ac, animated: true)
    }
    
    func save() {
        Player.save(players: players)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedPlayer = players[indexPath.row]
        selectedIndex = indexPath
        performSegue(withIdentifier: "toDetail", sender: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            players.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            save()
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let player = players[indexPath.row]
        
        var content = cell.defaultContentConfiguration()
        content.text = "\(player.name): \(player.score)"
        cell.contentConfiguration = content
        
        return cell
    }
}

