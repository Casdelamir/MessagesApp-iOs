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
import GoogleSignIn

class LogInViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var contentView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        contentView.layerGradient()
    }
    
    @IBAction func signIn(_ sender: Any) {
        let email = email.text!
        let password = password.text!
        
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                            print("Error al iniciar sesión")
                            print(error.localizedDescription)
                            return
                        } else {
                            print("Login correcto")
                            self.goToHomePage()
                        }
        }
    }
    
    @IBAction func signInGoogle(_ sender: Any) {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config

        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { [unowned self] result, error in
          guard error == nil else {
              print(error!.localizedDescription)
              return
          }

          guard let user = result?.user,
            let idToken = user.idToken?.tokenString
          else {
              print("Error obteniendo el usuario o el token")
             return
          }

          let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                         accessToken: user.accessToken.tokenString)

            Auth.auth().signIn(with: credential) { result, error in
                if let error = error {
                    print("Error al iniciar sesión con Google")
                    print(error.localizedDescription)
                    return
                } else {
                    print("Login correcto con Google")
                    self.goToHomePage()
                }
            }
        }
    }
    
    func goToHomePage() {
            self.performSegue(withIdentifier: "goToHomePage", sender: self)
        }
}

