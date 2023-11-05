//
//  Contact.swift
//  Diploma
//
//  Created by Polya on 5.11.23.
//

import Foundation

struct Contact: Editable {
    var id: String?
    let name: String
    let surname: String

    
    var asDict: [String: Any] {
        var dict = [String: Any]()
        dict["name"] = name
        dict["surname"] = surname
        return dict
    }
    
    init(
        id: String? = nil,
        name: String,
        surname: String
    ) {
        self.id = id
        self.name = name
        self.surname = surname
    }
    
    init(key: String, dict: [String: Any]) throws {
        guard let name = dict["name"] as? String,
              let surname = dict["surname"] as? String
        else {
            let error = "Parsing contact error"
            print("[Contact parser] \(error)")
            throw error
        }
        
            self.id = key
            self.name = name
            self.surname = surname
    }
}

extension String: Error {}

protocol Editable {
    var id: String? { get }
}
