//
//  DetailViewController.swift
//  ScoreKeeper
//
//  Created by Everett Brothers on 10/16/23.
//

import UIKit

protocol DetailViewControllerDelegate {
    func recieve(_:DetailViewController,score:Int,index:IndexPath)
}

class DetailViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    
    var delegate: DetailViewControllerDelegate?
    var player: Player?
    var indexPath: IndexPath?
    var score = 0 {
        didSet {
            label.text = "Score: \(score)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = player?.name
        if let playerScore = player?.score {
            score = playerScore
        }
        navigationItem.hidesBackButton = true
    }
    
    @IBAction func minusScore(_ sender: Any) {
        score -= 1
        if score < 0 {
            score = 0
        }
        delegate?.recieve(self, score: score, index: indexPath!)
    }
    
    @IBAction func addScore(_ sender: Any) {
        score += 1
        delegate?.recieve(self, score: score, index: indexPath!)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
