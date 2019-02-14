//
//  DetailsViewController.swift
//  artbook
//
//  Created by Hikmet H Uygur on 14.02.2019.
//  Copyright © 2019 Hikmet H Uygur. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var selectImg: UIImageView!
    
    @IBOutlet weak var nameText: UITextField!
    
    @IBOutlet weak var artistText: UITextField!
    
    @IBOutlet weak var yearText: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBarItems()
        
        selectImg.isUserInteractionEnabled = true
        let gestureRecognizer = UIGestureRecognizer(target: self, action: #selector(DetailsViewController.selectImage))
        selectImg.addGestureRecognizer(gestureRecognizer)
        
    }
    
    //when click user going to go photo library
    @objc func selectImage() {
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        selectImg.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    
    //Right Navigation Bar "Save"
    @objc private func setupNavigationBarItems () {
        
        self.navigationItem.setRightBarButton(UIBarButtonItem(barButtonSystemItem: .save, target: self, action: nil), animated: true)
        
    }
    
    
    

    

}
