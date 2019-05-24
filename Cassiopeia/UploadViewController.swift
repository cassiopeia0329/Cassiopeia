//
//  UploadViewController.swift
//  Cassiopeia
//
//  Created by stargaze on 5/23/19.
//  Copyright © 2019 Cassiopeia. All rights reserved.
//

import UIKit
import AlamofireImage
import Parse

class UploadViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    @IBOutlet weak var artTitleField: UITextField!
    @IBOutlet weak var mediumField: UITextField!
    @IBOutlet weak var descField: UITextField!
    @IBOutlet weak var dateField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setting the placeholder text and color
        artTitleField.attributedPlaceholder = NSAttributedString(string: "Artwork Title", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        mediumField.attributedPlaceholder = NSAttributedString(string: "Medium", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        descField.attributedPlaceholder = NSAttributedString(string: "Description", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        dateField.attributedPlaceholder = NSAttributedString(string: "Date Created", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        
        // Setting borders
        artTitleField.layer.borderWidth = 1.0
        mediumField.layer.borderWidth = 1.0
        descField.layer.borderWidth = 1.0
        dateField.layer.borderWidth = 1.0
        
        let myColor = UIColor.darkGray
        artTitleField.layer.borderColor = myColor.cgColor
        mediumField.layer.borderColor = myColor.cgColor
        descField.layer.borderColor = myColor.cgColor
        dateField.layer.borderColor = myColor.cgColor
        
        let tap = UITapGestureRecognizer(target: self.view, action: Selector("endEditing:"))
        self.view.addGestureRecognizer(tap)
    }
    
    @IBAction func onSubmitButton(_ sender: Any) {
        // Create a PF Object that will be a table in the dashboard
        
        if artTitleField.text != nil && mediumField.text != nil && descField.text != nil && dateField.text != nil && artTitleField.text != "" && mediumField.text != "" && descField.text != "" && dateField.text != "" {
            let artwork = PFObject(className: "Art")
            
            artwork["title"] = artTitleField.text
            artwork["medium"] = mediumField.text
            artwork["desc"] = descField.text
            artwork["created"] = dateField.text
            artwork["artist"] = PFUser.current()
            
            // This is saved in a table just for the photos
            // Save the image as a png
            let imageData = imageView.image!.pngData()
            // Create a parse file
            let file = PFFileObject(data: imageData!)
            
            artwork["image"] = file
            
            artwork.saveInBackground { (success, error) in
                if success {
                    self.dismiss(animated: true, completion: nil)
                    print("saved")
                } else {
                    print("bleh")
                }
            }
            artTitleField.text = nil
            mediumField.text = nil
            descField.text = nil
            dateField.text = nil
            imageView.image = UIImage(named: "image_placeholder")

            self.performSegue(withIdentifier: "uploadedSegue", sender: nil)
        }
        else{
            print("artwork not uploaded")
        }
    }

    @IBAction func onCameraButton(_ sender: Any) {
        print("you clicked the camera image")
        let picker = UIImagePickerController()
        // When the user is done picking a photo, let the app know what they chose
        picker.delegate = self
        // Presents a second screen to user to allow them to edit the photo
        picker.allowsEditing = true
        
        // Picking the image picker's source: if the camera is available, use it, otherwise use the image library
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            // .camera is a swift enum
            picker.sourceType = .camera
        }
        else {
            picker.sourceType = .photoLibrary
        }
        present(picker, animated: true, completion: nil)
    }
    // Once the user selects an image, we want to get that image and place it in the view
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as! UIImage
        
        //Resize image for easier uploading to heroku
        let size = CGSize(width: 300, height: 300)
        let scaledImage = image.af_imageAspectScaled(toFill: size)
        
        //Set the imageview to the selected image
        imageView.image = scaledImage
        
        // Dismiss the camera view
        dismiss(animated: true, completion: nil)
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
