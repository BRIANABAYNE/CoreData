//
//  DetailViewController.swift
//  CoreData3
//
//  Created by Briana Bayne on 2/19/24.
//

import UIKit

class DetailViewController: UIViewController {

    // MARK: - Outlets
    
    
    @IBOutlet weak var coreDataImage: UIImageView!
    @IBOutlet weak var coreDataNameTextField: UITextField!
    @IBOutlet weak var coreDataArtistTextField: UITextField!
    @IBOutlet weak var coreDataYearTextField: UITextField!
    
    // MARK: - Lifecycle's
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyBoard))
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func hideKeyBoard() {
        view.endEditing(true)
    }
    
// MARK: - Actions
    
    @IBAction func coreDataSaveButtonTapped(_ sender: Any) {
        print("I'm so good at coding")
    }

}
