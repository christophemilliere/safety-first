//
//  CredentialsManager.swift
//  Safety First
//
//  Created by Christophe on 23/08/2018.
//  Copyright © 2018 Christophe. All rights reserved.
//

import Foundation
import RealmSwift

class CredentialsManager {
    
    private let _realm:Realm
    private let _credentialList:Results<Credentials>
    
    init() {
        _realm = try! Realm()
        _credentialList = _realm.objects(Credentials.self)
    }
    
    func addCredentials(title:String, login:String, password:String, url:String) -> Credentials {
        let newCredentials = Credentials()
        newCredentials.title = title
        newCredentials.login = login
        newCredentials.password = password
        newCredentials.url = url
        
        try? _realm.write {
            _realm.add(newCredentials)
        }
        
        return newCredentials
    }
    
    func getCrendentialCount() -> Int {
        return _credentialList.count
    }
    
    func getCrendential(atIndex index:Int) -> Credentials? {
        guard index >= 0 && index < getCrendentialCount() else {
            return nil
        }
        return _credentialList[index]
    }
    
    func deleteCrendential(atIndex index:Int) {
        if let credToDelete = getCrendential(atIndex: index) {
            try? _realm.write {
                _realm.delete(credToDelete)
            }
        }
    }
}
