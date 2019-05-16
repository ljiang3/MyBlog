//
//  LoginViewController.swift
//  MyBlog
//
//  Created by Liyao Jiang on 5/13/19.
//  Copyright © 2019 Liyao Jiang. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBAction func loginAction(_ sender: Any) {
        
        PFUser.logInWithUsername(inBackground: username.text!, password: password.text!) { (user: PFUser?
            , error: Error?) in
            if user != nil {
                print("Loged in Success!")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
            else{
                // Alert User it's a empty input
                let alertController = UIAlertController(title: "All Fields Required!", message: "", preferredStyle: .alert)

                self.present(alertController, animated: false) {
                    let action = UIAlertAction(title: "Back", style: .default) { (action) in
                    }
                    alertController.addAction(action)
                }
            }
        }
    }
    
    @IBAction func signupAction(_ sender: Any) {
        let newUser = PFUser()
        
        newUser.username = username.text
        newUser.password = password.text
        
        newUser.signUpInBackground { (success: Bool
            , error: Error?) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("User signed up successfully")
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
        }
    }
    
    // hidden keyboard when user touch outside
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
}
