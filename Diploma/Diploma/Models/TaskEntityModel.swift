//
//  ElementModel.swift
//  Diploma
//
//  Created by Polya on 16.11.23.
//

import Foundation
import RealmSwift

class TaskEntityModel: Object {
    @Persisted var notificationName: String
    @Persisted var notificationText: String
    @Persisted var date: Date
    
    convenience init(
        notificationName: String,
        notificationText: String,
        date: Date
    ) {
        self.init()
        self.notificationName = notificationName
        self.notificationText = notificationText
        self.date = date
    }
}
