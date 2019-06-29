//
//  ViewController.swift
//  Todoey
//
//  Created by Shimaa Elcc on 6/26/19.
//  Copyright © 2019 Shimaa Elcc. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    var itemArray = [item]()
    var defaults = UserDefaults.standard
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row].title
        cell.accessoryType = itemArray[indexPath.row].done ? .checkmark : .none
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        saveItems()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print(dataFilePath)

     loadItems()
    }


    @IBAction func addPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Tpdoey Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            print(textField.text!)
            let newitem = item()
            newitem.title = textField.text!
            self.itemArray.append(newitem)
            self.saveItems()
            print("Success!")
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Add item"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert,animated: true ,completion:nil)
    }
    func saveItems(){
        let Encoder = PropertyListEncoder()
        do {
            let data = try Encoder.encode(self.itemArray)
            try data.write(to: self.dataFilePath!)
        }
        catch{
          print("Error \(error)")
        }
        tableView.reloadData()
    }
    func loadItems(){
        if let data = try? Data(contentsOf: dataFilePath!){
            let decoder = PropertyListDecoder()
            do{
                itemArray = try decoder.decode([item].self, from: data)

            }
            catch{
                print("Error Decoding \(error)")
            }
        }
        
    }
}

