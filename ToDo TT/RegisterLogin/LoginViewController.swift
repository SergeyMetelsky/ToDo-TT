//
//  LoginViewController.swift
//  ToDo TT
//
//  Created by Sergey on 8/11/21.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController {
    
    //    MARK:- IBOutlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    //    MARK:- ControllerLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Login"
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(firstRecognizerClicked(_:)))
        view.addGestureRecognizer(tapRecognizer)
    }
    
    //    MARK:- IBActions
    @IBAction func registerButtonPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] (user, error) in
                guard let self = self else { return }
                if user != nil {
//                    print("i am inside")
                    let storyboard = UIStoryboard(name: "Tasks", bundle: nil)
                    let destinationVC = storyboard.instantiateViewController(identifier: "TasksListViewController")
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
    
    //    MARK:- Functions
    @objc func firstRecognizerClicked(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
}
