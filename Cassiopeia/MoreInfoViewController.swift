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

class MoreInfoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var artistImageView: UIImageView!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var artTitle: UILabel!
    @IBOutlet weak var artImageView: UIImageView!
    @IBOutlet weak var mediumLabel: UILabel!
    @IBOutlet weak var dateMadeLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
    @IBOutlet weak var tableVIew: UITableView!
    
    // Create an empty array of PFObjects
    var offers = [PFObject]()
    
    var artwork: PFObject?
    var user = PFUser()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set the text labels
        artistLabel.text = user.username
        artTitle.text = artwork?["title"] as! String
        mediumLabel.text = artwork?["medium"] as! String
        dateMadeLabel.text = artwork?["created"] as! String
        descLabel.text = artwork?["desc"] as! String
        
        // set the art image
        let imageFile = artwork?["image"] as! PFFileObject
        let urlString = imageFile.url!
        let url = URL(string: urlString)
        artImageView.af_setImage(withURL: url!)
        
        // Set the profile image
//        let pimageFile = user["image"] as! PFFileObject
//        let purlString = pimageFile.url!
//        let purl = URL(string: purlString)
//        artistImageView.af_setImage(withURL: purl!)
        
        tableVIew.delegate = self
        tableVIew.dataSource = self
        
//        self.tableVIew.separatorStyle = UITableViewCell.SeparatorStyle.none
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // Refresh the view
        super.viewDidAppear(animated)
        
        let query = PFQuery(className:"Offers")
        
        let artid = artwork?.objectId
        
        // Trying to get a list of offers associated with this work
        query.whereKey("artid", equalTo:artid!)
        
//        To bring up a list of all offers
        query.includeKey("buyer")
        
        query.findObjectsInBackground { (offers, error) in
            // If you find offers, get them and reload the view
            if offers != nil {
                self.offers = offers!
                self.tableVIew.reloadData()
                print("there are offers for this work")
            }
            else{
                print("couldn't find any offers for this work")
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return offers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BuyerCell", for: indexPath) as! BuyerCell
        
        // Grab the data from the dictionary
        let offer = offers[indexPath.row]
        
        let buyer = offer["buyer"] as! PFUser
        
        // Set the labels
        cell.usernameLabel.text = buyer.username
        cell.offerLabel.text = offer["offer"] as! String

        print("cell loaded")
        
        // Set the profile image
        //        let pimageFile = buyer["image"] as! PFFileObject
        //        let purlString = pimageFile.url!
        //        let purl = URL(string: purlString)
        //        cell.profileImageView.af_setImage(withURL: purl!)
        
        return cell
    }
    
    @IBAction func onTapNewOffer(_ sender: Any) {
        // Create a PF Object that will be a table in the dashboard
//        if artTitleField.text != nil && mediumField.text != nil && descField.text != nil && dateField.text != nil && artTitleField.text != "" && mediumField.text != "" && descField.text != "" && dateField.text != "" {
        let offer = PFObject(className: "Offers")
        
        offer["buyer"] = PFUser.current()
        offer["art"] = artwork
        offer["seller"] = artwork!["artist"]
        offer["artid"] = artwork?.objectId as! String
        offer["offer"] = "125"
        
        offer.saveInBackground { (success, error) in
            if success {
                self.tableVIew.reloadData()
                print("offer made")
            } else {
                print("offer NOT made")
            }
        }
//        }
//        else{
//            print("offer not uploaded")
//        }
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
