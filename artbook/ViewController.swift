//
//  ViewController.swift
//  artbook
//
//  Created by Hikmet H Uygur on 14.02.2019.
//  Copyright © 2019 Hikmet H Uygur. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func addButton(_ sender: Any) {
        
        performSegue(withIdentifier: "toDetailsViewController", sender: nil)
        
    }
    
}

