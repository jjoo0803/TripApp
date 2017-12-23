//
//  SaveViewController.swift
//  App
//
//  Created by 박주현 on 2017. 12. 1..
//  Copyright © 2017년 박주현. All rights reserved.
//

import UIKit
import CoreData

class SaveViewController: UIViewController,UITextFieldDelegate {
    
    var saveArts: NSManagedObject?

    @IBOutlet var textCountry: UITextField!
    @IBOutlet var textCategory: UITextField!
    @IBOutlet var textExchage: UITextField!
    @IBOutlet var textMoney: UITextField!
    
    @IBOutlet var textDate: UITextField!
    

    @IBOutlet var display: UILabel!
    

    
    func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool { textField.resignFirstResponder()
        return true }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let datePicker = UIDatePicker()
        
        datePicker.datePickerMode = UIDatePickerMode.date
        datePicker.addTarget(self, action: #selector(SaveViewController.datePickerValueChanged), for: UIControlEvents.valueChanged)
        
        textDate.inputView = datePicker
        
    }

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    func datePickerValueChanged(sender:UIDatePicker) {
        
        
        let formatter = DateFormatter()
        
        formatter.dateStyle = DateFormatter.Style.medium
        
        formatter.timeStyle = DateFormatter.Style.none
        
        textDate.text = formatter.string(from: sender.date)
        
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    
    

    @IBAction func buttonPressed() {

        
        if (((textExchage.text) == "") || ((textMoney.text) == "")) {
            
            let dialog = UIAlertController(title: "", message: "금액을 입력해주세요", preferredStyle: .alert)
            
            let action = UIAlertAction(title: "확인", style: UIAlertActionStyle.default)
            dialog.addAction(action)
            
            self.present(dialog, animated: true, completion: nil)
            
        }
   
        
        else {
            
            if let aa = (Int((textMoney.text)!)){
                if let bb = (Int((textExchage.text)!)) {
                    
                    let money = (aa * bb)
                    display.text = String(money)
                }
                else {
                    let dialog = UIAlertController(title: "", message: "숫자를 입력해주세요", preferredStyle: .alert)
                    
                    let action = UIAlertAction(title: "확인", style: UIAlertActionStyle.default)
                    dialog.addAction(action)
                    
                    self.present(dialog, animated: true, completion: nil)

                }
            }
            else {
                let dialog = UIAlertController(title: "", message: "숫자를 입력해주세요", preferredStyle: .alert)
                
                let action = UIAlertAction(title: "확인", style: UIAlertActionStyle.default)
                dialog.addAction(action)
                
                self.present(dialog, animated: true, completion: nil)

            }
            
        }
     
    }
    
    
    @IBAction func savePressed(_ sender: UIBarButtonItem) {
        
        
        let context = getContext()
        let entity = NSEntityDescription.entity(forEntityName: "Trip", in: context)
        // friend record를 새로 생성함
        let object = NSManagedObject(entity: entity!, insertInto: context)
        object.setValue(textCountry.text, forKey: "country")
        object.setValue(textCategory.text, forKey: "category")
        if let aa = display.text {
            print ("aa")
            object.setValue(aa, forKey: "save")
        }

        object.setValue(Date(), forKey: "date")
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
