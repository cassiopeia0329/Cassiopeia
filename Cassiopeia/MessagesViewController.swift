//
//  MessagesViewController.swift
//  Cassiopeia
//
//  Created by stargaze on 5/23/19.
//  Copyright © 2019 Cassiopeia. All rights reserved.
//

import UIKit
import Parse
import AlamofireImage

class MessagesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    // Create an empty array of PFObjects
    var offers = [PFObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // Refresh the view
        super.viewDidAppear(animated)
        
        let query = PFQuery(className:"Offers")
        
        //        query.whereKey("art", equalTo:artid!)
        
        //                query.includeKeys(["artist", "art", "title"])
        query.includeKey("buyer")
        
        query.findObjectsInBackground { (offers, error) in
            // If you find offers, get them and reload the view
            if offers != nil {
                self.offers = offers!
                self.tableView.reloadData()
                print("there are offers for this work")
                print(offers!)
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
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//
//        // Find the selected art
//        let cell = sender as! UITableViewCell // cast the sender as the UITableViewCell
//        let indexPath = tableView.indexPath(for: cell)! // tableview knows for a given cell what the index path is
//        let artwork = artworks[indexPath.row] // finally access the array
//        let user = artwork["artist"] as! PFUser
//
//        // Pass the selected art to the details view controller
//        let detailsViewController = segue.destination as! MoreInfoViewController
//        detailsViewController.artwork = artwork
//        detailsViewController.user = user
//        tableView.deselectRow(at: indexPath, animated: true) // deselect the row so that it's only highlighted briefly when you select it.
//    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
