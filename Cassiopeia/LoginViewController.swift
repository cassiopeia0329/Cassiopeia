//
//  LoginViewController.swift
//  Cassiopeia
//
//  Created by stargaze on 5/3/19.
//  Copyright © 2019 Cassiopeia. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var backImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.sendSubviewToBack(backImage)
        
        // Setting the placeholder text and color
        usernameField.attributedPlaceholder = NSAttributedString(string: "Username", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        passwordField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        
        // Setting borders
        usernameField.layer.borderWidth = 1.0
        passwordField.layer.borderWidth = 1.0
        
        let myColor = UIColor.darkGray
        usernameField.layer.borderColor = myColor.cgColor
        passwordField.layer.borderColor = myColor.cgColor
    }

    
    @IBAction func onSIgnIn(_ sender: Any) {
        let username = usernameField.text!
        let password = passwordField.text!
        
        PFUser.logInWithUsername(inBackground: username, password: password)
        { (user, error) in
            if user != nil {
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            } else {
                print("Error: \(error?.localizedDescription)")
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
