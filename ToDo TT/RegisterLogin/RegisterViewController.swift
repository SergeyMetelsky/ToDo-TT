//
//  ViewController.swift
//  ToDo TT
//
//  Created by Sergey on 8/10/21.
//

import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Register"
        
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        guard let destinationVC = storyboard?.instantiateViewController(identifier: "LoginViewController") else { return }
        navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    @IBAction func registerButtonPressed(_ sender: UIButton) {
        guard let destinationVC = storyboard?.instantiateViewController(identifier: "LoginViewController") else { return }
        navigationController?.pushViewController(destinationVC, animated: true)
    }
}

