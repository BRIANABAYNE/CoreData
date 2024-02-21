//
//  TableViewController.swift
//  CoreData3
//
//  Created by Briana Bayne on 2/19/24.
//

import UIKit
import CoreData

class CoreDataTableViewController: UITableViewController {

    var nameArray = [String]()
    var idArray = [UUID]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getDataFromCoreData()
        
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(UIbarButton))
    }
    
    
    func getDataFromCoreData() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        /// Fetching CoreData
       let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Paintings")
        fetchRequest.returnsObjectsAsFaults = false
    
        
        
        do {
               let results = try context.fetch(fetchRequest)
            
            for result in results as! [NSManagedObject] { 
                if let name = result.value(forKey: "name") as? String {
                    self.nameArray.append(name)
                }
                
                if let id = result.value(forKey: "id") as? UUID {
                    self.idArray.append(id)
                }
                
                self.tableView.reloadData()
            }
            
            
            } catch {
                
                print("Error fetching the data")
            }
    }
    

    @objc func UIbarButton() {
        performSegue(withIdentifier: "toDetailVC", sender: nil)
    }

    // MARK: - Table view data source

  

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        return  nameArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PaintingCell", for: indexPath)
        cell.textLabel?.text = nameArray[indexPath.row]
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
