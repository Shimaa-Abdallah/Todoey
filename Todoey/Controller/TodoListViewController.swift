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
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if let items = defaults.array(forKey: "TodoListArray") as? [item] {
            itemArray = items
        }
        let newItem = item()
        newItem.title = "1"
        itemArray.append(newItem)
        let newItem2 = item()
        newItem2.title = "2"
        itemArray.append(newItem2)
        let newItem3 = item()
        newItem3.title = "33"
        itemArray.append(newItem3)
    }


    @IBAction func addPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Tpdoey Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            print(textField.text!)
            let newitem = item()
            newitem.title = textField.text!
            self.itemArray.append(newitem)
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            self.tableView.reloadData()
            print("Success!")
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Add item"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert,animated: true ,completion:nil)
    }
}

