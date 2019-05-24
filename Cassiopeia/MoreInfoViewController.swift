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
    @IBOutlet weak var offerField: UITextField!
    
    // Create an empty array of PFObjects
    var offers = [PFObject]()
    
    var artwork: PFObject?
    var user = PFUser()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setting the placeholder text and color
        offerField.attributedPlaceholder = NSAttributedString(string: "$", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        
        // Setting borders
        offerField.layer.borderWidth = 1.0
        
        let myColor = UIColor.darkGray
        offerField.layer.borderColor = myColor.cgColor
        
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
        
        self.tableVIew.separatorStyle = UITableViewCell.SeparatorStyle.none
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
        let tap = UITapGestureRecognizer(target: self.view, action: Selector("endEditing:"))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
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
        if offerField.text != nil && offerField.text != "" {
            let offer = PFObject(className: "Offers")
            
            offer["buyer"] = PFUser.current()
            offer["art"] = artwork
            offer["seller"] = artwork!["artist"]
            offer["artid"] = artwork?.objectId as! String
            offer["offer"] = offerField.text
            
            offer.saveInBackground { (success, error) in
                if success {
                    let query = PFQuery(className:"Offers")
                    
                    let artid = self.artwork?.objectId
                    
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
                    print("offer made")
                } else {
                    print("offer NOT made")
                }
            }
        }
        else{
            print("invalid offer amount")
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
