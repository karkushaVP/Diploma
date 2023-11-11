//
//  ListModel.swift
//  Diploma
//
//  Created by Polya on 11.11.23.
//

import UIKit

class ListModel {
    var listName: String
    var taskName: String
    var task: String
    
    init(listName: String, taskName: String, task: String) {
        self.listName = listName
        self.taskName = taskName
        self.task = task
    }
}
