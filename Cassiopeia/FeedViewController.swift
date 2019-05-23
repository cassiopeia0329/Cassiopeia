//
//  FeedViewController.swift
//  Cassiopeia
//
//  Created by stargaze on 5/3/19.
//  Copyright © 2019 Cassiopeia. All rights reserved.
//

import UIKit
import Parse
import AlamofireImage

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    @IBOutlet weak var tableView: UITableView!
    
//    var selectedPost: PFObject!
    
    // Create an empty array of PFObjects
    var artworks = [PFObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // Refresh the view
        super.viewDidAppear(animated)
        
        let query = PFQuery(className:"Art")
        // Allows us to load the objects: get the artist and title
//        query.includeKeys(["artist", "title"])
        query.includeKey("artist")
        query.limit = 20
        
        query.findObjectsInBackground { (artworks, error) in
            // If you find artworks, get them and reload the view
            if artworks != nil {
                self.artworks = artworks!
                self.tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return artworks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArtCell", for: indexPath) as! ArtCell
        
        // Grab the data from the dictionary
        let artwork = artworks[indexPath.row]
        
        let user = artwork["artist"] as! PFUser
        
        // Set the labels
        cell.artistLabel.text = user.username
        cell.artTitleLabel.text = artwork["title"] as? String
        
        // Set the profile image
//        let pimageFile = user["image"] as! PFFileObject
//        let purlString = pimageFile.url!
//        let purl = URL(string: purlString)
//        cell.profileImageView.af_setImage(withURL: purl!)
        
        let imageFile = artwork["image"] as! PFFileObject
        let urlString = imageFile.url!
        let url = URL(string: urlString)
        
        cell.artImageView.af_setImage(withURL: url!)
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        // Find the selected art
        let cell = sender as! UITableViewCell // cast the sender as the UITableViewCell
        let indexPath = tableView.indexPath(for: cell)! // tableview knows for a given cell what the index path is
        let artwork = artworks[indexPath.row] // finally access the array
        let user = artwork["artist"] as! PFUser
        
        // Pass the selected art to the details view controller
        let detailsViewController = segue.destination as! MoreInfoViewController
        detailsViewController.artwork = artwork
        detailsViewController.user = user
        tableView.deselectRow(at: indexPath, animated: true) // deselect the row so that it's only highlighted briefly when you select it.
    }


}
