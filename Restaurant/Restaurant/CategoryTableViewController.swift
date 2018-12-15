//
//  CategoryTableViewController.swift
//  Restaurant
//
//  Created by Silke Knossen on 04/12/2018.
//  Copyright © 2018 Silke Knossen. All rights reserved.
//

import UIKit

class CategoryTableViewController: UITableViewController {

    // Initialize array of categories
    var categories = [String]()

    // When the view did load, fetch all categories and update the view.
    override func viewDidLoad() {
        super.viewDidLoad()
        MenuController.shared.fetchCategories { (categories) in
            if let categories = categories {
                self.updateUI(with: categories)
            }
        }
    }

    // Store the categories in the array, and reload it to make sure
    // the cells have the categories when they are fetched.
    func updateUI(with categories: [String]) {
        DispatchQueue.main.async {
            self.categories = categories
            self.tableView.reloadData()
        }
    }
    
    // Number of rows is the number of elements in the category array.
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    // Create each cell for each category.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCellIdentifier", for: indexPath)
        configure(cell, forItemAt: indexPath)
        return cell
    }
    
    // Each cell gets one category from the array as title.
    func configure(_ cell: UITableViewCell, forItemAt indexPath: IndexPath) {
        let categoryString = categories[indexPath.row]
        cell.textLabel?.text = categoryString.capitalized
    }
    
    // Give the category that is clicked to the next view controller.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) { if segue.identifier == "MenuSegue" {
        let menuTableViewController = segue.destination as! MenuTableViewController
        let index = tableView.indexPathForSelectedRow!.row
        menuTableViewController.category = categories[index]
        }
    }

}
