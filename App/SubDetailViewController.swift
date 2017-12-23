//
//  SubDetailViewController.swift
//  App
//
//  Created by 박주현 on 2017. 12. 2..
//  Copyright © 2017년 박주현. All rights reserved.
//

import UIKit
import CoreData

class SubDetailViewController: UIViewController {
    
    var savememo: NSManagedObject?

    @IBOutlet var label_memo: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let memo = savememo{
            label_memo.text = memo.value(forKey: "memo") as? String
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
