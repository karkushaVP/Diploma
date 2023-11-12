//
//  Task.swift
//  Diploma
//
//  Created by Polya on 5.11.23.
//

import Foundation

struct Task {
    var id: String?
    let name: String
    let task: String
    
    var asDict: [String: Any] {
        var dict = [String: Any]()
        dict["name"] = name
        dict["task"] = task
        return dict
    }
    
    init(
        id: String? = nil,
        name: String,
        task: String
    ) {
        self.id = id
        self.name = name
        self.task = task
    }
    
    init(key: String, dict: [String: Any]) throws {
        guard let name = dict["name"] as? String,
              let task = dict["task"] as? String
        else {
            let error = "Parsing contact error"
            print("[Contact parser] \(error)")
            throw error
        }
            self.id = key
            self.name = name
            self.task = task
    }
}
//extension String: Error {}
//
//protocol Editabl {
//    var id: String? { get }
//}
