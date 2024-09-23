//
//  SingUpViewController.swift
//  MessagesApp-iOS
//
//  Created by Mañanas on 17/9/24.
//

import UIKit
import FirebaseAuth
import Firebase

class SingUpViewController: UIViewController {
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    var user: User! = nil
    let db = Firestore.firestore()
    let userID = Auth.auth().currentUser!.uid
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signUp(_ sender: Any) {
        let email = email.text!
        let password = password.text!
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                            print("Error al crear usuario")
                            print(error.localizedDescription)
                            return
                        } else {
                            print("Registro correcto")
                        }
            
            do {
                try self.db.collection("Users").document(self.userID).setData(from: self.user)
                //self.showToast(message: "Perfil actualizado correctamente")
                print("Perfil guardado a DB correctamente")
            } catch let error {
                print("Error writing user to Firestore: \(error)")
            }
            
        }
    }

    @IBAction func backToLogIn(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
}
