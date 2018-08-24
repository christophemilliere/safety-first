//
//  ViewController.swift
//  Safety First
//
//  Created by Christophe on 23/08/2018.
//  Copyright © 2018 Christophe. All rights reserved.
//

import UIKit
import RealmSwift

class CredentialViewController: UIViewController {
    
    private var _credential:Credentials?
    func setCredentials(_ credentials: Credentials) {
        _credential = credentials
    }
    
    @IBOutlet weak var ui_loginLabel: UILabel!
    @IBOutlet weak var ui_passwordLabel: UILabel!
    @IBOutlet weak var ui_urlLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        displayBasicData()
        
    }
    
    private func displayBasicData() {
        if let cred = _credential {
            self.title = cred.title
            ui_loginLabel.text = "Identifiant : \(cred.login)"
            ui_urlLabel.text = "Site web : \(cred.url)"
        }
    }
    
    @IBAction func displayPassword(_ sender: Any) {
        if let cred = _credential {
            ui_passwordLabel.text = "Mot de passe : \(cred.password)"
        }
    }
    

    @IBAction func copyPasswordToClipboard(_ sender: Any) {
        if let cred = _credential {
            UIPasteboard.general.string = cred.password
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    


}

