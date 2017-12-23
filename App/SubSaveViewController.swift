//
//  SubSaveViewController.swift
//  App
//
//  Created by 박주현 on 2017. 12. 1..
//  Copyright © 2017년 박주현. All rights reserved.
//

import UIKit
import CoreData

class SubSaveViewController: UIViewController{


    
    @IBOutlet var memotext: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool { textField.resignFirstResponder()
        return true }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func savePressed(_ sender: UIBarButtonItem) {
        
        
        let context = getContext()
        let entity = NSEntityDescription.entity(forEntityName: "Memo", in: context)
        // friend record를 새로 생성함
        let object = NSManagedObject(entity: entity!, insertInto: context)
        object.setValue(memotext.text, forKey: "memo")
        do {
            try context.save()
            print("saved!")
        } catch let error as NSError {
            print("Could not save \(error), \(error.userInfo)")
        }
        // 현재의 View를 없애고 이전 화면으로 복귀
        self.navigationController?.popViewController(animated: true)
        
    }
    

}
