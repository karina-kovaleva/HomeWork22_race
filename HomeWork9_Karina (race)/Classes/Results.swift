//
//  Results.swift
//  HomeWork9_Karina (race)
//
//  Created by Karina Kovaleva on 4.10.22.
//

import Foundation

class Results: Codable {
    var name: String
    var score: String
    
    init(name: String, score: String) {
        self.name = name
        self.score = score
    }
    
    private enum CodingKeys: CodingKey {
        case name, score
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.score = try container.decode(String.self, forKey: .score)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.score, forKey: .score)
    }
}
