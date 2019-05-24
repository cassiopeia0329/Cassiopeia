//
//  SignUpViewController.swift
//  Cassiopeia
//
//  Created by stargaze on 5/23/19.
//  Copyright © 2019 Cassiopeia. All rights reserved.
//

import UIKit
import Parse


class SignUpViewController: UIViewController {
    @IBOutlet weak var fullNameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var userTypeSegment: UISegmentedControl!
    @IBOutlet weak var backImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Send the background image to the back
        view.sendSubviewToBack(backImage)

        // Setting the placeholder text and color
        fullNameField.attributedPlaceholder = NSAttributedString(string: "Full Name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        emailField.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        usernameField.attributedPlaceholder = NSAttributedString(string: "Username", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        passwordField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        
        // Setting borders
        fullNameField.layer.borderWidth = 1.0
        emailField.layer.borderWidth = 1.0
        usernameField.layer.borderWidth = 1.0
        passwordField.layer.borderWidth = 1.0
        
        let myColor = UIColor.darkGray
        fullNameField.layer.borderColor = myColor.cgColor
        emailField.layer.borderColor = myColor.cgColor
        usernameField.layer.borderColor = myColor.cgColor
        passwordField.layer.borderColor = myColor.cgColor
    }
    
    
    @IBAction func onSignUo(_ sender: Any) {
        // On Sign Up create a Parse User
        let user = PFUser() //Make this a constant by using let
        user.username = usernameField.text
        user.password = passwordField.text
        user["name"] = fullNameField.text
        user.email = emailField.text
        
        var userType = "Artist"
        
        if userTypeSegment.selectedSegmentIndex == 1{
            userType = "Buyer"
        }
        
        user["type"] = userType
        
        // Sign up user
        user.signUpInBackground { (success, error) in
            if success {
                self.performSegue(withIdentifier: "signedUpSegue", sender: nil)
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
