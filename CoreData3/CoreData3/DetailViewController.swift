//
//  DetailViewController.swift
//  CoreData3
//
//  Created by Briana Bayne on 2/19/24.
//

import UIKit

class DetailViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    // MARK: - Outlets
    
    
    @IBOutlet weak var coreDataImage: UIImageView!
    @IBOutlet weak var coreDataNameTextField: UITextField!
    @IBOutlet weak var coreDataArtistTextField: UITextField!
    @IBOutlet weak var coreDataYearTextField: UITextField!
    
    // MARK: - Lifecycle's
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
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
        print("I'm so good at coding")
    }

}
