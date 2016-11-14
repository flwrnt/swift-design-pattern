//
//  NotificationViewController.swift
//  design-pattern
//
//  Created by Flwrnt on 13/11/2016.
//  Copyright © 2016 Flwrnt. All rights reserved.
//

import UIKit

class NotificationViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var bodyTextView: UITextView!
    
    let viewModel = NotificationViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bodyTextView.isEditable = false
        
        titleLabel.text = viewModel.getTitle()
        bodyTextView.text = viewModel.getBody()
        dateLabel.text = viewModel.getDate()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
