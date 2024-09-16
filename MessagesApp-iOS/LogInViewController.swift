//
//  ViewController.swift
//  MessagesApp-iOS
//
//  Created by Mañanas on 16/9/24.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class LogInViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func signUp(_ sender: Any) {
        var email = email.text!
        var password = password.text!
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                            print("Error al crear usuario")
                            print(error.localizedDescription)
                            return
                        } else {
                            print("Registro correcto")
                        }
        }
    }
    
    @IBAction func signIn(_ sender: Any) {
        var email = email.text!
        var password = password.text!
        
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                            print("Error al iniciar sesión")
                            print(error.localizedDescription)
                            return
                        } else {
                            print("Login correcto")
                        }
        }
    }
    

}

