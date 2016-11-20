//
//  NotificationTableViewController.swift
//  design-pattern
//
//  Created by Flwrnt on 10/11/2016.
//  Copyright © 2016 Flwrnt. All rights reserved.
//

import UIKit

class NotificationTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleCellLabel: UILabel!
    @IBOutlet weak var descCellLabel: UILabel!
    @IBOutlet weak var imgCellImageView: UIImageView!
    @IBOutlet weak var dateCellLabel: UILabel!
}

class NotificationTableViewController: UITableViewController {
    lazy var viewModel: NotificationTableViewModel = NotificationTableViewModel()
    
    var notifications = [Notifications]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        self.notifications = viewModel.getNotifications()
        
        let parameters: Parameters = [Const.Param.lastId: notifications.first?.id! ?? "0"]
        viewModel.notificationsRequest(parameters: parameters) { result in
            switch result {
            case .success(let notifications):
                self.notifications = notifications
            case .fail(let error):
                print(Log("error: \(error)"))
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return notifications.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "notificationCell", for: indexPath) as! NotificationTableViewCell

        // Configure the cell...
        let notification = notifications[indexPath.row]
        cell.titleCellLabel.text = notification.title!
        cell.descCellLabel.text = notification.body!
        cell.dateCellLabel.text = (notification.receive_date as! Date).beautiful()

        return cell
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        guard segue.identifier == "notificationDetails" else { print(Log("wrong segue identifier")); return }
        guard let detailsVewController = segue.destination as? NotificationViewController else { return }
        
        if let indexPath = tableView.indexPath(for: sender as! UITableViewCell) {
            let notification = notifications[indexPath.row]
            detailsVewController.viewModel.configure(notification: notification)
        }
    }
 
}
