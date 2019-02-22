//
//  DetailsViewController.swift
//  artbook
//
//  Created by Hikmet H Uygur on 14.02.2019.
//  Copyright © 2019 Hikmet H Uygur. All rights reserved.
//

import UIKit
import CoreData

class DetailsViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var nameText: UITextField!
    
    @IBOutlet weak var artistText: UITextField!
    
    @IBOutlet weak var yearText: UITextField!
    
    var chosenPainting = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        goToPaint()

        imageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(DetailsViewController.selectImage))
        imageView.addGestureRecognizer(gestureRecognizer)
        
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(DetailsViewController.saveButton))
        self.navigationItem.rightBarButtonItem = saveButton
        
    }
    
    
    
    //Tıklandığında databaseye kayıt edilen nesneye gidilmesi için. Tableview içerisinde.
    @objc func goToPaint() {
        
        if chosenPainting != "" {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Paintings")
            
            //Filtreliyoruz.
            fetchRequest.predicate = NSPredicate(format: "name = %@", self.chosenPainting)
            fetchRequest.returnsObjectsAsFaults = false
            
            do {
                
                let results = try context.fetch(fetchRequest)
                
                if results.count > 0 {
                    
                    for result in results as! [NSManagedObject]{
                        
                        if let name = result.value(forKey: "name") as? String{
                            nameText.text = name
                        }
                        
                        if let artist = result.value(forKey: "artist") as? String{
                            artistText.text = artist
                        }
                        
                        if let year = result.value(forKey: "year") as? Int{
                            yearText.text = String(year)
                        }
                        
                        if let imageData = result.value(forKey: "image") as? Data {
                            let image = UIImage(data: imageData)
                            self.imageView.image = image
                        }
                    }
                }
                
                
                
            } catch{
                
            }
            
            
        }
        
        
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
        
        //swift 4
        //imageView.image = info[UIImagePickerControllerEditedImage] as? UIImage
        
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    @objc private func saveButton() {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let newArt = NSEntityDescription.insertNewObject(forEntityName: "Paintings", into: context)
        
        //attributes
        newArt.setValue(artistText.text, forKey: "artist")
        newArt.setValue(nameText.text, forKey: "name")
        
        if let year = Int(yearText.text!) {
            newArt.setValue(year, forKey: "year")
        }
        
        let data = imageView.image!.jpegData(compressionQuality: 0.5)
        newArt.setValue(data, forKey: "image")
        
        do {
            try context.save()
            print("All good")
        } catch  {
            print("error")
        }
        
        
        NotificationCenter.default.post(name: NSNotification.Name("newPaint"), object: nil)
        self.navigationController?.popViewController(animated: true)
    }
}
