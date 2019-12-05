//
//  ViewController.swift
//  Instagram
//
//  Created by Oluwakamiye Akindele on 25/11/2019.
//  Copyright © 2019 Oluwakamiye Akindele. All rights reserved.
//

import UIKit
import Firebase

class LogInViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var logInButton: UIButton!
    
    let db = Firestore.firestore()
    var email : String?
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        title = Constant.appName
        logInButton.roundBorder(borderWidth: 1)
    }
    
    @IBAction func logInButtonPressed(_ sender: UIButton) {
        if let email = emailTextField.text , let password = passwordTextField.text{
            Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
                if let e = error{
                    print(e.localizedDescription)
                }
                else{
                    self.performSegue(withIdentifier: Constant.signInSegue, sender: self)
                }
            }
        }
        passwordTextField.text = ""
    }
}

//MARK: - Extension for making buttons round
extension UIButton{
    func roundBorder(borderWidth : Int){
        self.layer.cornerRadius = 5
        self.layer.borderWidth = CGFloat(borderWidth)
        self.layer.borderColor = UIColor.clear.cgColor
    }
    
    func roundBorder(borderWidth : Int, borderColor : CGColor){
        self.roundBorder(borderWidth: borderWidth)
        self.layer.borderColor = borderColor
    }
}
