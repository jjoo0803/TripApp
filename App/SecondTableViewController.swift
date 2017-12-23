//
//  SecondTableViewController.swift
//  App
//
//  Created by 박주현 on 2017. 12. 1..
//  Copyright © 2017년 박주현. All rights reserved.
//

import UIKit
import CoreData


class SecondTableViewController: UITableViewController {
    
    var trips: [NSManagedObject] = []
    
    var totalCount: [Int] = [0, 0, 0]
    var currentSection = 0;

    @IBOutlet var listTab: UITabBarItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "List"
        self.navigationItem.leftBarButtonItem = self.editButtonItem
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
        return trips.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Trips Cell", for: indexPath)

        let trip = trips[indexPath.row]
        var display: String = ""

        
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let dbDate: Date? = trip.value(forKey: "date") as? Date
        let money: String? = (trip.value(forKey: "save") as? String)
        
        if let unwrapDate = dbDate {
            let displayDate = formatter.string(from: unwrapDate as Date)
            display = displayDate
        }
        
        
        if let con = trip.value(forKey: "country") as? String {
            display = display + " " + con }
        

        cell.textLabel?.text = display
        cell.detailTextLabel?.text =  money
        

        
        return cell
    }
    

    
    
    func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    // View가 보여질 때 자료를 DB에서 가져오도록 한다
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let context = self.getContext()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Trip")
        
        // 정렬
        let sortDescriptor = NSSortDescriptor (key: "date", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        do {
            trips = try context.fetch(fetchRequest) //테이블로 받아온다
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        let tabController = appDelegate.window?rootController
//        let tableVC = tabController?.childViewControllers[1] as! SecondTableViewController
//        tableVC.listTab.badgeValue = String(format: "%d", self.trips.count)

        
        self.tableView.reloadData()
        
    }

    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let context = getContext()
            context.delete(trips[indexPath.row])
            do {
                try context.save()
                print("deleted!")
            } catch let error as NSError {
                print("Could not delete \(error), \(error.userInfo)") }
            // 배열에서 해당 자료 삭제
            trips.remove(at: indexPath.row)
            // 테이블뷰 Cell 삭제
            tableView.deleteRows(at: [indexPath], with: .fade)        }
        else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

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
        if segue.identifier == "toDetailview" {
            if let destination = segue.destination as? DetailViewController {
                if let selectedIndex = self.tableView.indexPathsForSelectedRows?.first?.row {
                    destination.savetrip = trips[selectedIndex] }
            }
        }

        
    
    }
    

}
