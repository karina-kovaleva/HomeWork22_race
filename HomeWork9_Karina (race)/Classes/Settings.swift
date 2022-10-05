//
//  Settings.swift
//  HomeWork9_Karina (race)
//
//  Created by Karina Kovaleva on 4.10.22.
//

import Foundation

class Settings: Codable {
    var name: String
    var car: String
    var obstacles: [String]
    
    init(name: String, car: String, obstacles: [String]) {
        self.name = name
        self.car = car
        self.obstacles = obstacles
    }
    
    private enum CodingKeys: CodingKey {
        case name, car, obstacles
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.car = try container.decode(String.self, forKey: .car)
        self.obstacles = try container.decode([String].self, forKey: .obstacles)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.name, forKey: .name)
        try container.encode(self.car, forKey: .car)
        try container.encode(self.obstacles, forKey: .obstacles)
    }
}
