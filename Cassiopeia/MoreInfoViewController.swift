//
//  MoreInfoViewController.swift
//  Cassiopeia
//
//  Created by stargaze on 5/23/19.
//  Copyright © 2019 Cassiopeia. All rights reserved.
//

import UIKit
import Parse
import AlamofireImage

class MoreInfoViewController: UIViewController {
    @IBOutlet weak var artistImageView: UIImageView!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var artTitle: UILabel!
    @IBOutlet weak var artImageView: UIImageView!
    @IBOutlet weak var mediumLabel: UILabel!
    @IBOutlet weak var dateMadeLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
    var artwork = PFObject()
    var user = PFUser()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set the text labels
        artistLabel.text = user.username
        artTitle.text = artwork["title"] as! String
        mediumLabel.text = artwork["medium"] as! String
        dateMadeLabel.text = artwork["created"] as! String
        descLabel.text = artwork["desc"] as! String
        
        // set the art image
        let imageFile = artwork["image"] as! PFFileObject
        let urlString = imageFile.url!
        let url = URL(string: urlString)
        artImageView.af_setImage(withURL: url!)
        
        // Set the profile image
//        let pimageFile = user["image"] as! PFFileObject
//        let purlString = pimageFile.url!
//        let purl = URL(string: purlString)
//        artistImageView.af_setImage(withURL: purl!)
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
