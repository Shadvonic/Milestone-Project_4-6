//
//  ViewController.swift
//  Milestone-Project_4-6
//
//  Created by Marc Moxey on 5/23/22.
//

import UIKit

class ViewController: UITableViewController {

    var shoppingList = [String]()
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
         title = "My Shopping List"
        
        //let user enter new item to shopping list
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(newItem))
        
        //add left bar button item that clears shopping list
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Clear", style: .plain, target: self, action: #selector(clearList))
        
        let sharedApp = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareApp))
        
        toolbarItems = [sharedApp]
        navigationController?.isToolbarHidden = false
      
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "List", for: indexPath)
        cell.textLabel?.text = shoppingList[indexPath.row]
        return cell
    }
    
    
    @objc func newItem() {
        //let user enter free text
        let ac = UIAlertController(title: "Enter item", message: nil, preferredStyle: .alert)
        ac.addTextField() //add textField
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) {
            
            [weak self, weak ac] _ in
            guard let item = ac?.textFields?[0].text else { return }
            self?.submit(item)
        }
        ac.addAction(submitAction) //add action to alert
        present(ac,animated: true) //present alert
    }
    
    
    func submit(_ item: String) {
        let cartItem = item
        
        //insert into array
        shoppingList.insert(cartItem, at: 0)
  
        //insert into table view
        let indexPath = IndexPath(row:  0, section: 0)
        //reload table data
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    @objc func clearList() {
        //clear items in array
        shoppingList.removeAll()
        //reload the table data
        tableView.reloadData()
    }
  
    
    @objc func shareApp() {
        let list = shoppingList.joined(separator: "\n")
        
        let vc = UIActivityViewController(activityItems: [list], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
    
    

}

