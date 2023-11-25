//
//  RealmManager.swift
//  Diploma
//
//  Created by Polya on 25.09.23.
//

import Foundation
import RealmSwift

final class RealmManager<T: Object> {
    
    private let realm: Realm? = {
        var configuration = Realm.Configuration.defaultConfiguration
        configuration.schemaVersion = 1
        return try? Realm(configuration: configuration)
    }()
    
    func read() -> [T] {
        guard let realm else { return []}
        return Array(realm.objects(T.self))
    }
    
    func write(_ object: T) {
        try? realm?.write({
            realm?.add(object)
        })
    }
    
    func update(realmBlock: ((Realm) -> Void)?) {
        guard let realm else { return }
        realmBlock?(realm)
    }
    
    func delete(object: T) {
        try? realm?.write({
            realm?.delete(object)
        })
    }
    
    func deleteAll(object: T.Type) {
        try? realm?.write {
            if let allData = realm?.objects(T.self) {
                realm?.delete(allData)
            }
        }
    }
    
}
