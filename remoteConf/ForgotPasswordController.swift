//
//  ForgotPasswordController.swift
//  remoteConf
//
//  Created by Михаил Маслов on 08.06.2020.
//  Copyright © 2020 Михаил Маслов. All rights reserved.
//

import UIKit
import FirebaseAuth

class ForgotPasswordController: UIViewController {
    
    
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var registrationLabel: UILabel!
    
    @IBOutlet weak var forgotPassword: UIButton!
    
    @IBAction func backButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func forgotPasswordAction(_ sender: UIButton) {
        let email = emailText.text!
        if (!email.isEmpty) {
            Auth.auth().sendPasswordReset(withEmail: email) { (error) in
                if error == nil {
                    self.dismiss(animated: true, completion: nil)
                } else {
                    print(error as Any)
                }
            }
        } else {
            showFailedAler()
        }
    }
    
    func showFailedAler() {
        let newAlert = UIAlertController(title: "Ошибка", message: "Введите адрес email", preferredStyle: .alert)
        newAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(newAlert, animated: true, completion: nil)
    }
}
