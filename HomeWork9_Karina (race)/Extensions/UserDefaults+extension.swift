//
//  UserDefaults+extension.swift
//  HomeWork9_Karina (race)
//
//  Created by Karina Kovaleva on 4.10.22.
//

import Foundation

extension UserDefaults {
    
    func set<T: Encodable>(encodable: T, forKey key: String) {
        if let data = try? JSONEncoder().encode(encodable) {
            set(data, forKey: key)
        }
    }
    
    func value<T: Decodable>(_ type: T.Type, forKey key: String) -> T? {
        if let data = object(forKey: key) as? Data, let value = try? JSONDecoder().decode(type, from: data) {
            return value
        }
        return nil
    }
}
