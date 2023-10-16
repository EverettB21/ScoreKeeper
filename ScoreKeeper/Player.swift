//
//  Player.swift
//  ScoreKeeper
//
//  Created by Everett Brothers on 10/16/23.
//

import Foundation

struct Player: Codable {
    var name: String
    var score: Int
    
    static var documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static var archiveURL = documentDirectory.appendingPathComponent("players").appendingPathExtension("plist")
    static var initialPlayer = Player(name: "Player1", score: 0)
    
    static func save(players: [Player]) {
        let propertyEncoder = PropertyListEncoder()
        
        if let encoded = try? propertyEncoder.encode(players) {
            try? encoded.write(to: archiveURL, options: .noFileProtection)
        }
    }
    
    static func load() -> [Player] {
        let propertyDecoder = PropertyListDecoder()
        
        if let data = try? Data(contentsOf: archiveURL) {
            let decoded = try? propertyDecoder.decode([Player].self, from: data)
            return decoded ?? [initialPlayer]
        }
        
        return [initialPlayer]
    }
}
