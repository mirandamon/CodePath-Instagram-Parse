//
//  UploadViewController.swift
//  Parstagram
//
//  Created by Nathan Miranda on 3/21/16.
//  Copyright © 2016 Miraen. All rights reserved.
//

import UIKit

class UploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var imageButton: UIButton!
    @IBOutlet weak var uploadProgress: UIProgressView!
    @IBOutlet weak var captionField: UITextField!
    @IBOutlet weak var uploadButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var successLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initializeViews()
        successLabel.hidden = true
        
        captionField.delegate = self
        roundButton(imageButton)
        roundButton(uploadButton)
        roundButton(cancelButton)
        
        // Do any additional setup after loading the view.
    }
    
    func roundButton(button: UIButton){
        button.layer.cornerRadius = button.frame.width/6
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        print("return pressed")
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onImageButton(sender: AnyObject) {
        successLabel.hidden = true
        let actionSheet = UIAlertController(title: "Pick a source", message: nil, preferredStyle: .ActionSheet)
        let cameraAction = UIAlertAction(title: "Take a picture", style: .Default) { (action) -> Void in
            let vc = UIImagePickerController()
            vc.delegate = self
            vc.allowsEditing = true
            vc.sourceType = UIImagePickerControllerSourceType.Camera
            
            self.presentViewController(vc, animated: true, completion: nil)
        }
        let rollAction = UIAlertAction(title: "From Camera roll", style: .Default) { (action) -> Void in
            let vc = UIImagePickerController()
            vc.delegate = self
            vc.allowsEditing = true
            vc.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            
            self.presentViewController(vc, animated: true, completion: nil)
            
        }
        let cancel = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        actionSheet.addAction(cancel)
        actionSheet.addAction(cameraAction)
        actionSheet.addAction(rollAction)
        self.presentViewController(actionSheet, animated: true, completion: nil)
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        self.dismissViewControllerAnimated(true, completion: nil)
        imageButton.setBackgroundImage(image, forState: .Normal)
        imageButton.setTitle("", forState: .Normal)
    }
    @IBAction func onUpload(sender: AnyObject) {
        if imageButton.backgroundImageForState(.Normal) != nil {
            ParseData.postUserImage(imageButton.backgroundImageForState(.Normal), withCaption: captionField.text, withCompletion: { (success, error) -> Void in
                self.uploadProgress.hidden = true
                NSNotificationCenter.defaultCenter().postNotificationName("photoDidPost", object: nil)
                
                }, withProgress: { (prog) -> Void in
                    self.uploadProgress.hidden = false
                    if prog == 100 {
                        self.uploadProgress.setProgress(100, animated: false)
                        self.successLabel.hidden = false
                        let time = dispatch_time(dispatch_time_t(DISPATCH_TIME_NOW), 2 * Int64(NSEC_PER_SEC))
                        dispatch_after(time, dispatch_get_main_queue()) {
                            self.initializeViews()
//                            self.tabBarController?.selectedIndex = 0
                        }
                    } else {
                        self.successLabel.hidden = true
                        self.uploadProgress.setProgress(Float(prog), animated: true)
                    }
            })
            
        }
    }
    
    func initializeViews() {
        imageButton.setBackgroundImage(UIImage(named:"uploadWhite"), forState: .Normal)
        captionField.text = ""
        uploadProgress.hidden = true
        uploadProgress.setProgress(0, animated: false)
    }
    
    @IBAction func onCancel(sender: AnyObject) {
        self.initializeViews()
        tabBarController?.selectedIndex = 0
    }
    
    override func viewDidDisappear(animated: Bool) {
        successLabel.hidden = true
    }
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
