//
//  SecurityManager.swift
//  Safety First
//
//  Created by Christophe on 24/08/2018.
//  Copyright © 2018 Christophe. All rights reserved.
//

import Foundation
import Alamofire

class SecurityManager {
    struct SecurityAnsswer {
        let result: Bool
        let message:String?
    }
    
    private static let TOP_100_PASSWORD = "https://raw.githubusercontent.com/danielmiessler/SecLists/master/Passwords/darkweb2017-top100.txt"
    private var _forbiddenList:[String]? = nil
    private static var s_securityManager:SecurityManager? = nil
    
    public static var shared:SecurityManager {
        if s_securityManager == nil {
            s_securityManager = SecurityManager()
        }
        
        return s_securityManager!
    }
    
    private init(){}
    
    func downladPasswordFile(){
        Alamofire.request(SecurityManager.TOP_100_PASSWORD).responseString { (response) in
            if let passwordList = response.result.value{
                self._forbiddenList = passwordList.components(separatedBy: "\n")
            }
        }
    }
    
    func isPasswordSafe(password:String) -> SecurityAnsswer{
        let answer: SecurityAnsswer
        if let forbiddenPasswordList = _forbiddenList {
            if forbiddenPasswordList.contains(password) {
                answer = SecurityAnsswer(result: false, message: "Le mot de passe fait parti des  100 plus utilisés")
            } else {
                answer = SecurityAnsswer(result: true, message: nil)
            }
        } else {
            answer = SecurityAnsswer(result: false, message: "Le gestionnaire de sécurité n'est pas prêt")
        }
        
        return answer
    }
}
