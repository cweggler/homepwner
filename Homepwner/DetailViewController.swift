//
//  DetailViewController.swift
//  Homepwner
//
//  Created by Cara on 3/26/19.
//  Copyright © 2019 Cara. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    @IBOutlet var nameField: UITextField!
    @IBOutlet var serialNumberField: UITextField!
    @IBOutlet var valueField: UITextField!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    
    var item: Item!{
        didSet{
            navigationItem.title = item.name
        }
    }
    
    var imageStore: ImageStore!
    
    // allows the user to dismiss the keyboard by touching in the background
    @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @IBAction func takePicture(_ sender: UIBarButtonItem) {
        
        let imagePicker = UIImagePickerController()
        
        // if the device has a camera, take a picture
        // otherwise just pick from the photo library
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
        } else {
            imagePicker.sourceType = .photoLibrary
        }
        
        imagePicker.delegate = self
        
        // place imagePicker on the screen
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func deletePicture(_ sender: UIBarButtonItem) {
        
        // delete the picture
        imageStore.deleteImage(forKey: item.itemKey)
        
        // refresh the view to show the picture is no longer there
        viewWillAppear(true)
        
    }
    
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        
        // Get picked image from info dictionary
        let image = info[.originalImage] as! UIImage
        
        // store the image in the ImageStore for the item's key
        imageStore.setImage(image, forKey: item.itemKey)
        
        // put the image on display in ImageView
        imageView.image = image
        
        // dismiss the image picker
        dismiss(animated: true, completion: nil)
    }
    
    // creates a NumberFormatter to use for the Item's value
    let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    // creates a DateFormatter to user for the Item's date created
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        nameField.text = item.name
        serialNumberField.text = item.serialNumber
        valueField.text = numberFormatter.string(from: NSNumber(value: item.valueInDollars))
        dateLabel.text = dateFormatter.string(from: item.dateCreated)
        
        // Get the item key
        let key = item.itemKey
        
        // If there is an associated image with the item
        // display it in the image view
        let imageToDisplay = imageStore.image(forKey: key)
        imageView.image = imageToDisplay
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        //dismiss the keyboard in a nicer way
        view.endEditing(true)
        
        // "Save" changes to Item
        item.name = nameField.text ?? "" // this unwraps an optional but provides an alternative to nil
        item.serialNumber = serialNumberField.text
        
        if let valueText = valueField.text,
            let value = numberFormatter.number(from: valueText){
            item.valueInDollars = value.intValue // saving value in Dollars
            
        }
        else {
            item.valueInDollars = 0
        }
    }
    
    
}
