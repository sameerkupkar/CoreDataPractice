//
//  ShowDataViewController.swift
//  CoreDataPractice
//
//  Created by Lovina on 13/08/18.
//  Copyright © 2018 Lovina. All rights reserved.
//

import UIKit
import  CoreData

class ShowDataViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var editingIndexPath: IndexPath?
    @IBOutlet weak var ShowDataTable: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
      return  alldataArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellforname") as! show_DataTableViewCell
        cell.EmaiLbl.text = (alldataArray[indexPath.row] as! String)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print("Deleted")
            
           
            
       
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        let context =
            appDelegate.persistentContainer.viewContext
        context.delete(people[indexPath.row] as NSManagedObject)
           // context.delete(alldataArray[indexPath.row] as! NSManagedObject)
            print("print Index ....\(indexPath.row)")
        alldataArray.removeObject(at: indexPath.row)
            people.remove(at: indexPath.row)
           print("after delete \(alldataArray)")
               print("after delete \(people)")
            do{
             try context.save()
                
            
            
        } catch {
            
            }
  
            
            print("count for array..\(indexPath)")
     
           ShowDataTable.reloadData()
            tableView.reloadData()
            

            tableView.deleteRows(at: [indexPath] , with: .automatic)
            ShowDataTable.deleteRows(at: [indexPath], with: .automatic)
      
            
//            ShowDataTable.reloadData()
//            ShowDataTable.endUpdates()
            tableView.endUpdates()

            tableView.reloadData()
        }
    }
var people: [User] = []
    
    var alldataArray: NSMutableArray = []
    override func viewDidLoad() {
        super.viewDidLoad()

        
        ShowDataTable.delegate = self
        ShowDataTable.dataSource = self
       
      
    }
    override func viewWillAppear(_ animated: Bool) {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        //2
//        let fetchRequest =
//            NSFetchRequest<NSManagedObject>(entityName: "User")
//        print("USERINFO......\(fetchRequest)")
//        let users = try! managedContext.fetch(fetchRequest)
//        let john: User = users.first as! User
//        print("Email: \(john.email!)")
//        alldataArray.add(john.email!)
//        print("AllDeataArray.......\(alldataArray)")
        
        //3
        do {
         //   people = try managedContext.fetch(fetchRequest) as! [User]
            people = try managedContext.fetch(User.fetchRequest())
            print("bbbbb===\(people)")
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        for img in people  {
            let named = img.email
            alldataArray.add(named!)
            
        }
        print("AllDAta====\(alldataArray)")
        print("Befor Array Count..\(alldataArray.count)")
      
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
