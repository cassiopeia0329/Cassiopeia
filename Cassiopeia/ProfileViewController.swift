//
//  ProfileViewController.swift
//  Cassiopeia
//
//  Created by stargaze on 5/23/19.
//  Copyright © 2019 Cassiopeia. All rights reserved.
//

import UIKit
import Parse

class ProfileViewController: UIViewController {
    @IBAction func onLogout(_ sender: Any) {
        // Log out the parse user
        PFUser.logOut()
        
        let main = UIStoryboard(name: "Sara", bundle: nil)
        let loginViewController = main.instantiateViewController(withIdentifier: "LoginViewController")
        
        // Access the window via appdelegate
        // The app has access to a shared application object that will be casted as type AppDelegate because the AppDelegate.swift file has the window object
        let delegate = UIApplication.shared.delegate as! AppDelegate
        
        // Change the window to the login view controller
        delegate.window?.rootViewController = loginViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
