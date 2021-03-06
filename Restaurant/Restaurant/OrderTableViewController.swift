//
//  OrderTableViewController.swift
//  Restaurant
//
//  Created by Silke Knossen on 04/12/2018.
//  Copyright © 2018 Silke Knossen. All rights reserved.
//

import UIKit

class OrderTableViewController: UITableViewController {
    
    // Initialize variable to store number of minutes untill order is ready.
    var orderMinutes = 0
    
    // When the view did load, clear the notifications, and create
    // edit button.
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem
        NotificationCenter.default.addObserver(tableView, selector: #selector(UITableView.reloadData), name: MenuController.orderUpdatedNotification, object: nil)
    }
    
    // Number of row is number of items in the order list.
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MenuController.shared.order.menuItems.count
    }
    
    // Create cell for each item from order list
    override func tableView(_ tableView: UITableView, cellForRowAt
        indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:
            "OrderCellIdentifier", for: indexPath)
        configure(cell, forItemAt: indexPath)
        return cell
    }
    
    // Fill each cell in the view with an image, title, and price
    // of the menu item that is in the order list.
    func configure(_ cell: UITableViewCell, forItemAt indexPath:
        IndexPath) {
        let menuItem = MenuController.shared.order.menuItems[indexPath.row]
        cell.textLabel?.text = menuItem.name
        cell.detailTextLabel?.text = String(format: "$%.2f", menuItem.price)
        MenuController.shared.fetchImage(url: menuItem.imageURL) { (image) in
            guard let image = image else { return }
            DispatchQueue.main.async {
                if let currentIndexPath = self.tableView.indexPath(for: cell), currentIndexPath != indexPath {
                    return
                }
                cell.imageView?.image = image
                cell.setNeedsLayout()
            }
        }
    }
    
    // Enable editing
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // Enable cell to be deleted.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            MenuController.shared.order.menuItems.remove(at:
            indexPath.row)
        }
    }
    
    // When dismissing, remove all items from the order list.
    @IBAction func unwindToOrderList(segue: UIStoryboardSegue) {
        if segue.identifier == "DismissConfirmation" {
            MenuController.shared.order.menuItems.removeAll()
        }
    }
    
    // When confirming, give the order-minutes to the next view.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ConfirmationSegue" {
            let orderConfirmationViewController = segue.destination as! OrderConfirmationViewController
            orderConfirmationViewController.minutes = orderMinutes
        }
    }
    
    // Compute minutes untill order is ready and show next view.
    func uploadOrder() {
        let menuIds = MenuController.shared.order.menuItems.map { $0.id }
        MenuController.shared.submitOrder(forMenuIDs: menuIds) { (minutes) in
            DispatchQueue.main.async {
                if let minutes = minutes {
                    self.orderMinutes = minutes
                    self.performSegue(withIdentifier:
                        "ConfirmationSegue", sender: nil)
                }
            }
        }
    }
    
    // When the submit button is tapped, compute the total price,
    // and show a pop up with option to upload the order or cancel.
    @IBAction func submitTapped(_ sender: Any) {
        let orderTotal =
            MenuController.shared.order.menuItems.reduce(0.0)
            { (result, menuItem) -> Double in
                return result + menuItem.price
        }
        let formattedOrder = String(format: "$%.2f", orderTotal)
        
        let alert = UIAlertController(title: "Confirm Order", message: "You are about to submit your order with a total of \(formattedOrder)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Submit", style: .default) { action in self.uploadOrder() })
        alert.addAction(UIAlertAction(title: "Cancel",
                                      style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
