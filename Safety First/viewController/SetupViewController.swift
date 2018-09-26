//
//  SetupViewController.swift
//  Safety First
//
//  Created by Christophe on 26/09/2018.
//  Copyright © 2018 Christophe. All rights reserved.
//

import UIKit

class SetupViewController: UIViewController {

    @IBOutlet weak var ui_passwordConfirmationField: UITextField!
    @IBOutlet weak var ui_passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func getTypedPassword() -> String? {
        let password: String?
        
        if let password1 = ui_passwordField.text,
            let passwordConfirmation = ui_passwordConfirmationField.text,
            password1.count > 0,
            password1 == passwordConfirmation {
            password = password1
        } else {
            password = nil
        }
        
        return password
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        return getTypedPassword() != nil
    }
    


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let password = getTypedPassword() {
            VaultManager().saveMasterPassword(password)
        }
    }
}
