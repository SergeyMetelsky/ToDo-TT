//
//  LoginViewController.swift
//  ToDo TT
//
//  Created by Sergey on 8/11/21.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Login"


    }
    
    @IBAction func registerButtonPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
    }
}
