//
//  NotificationTableViewController.swift
//  design-pattern
//
//  Created by Flwrnt on 10/11/2016.
//  Copyright © 2016 Flwrnt. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleCellLabel: UILabel!
    @IBOutlet weak var descCellLabel: UILabel!
    @IBOutlet weak var imgCellImageView: UIImageView!
    @IBOutlet weak var dateCellLabel: UILabel!
}

class NotificationTableViewController: UITableViewController {
    lazy var viewModel: NotificationTableViewModel = NotificationTableViewModel(tableView: self.tableView)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.edgesForExtendedLayout = [];
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        viewModel.notificationsRequest()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return viewModel.notificationsCount()
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "notificationCell", for: indexPath) as! CustomTableViewCell

        // Configure the cell...
        let notification = viewModel.getNotification(at: indexPath.row)
        cell.titleCellLabel.text = notification.title!
        cell.descCellLabel.text = notification.body!
        cell.dateCellLabel.text = (notification.receive_date as! Date).beautiful()

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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        guard segue.identifier == "notificationDetails" else { print(Log("wrong segue identifier")); return }
        guard let detailsVewController = segue.destination as? NotificationViewController else { return }
        
        if let indexPath = tableView.indexPath(for: sender as! UITableViewCell) {
            let notification = viewModel.getNotification(at: indexPath.row)
            detailsVewController.viewModel.configure(notification: notification)
        }
    }
 
}
