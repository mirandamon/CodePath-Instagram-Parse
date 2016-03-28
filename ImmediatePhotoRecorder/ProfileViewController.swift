//
//  ProfileViewController.swift
//  Parstagram
//
//  Created by Nathan Miranda on 3/5/16.
//  Copyright © 2016 Miraen. All rights reserved.
//

import UIKit
import Parse

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var profileImageButton: UIButton!
    @IBOutlet weak var logoutImageButton: UIButton!
    @IBOutlet weak var logoutTextButton: UIButton!
    
    var user: PFUser?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if user == nil {                                   //viewing own profile
            user = PFUser.currentUser()
        }
        
        if profileImageButton.backgroundImageForState(.Normal) == nil {
            profileImageButton.setBackgroundImage(UIImage(named:"uploadGrey"), forState: .Normal)
        }
        
        profileImageButton.clipsToBounds = true
        profileImageButton.layer.masksToBounds = true
        profileImageButton.layer.cornerRadius = profileImageButton.frame.width/2

        usernameLabel.text = user?.username
        usernameLabel.font = UIFont(name: "Helvetica Neue", size: 24)
        
        let imageFile = user!["profile"] as? PFFile
        imageFile?.getDataInBackgroundWithBlock({ (data, error) -> Void in
            let image = UIImage(data: data!)
            self.profileImageButton.setBackgroundImage(image, forState: .Normal)
            self.profileImageButton.setTitle("", forState: .Normal)
        })
        
        
        if user != PFUser.currentUser() {          //viewing other users profile
            profileImageButton.userInteractionEnabled = false
            logoutImageButton.hidden = true
            logoutTextButton.hidden = true
            
        }
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    @IBAction func onLogout(sender: AnyObject) {
        NSNotificationCenter.defaultCenter().postNotificationName("logout", object: nil)
    }
    
    @IBAction func onProfileImage(sender: AnyObject) {
        let actionSheet = UIAlertController(title: "Pick a source", message: nil, preferredStyle: .ActionSheet)
        let cameraAction = UIAlertAction(title: "Take a picture", style: .Default) { (action) -> Void in
            //take a picture
            let vc = UIImagePickerController()
            vc.delegate = self
            vc.allowsEditing = true
            vc.sourceType = UIImagePickerControllerSourceType.Camera
            
            self.presentViewController(vc, animated: true, completion: nil)
        }
        let photoAction = UIAlertAction(title: "From Camera roll", style: .Default) { (action) -> Void in
            //pick from camera roll
            let vc = UIImagePickerController()
            vc.delegate = self
            vc.allowsEditing = true
            vc.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            
            self.presentViewController(vc, animated: true, completion: nil)
            
        }
        let cancel = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        actionSheet.addAction(cancel)
        actionSheet.addAction(cameraAction)
        actionSheet.addAction(photoAction)
        self.presentViewController(actionSheet, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        self.dismissViewControllerAnimated(true, completion: nil)
        profileImageButton.setTitle("", forState: .Normal)
        profileImageButton.setBackgroundImage(image, forState: .Normal)
        
        if let imageData = UIImagePNGRepresentation(image) {
            PFUser.currentUser()!["profile"] = PFFile(name: "image.png", data: imageData)
            PFUser.currentUser()!.saveInBackground()
        }
        
        
    }
    override func viewDidDisappear(animated: Bool) {
        navigationController?.popViewControllerAnimated(false)
    }

}

