//
//  ViewController.swift
//  Login_Exercise_MAD
//
//  Created by Dominik Polzer on 22.09.20.
//  Copyright © 2020 Dominik Polzer. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var loadingSymbol: UIActivityIndicatorView!
    
    
    @IBOutlet weak var errorTextField: UITextField!
    
    let hardCodedPassword: String = "test1"
    let hardCodedEmail: String = "test@gmx.at"
    
    
    var validEmail: String = ""
    var validPassword: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        loadingSymbol.isHidden = true
        errorTextField.isHidden = true
        
    }
    
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        emailTextField.isEnabled = false
        passwordTextField.isEnabled = false
        loadingScreen()
        
    }
    
    
    func save() -> Bool{
        
        
        
        guard let email = emailTextField.text, emailTextField.text?.count != 0 else{
            errorTextField.isHidden = false
            errorTextField.text = "Please enter an email"
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2){
                self.emailTextField.isEnabled = true
                self.passwordTextField.isEnabled = true
            }
            return false
        }
        
        validEmail = email
        
        
        guard let password = passwordTextField.text, self.passwordTextField.text?.count != 0 else{
            errorTextField.isHidden = false
            errorTextField.text = "Please enter a password"
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2){
                self.emailTextField.isEnabled = true
                self.passwordTextField.isEnabled = true
            }
            return false
        }
        
        validPassword  = password
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
            
            // This Code executes after 2 seconds
            // Check here if the Login was successful
            
            if self.validEmail == self.hardCodedEmail && self.validPassword == self.hardCodedPassword{
                let alert = UIAlertController(title: "Login", message: "Success", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { (action) in
                }))
                self.present(alert, animated: true)
                self.emailTextField.text = ""
                self.passwordTextField.text = ""
                
                self.emailTextField.isEnabled = true
                self.passwordTextField.isEnabled = true
                
                
            }else{
                let alert = UIAlertController(title: "Login", message: "Login Failed", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
                    
                }))
                self.present(alert, animated: true)
                self.emailTextField.text = ""
                self.passwordTextField.text = ""
                
                self.emailTextField.isEnabled = true
                self.passwordTextField.isEnabled = true
            }
        }
        return true
    }
        
    func loadingScreen(){
        let loadingStatus = save()
        if loadingStatus == true{
            loadingSymbol.isHidden = false
            loadingSymbol.startAnimating()
            view?.backgroundColor = UIColor(white: 1, alpha: 0.92)
            emailTextField.backgroundColor = UIColor(white: 0.92, alpha: 1)
            passwordTextField.backgroundColor = UIColor(white: 0.92, alpha: 1)
            DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                self.view?.backgroundColor = UIColor(white: 1, alpha: 1)
                self.emailTextField.backgroundColor = UIColor(white: 1, alpha: 1)
                self.passwordTextField.backgroundColor = UIColor(white: 1, alpha: 1)
                self.loadingSymbol.isHidden = true
                self.loadingSymbol.stopAnimating()
                self.errorTextField.isHidden = true
            }
        }
    }
}

extension ViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField{
            passwordTextField.becomeFirstResponder()
        }else if textField == passwordTextField{
            self.emailTextField.isEnabled = false
            self.passwordTextField.isEnabled = false
            loadingScreen()
        }
        return false
    }
}


