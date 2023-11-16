//
//  ElementModel.swift
//  Diploma
//
//  Created by Polya on 16.11.23.
//

import Foundation
import RealmSwift

class Element: Object {
    @Persisted var notificationName: String
    @Persisted var notificationText: String
    
    convenience init(
        notificationName: String,
        notificationText: String
    ) {
        self.init()
        self.notificationName = notificationName
        self.notificationText = notificationText
    }
}
