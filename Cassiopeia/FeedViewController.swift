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
    
    var selectedPost: PFObject!
    
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
        query.includeKeys(["artist", "title"])
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
        // Since we are working with sections, we don't use indexPath.row to get the post, we use section
        let artwork = artworks[section]
        
        // Add 2 because we also want to show the "add a comment cell
        return artworks.count + 1
    }
    
    // Give each post a section that can have any number of rows
    func numberOfSections(in tableView: UITableView) -> Int {
        return artworks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Grab the data from the dictionary
        let artwork = artworks[indexPath.section]
        
        // The post cell is always the 0th row, so here we set the post cell
        
//        if indexPath.row == 0 {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArtCell") as! ArtCell
        
        let user = artwork["artist"] as! PFUser
        
        // Set the labels
        cell.artistLabel.text = user.username
        cell.artTitleLabel.text = artwork["title"] as? String
        
        let imageFile = artwork["image"] as! PFFileObject
        let urlString = imageFile.url!
        let url = URL(string: urlString)
        
        cell.artImageView.af_setImage(withURL: url!)
        
        return cell
//        } else if indexPath.row <= comments.count {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell") as! CommentCell
//
//            let comment = comments[indexPath.row - 1]
//            cell.commentLabel.text = comment["text"] as? String
//
//            let user = comment["author"] as! PFUser
//            cell.usernameLabel.text = user.username
//
//            return cell
//        } else {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "AddCommentCell")!
//            return cell
//        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        do something when this row is selected
//        let post = posts[indexPath.section]
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
