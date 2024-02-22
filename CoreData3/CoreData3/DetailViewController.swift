//
//  DetailViewController.swift
//  CoreData3
//
//  Created by Briana Bayne on 2/19/24.
//

import UIKit
import CoreData

class DetailViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    // MARK: - Outlets
    
    @IBOutlet weak var coreDataImage: UIImageView!
    @IBOutlet weak var coreDataNameTextField: UITextField!
    @IBOutlet weak var coreDataArtistTextField: UITextField!
    @IBOutlet weak var coreDataYearTextField: UITextField!
    
    
    var chosenPainting = ""
    var chosenPaintingID: UUID?

    
    // MARK: - Lifecycle's
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // If painting is not empty != then I am fetching the information from coreData
        if chosenPainting != "" {
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Paintings")
            let idString = chosenPaintingID?.uuidString
            fetchRequest.predicate = NSPredicate(format: "id = %@", idString!)
            fetchRequest.returnsObjectsAsFaults = false
            
            do {
                let results = try context.fetch(fetchRequest)
                if results.count > 0 {
                    for result in results as! [NSManagedObject] {
                        
                        if let name = result.value(forKey: "name") as? String {
                            coreDataNameTextField.text = name
                        }
                        
                        if let artist = result.value(forKey: "artist") as? String {
                            coreDataArtistTextField.text = artist
                        }
                        
                        if let year = result.value(forKey: "year") as? Int {
                            coreDataYearTextField.text = String(year)
                        }
                        
                        if let imageData = result.value(forKey: "image") as? Data {
                            let image = UIImage(data: imageData)
                            coreDataImage.image = image
                        }
                        
                    }
                }
                
            } catch {
                print("Error .. ")
            }
            
            // Display the default on the detailVC - creating empty string
        } else {
            coreDataNameTextField.text = ""
            coreDataArtistTextField.text = ""
            coreDataYearTextField.text = ""
        }
        
        // MARK: - Recognizers
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyBoard))
        view.addGestureRecognizer(tapGestureRecognizer)
        
        coreDataImage?.isUserInteractionEnabled = true
        let imageTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        coreDataImage.addGestureRecognizer(imageTapRecognizer)
    }
    
    
    // MARK: - OBJC C Functions
    
    @objc func hideKeyBoard() {
        view.endEditing(true)
    }
    
    // MARK: - ImagePicker
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // will give a dictionary
        coreDataImage.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func selectImage() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
// MARK: - Actions
    
    @IBAction func coreDataSaveButtonTapped(_ sender: Any) {

        // MARK: - CoreData
        
        /// Reaching the App Delegate with a constant
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        // Persistence
        let context = appDelegate.persistentContainer.viewContext
        /// Entities
        let newPainting = NSEntityDescription.insertNewObject(forEntityName: "Paintings", into: context)
        
        /// Attributes
        newPainting.setValue(coreDataNameTextField.text!, forKey: "name")
        newPainting.setValue(coreDataArtistTextField.text, forKey: "artist")
        
        // Int into String
        if let year = Int(coreDataYearTextField.text!) {
            newPainting.setValue(year, forKey: "year")
        }
        
        newPainting.setValue(UUID(), forKey: "id")
        
        let data = coreDataImage.image?.jpegData(compressionQuality: 0.5)
        newPainting.setValue(data, forKey: "image")
        
        do {
            try context.save()
            print("success saving data")
        } catch {
            print("Error saving data")
        }

    }


}
