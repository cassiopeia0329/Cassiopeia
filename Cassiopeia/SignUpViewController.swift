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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
