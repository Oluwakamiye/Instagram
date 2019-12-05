//
//  SignUpViewController.swift
//  Instagram
//
//  Created by Oluwakamiye Akindele on 28/11/2019.
//  Copyright © 2019 Oluwakamiye Akindele. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    
    let db = Firestore.firestore()
    var username : String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signUpButton.roundBorder(borderWidth: 2)
    }
    
    @IBAction func signUpButtonPressed(_ sender: UIButton) {
        if let email = emailTextField.text, let password = passwordTextField.text, let username = usernameTextField.text{
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error{
                    print(e.localizedDescription)
                }
                else{
                    self.db.collection(Constant.FStore.userDetails).addDocument(data: [Constant.objectModel.username: username,
                                                                                       Constant.objectModel.email: email
                    ]) { (error) in
                        if let e = error{
                            print(e)
                        }
                    }
                    self.performSegue(withIdentifier: Constant.signUpSegue, sender: self)
                }
            }
        }
        passwordTextField.text = ""
    }
}
