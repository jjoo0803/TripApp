//
//  DetailViewController.swift
//  App
//
//  Created by 박주현 on 2017. 12. 1..
//  Copyright © 2017년 박주현. All rights reserved.
//

import UIKit
import CoreData

class DetailViewController: UIViewController {
    
    var savetrip: NSManagedObject?

    @IBOutlet var label_country: UILabel!
    @IBOutlet var label_category: UILabel!
    @IBOutlet var label_money: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let friend = savetrip {
            label_country.text = friend.value(forKey: "country") as? String
            label_category.text = friend.value(forKey: "category") as? String
            label_money.text = friend.value(forKey: "save") as? String
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
