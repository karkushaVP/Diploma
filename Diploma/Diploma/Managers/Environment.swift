//
//  Environment.swift
//  Diploma
//
//  Created by Polya on 5.11.23.
//

import Foundation
import FirebaseDatabase
import FirebaseStorage

struct Environment {
    static let ref = Database.database(url: "https://diploma-fd26d-default-rtdb.europe-west1.firebasedatabase.app").reference()
    static let storage = Storage.storage(url: "gs://diploma-fd26d.appspot.com").reference()
}
