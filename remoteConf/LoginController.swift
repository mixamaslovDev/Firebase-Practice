//
//  LoginController.swift
//  remoteConf
//
//  Created by Михаил Маслов on 06.06.2020.
//  Copyright © 2020 Михаил Маслов. All rights reserved.
//

import UIKit
import Firebase

class LoginController: UIViewController {
    
    var window: UIWindow?
    var singUp: Bool = false {
        willSet {
            if newValue {
                registrationLabel.text = "Вход"
                emailText.isHidden = false
                SignUpQuest.setTitle("Зарегистрироваться", for: .normal)
                usernameText.isHidden = true
            } else {
                SignUpQuest.setTitle("Нажмите, если уже зарегистрированы", for: .normal)
                registrationLabel.text = "Регистрация"
                emailText.isHidden = false
                usernameText.isHidden = false
                
            }
        }
    }
    
    @IBOutlet weak var registrationLabel: UILabel!
    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var SignUpQuest: UIButton!
    
    override func viewDidLoad() {
        usernameText.delegate = self
        emailText.delegate = self
        passwordText.delegate = self
        
    }
    
    func showAler() {
        let newAlert = UIAlertController(title: "Ошибка", message: "Заполните все поля", preferredStyle: .alert)
        newAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(newAlert, animated: true, completion: nil)
    }
    
    func showFailedAler() {
        let newAlert = UIAlertController(title: "Ошибка", message: "Неправильный логин или пароль", preferredStyle: .alert)
        newAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(newAlert, animated: true, completion: nil)
    }
    
    func toContentController() {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let neVC = storyboard.instantiateViewController(withIdentifier: "ContentContoller") as! ContentContoller
        self.present(neVC, animated: true, completion: nil)
    }
  
    @IBAction func QuestionButton(_ sender: Any) {
        singUp = !singUp
    }
}



extension LoginController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let name = usernameText.text!
        let email = emailText.text!
        let password = passwordText.text!
        if (!singUp) {
            if (!name.isEmpty && !email.isEmpty && !password.isEmpty) {
                Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                    if error == nil {
                        self.toContentController()
                    }
                }
            } else {
                showAler()
            }
            
        }
        if (singUp) {
            if (!email.isEmpty && !password.isEmpty) {
                Auth.auth().signIn(withEmail: email, password: password) { (auth, error) in
                    if error == nil {
                        self.toContentController()
                    } else {
                        self.showFailedAler()
                    }
                }
            } else {
                showAler()
            }
        }
        return true
    }
}
