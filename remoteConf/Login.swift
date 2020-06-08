//
//  Login.swift
//  remoteConf
//
//  Created by Михаил Маслов on 06.06.2020.
//  Copyright © 2020 Михаил Маслов. All rights reserved.
//

import UIKit
import Firebase

class LoginController: UIViewController {
    
    var singUp: Bool = true {
        willSet {
            if newValue {
                loginButton.setTitle("Зарегистрироваться", for: .normal)
                registrationLabel.text = "Вход"
                emailText.isHidden = false
                SignUpQuest.isHidden = true
                usernameText.isHidden = true
                
            } else {
                loginButton.setTitle("Войти", for: .normal)
                registrationLabel.text = "Регистрация"
                emailText.isHidden = false
                SignUpQuest.isHidden = false
            }
        }
    }
    
    @IBOutlet weak var registrationLabel: UILabel!
    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var SignUpQuest: UIButton!
    
    override func viewDidLoad() {
        usernameText.delegate = self
        emailText.delegate = self
        passwordText.delegate = self
        loginButton.isHidden = true
        
    }
    
    func showAler() {
        let newAlert = UIAlertController(title: "Ошибка", message: "Заполните все поля", preferredStyle: .alert)
        newAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(newAlert, animated: true, completion: nil)
    }
    
    @IBAction func switchForm(_ sender: UIButton) {
        singUp = !singUp
    }
    
    @IBAction func QuestionButton(_ sender: Any) {
        if (loginButton.isHidden) {
            loginButton.isHidden = false
        } else {
            loginButton.isHidden = true
        }
    }
}



extension LoginController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let name = usernameText.text!
        let email = emailText.text!
        let password = passwordText.text!
        if (singUp) {
            if (!name.isEmpty && !email.isEmpty && !password.isEmpty) {
                Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                    if error == nil {
                        if result == result {
                            print(result?.user.uid as Any)
                        }
                    }
                }
            } else {
                showAler()
            }
            if (!name.isEmpty && !password.isEmpty) {
                Auth.auth().isSignIn(withEmailLink: email)
                print(email)
            } else {
                showAler()
            }
        }
        return true
    }
}
