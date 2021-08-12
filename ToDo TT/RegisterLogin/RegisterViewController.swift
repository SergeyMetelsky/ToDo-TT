//
//  ViewController.swift
//  ToDo TT
//
//  Created by Sergey on 8/10/21.
//

import UIKit
import Firebase
import FirebaseAuth

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Register"
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(firstRecognizerClicked(_:)))
        view.addGestureRecognizer(tapRecognizer)
    }
    
    @IBAction func tapClicked(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        guard let destinationVC = storyboard?.instantiateViewController(identifier: "LoginViewController") else { return }
        navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    @IBAction func registerButtonPressed(_ sender: UIButton) {
        if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().createUser(withEmail: email, password: password) { [weak self] (user, error) in
                guard let self = self else { return }
                if user != nil {
                    guard let destinationVC = self.storyboard?.instantiateViewController(identifier: "LoginViewController") else { return }
                    self.navigationController?.pushViewController(destinationVC, animated: true)
                } else {
                    let errorMessage = error?.localizedDescription ?? "Error"
                    let alertVC = UIAlertController(title: nil, message: errorMessage, preferredStyle: .alert)
                    let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                    alertVC.addAction(action)
                    self.present(alertVC, animated: true, completion: nil)
                }
            }
        }
    }
    
    @objc func firstRecognizerClicked(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
}

