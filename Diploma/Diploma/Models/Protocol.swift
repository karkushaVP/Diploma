//
//  Protocol.swift
//  Diploma
//
//  Created by Polya on 25.11.23.
//

import Foundation

protocol TaskAddedDelegate: AnyObject {
    func taskAdded(_ task: TaskEntityModel)
}
