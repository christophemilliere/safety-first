//
//  VaultManager.swift
//  Safety First
//
//  Created by Christophe on 14/09/2018.
//  Copyright © 2018 Christophe. All rights reserved.
//

import Foundation
import RealmSwift
import KeychainAccess

class VaultManager {
    private static let REALM_ENCRYPTION_KEY = "REALM_ENCRYPTION_KEY"
    private static let MASTER_PASSWORD = "SAFETY_FIRST_MASTER_PASSWORD"
    private var _vault:Vault?
    private var _keyChain:Keychain
    
    init() {
        _keyChain = Keychain(service: Bundle.main.bundleIdentifier ?? "rrr.Safety-First")
    }
    
    func getMainVault()->Vault? {
        var possibleKkey:Data?
        
        //charger la clee
        possibleKkey = loadRealmEncryptionKey()
        
        // si pas de clée génerer une nouvelle clée
        if possibleKkey == nil {
            possibleKkey = generateRealmEncryptionKey()
        }
        
        
        
        
        //config realm avec une clée
        if let realmEncryption = possibleKkey {
            let realConfig = Realm.Configuration(encryptionKey: realmEncryption)
            let realm = try! Realm(configuration: realConfig)
            _vault = Vault(withRealm: realm)
        }
        
        return _vault
    }
    
    private func loadRealmEncryptionKey() -> Data? {
        return _keyChain[data: VaultManager.REALM_ENCRYPTION_KEY]
    }
    
    private func generateRealmEncryptionKey() -> Data? {
        guard let generatedData = Data(countOfRandomData: 64) else { return nil }
        try! _keyChain.set(generatedData, key: VaultManager.REALM_ENCRYPTION_KEY)
        return generatedData
    }
    
    func saveMasterPassword(_ password:String) {
        _keyChain[VaultManager.MASTER_PASSWORD] = password
    }
    
    func getMasterPassword() -> String? {
        return _keyChain[VaultManager.MASTER_PASSWORD]
    }
    
    func hasMasterPassword() -> Bool {
        return getMasterPassword() != nil
    }
}
