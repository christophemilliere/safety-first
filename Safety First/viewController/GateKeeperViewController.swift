//
//  GateKeeperViewController.swift
//  Safety First
//
//  Created by Christophe on 19/09/2018.
//  Copyright © 2018 Christophe. All rights reserved.
//

import UIKit
import LocalAuthentication

class GateKeeperViewController: UIViewController {

    @IBOutlet weak var ui_biometrics_button: UIButton!
    @IBOutlet weak var ui_passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let vaultManager = VaultManager()
        if vaultManager.hasMasterPassword() == false {
            performSegue(withIdentifier: "setup-new-vault", sender: nil)
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ui_biometrics_button.isHidden = LAContext().canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) == false
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        ui_passwordField.text = nil
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func unlockWithBiometrics() {
        let context = LAContext()
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) {
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Déverrouiller votre coffre fort", reply: { (isOwner, _) in
                DispatchQueue.main.async {
                    if isOwner == true {
                        self.displayVaultVIewController()
                    }
                }
            })
        }
    }
    
    @IBAction func savedInitialSetup(_ segue: UIStoryboardSegue){
        
    }
    
    @IBAction func unlockWithPassword() {
        // verifier mot de passe
        let vaultManager = VaultManager()
        if let typePassword = ui_passwordField.text,
            let vaultPassword = vaultManager.getMasterPassword(),
        typePassword == vaultPassword
        {
         displayVaultVIewController()
        }
    }
    
    func displayVaultVIewController() {
        if let vaultDc = storyboard?.instantiateViewController(withIdentifier: "VaultViewController") as? VaultViewController {
            
            show(vaultDc, sender: nil)
        }
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
