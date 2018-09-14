//
//  VaultManager.swift
//  Safety First
//
//  Created by Christophe on 14/09/2018.
//  Copyright © 2018 Christophe. All rights reserved.
//

import Foundation
import RealmSwift

class VaultManager {
    private var _vault:Vault?
    
    func getMainVault()->Vault? {
        let realm = try! Realm()
        return Vault(withRealm: realm)
    }
}
