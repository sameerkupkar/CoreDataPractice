//
//  ViewController.swift
//  CoreDataPractice
//
//  Created by Lovina on 13/08/18.
//  Copyright © 2018 Lovina. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    var people: [NSManagedObject] = []
    @IBOutlet weak var EmailTxt: UITextField!
    
    @IBOutlet weak var NameTxt: UITextField!
    @IBOutlet weak var NoChildTxt: UITextField!
    var appdelegate : AppDelegate!
    var context : NSManagedObjectContext!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        appdelegate = UIApplication.shared.delegate as! AppDelegate
     context = appdelegate.persistentContainer.viewContext
       
        
    }
    override func viewWillAppear(_ animated: Bool) {
        appdelegate = UIApplication.shared.delegate as! AppDelegate
        context = appdelegate.persistentContainer.viewContext
        
    }

    @IBAction func SaveButton(_ sender: Any) {
        let entity = NSEntityDescription.entity(forEntityName: "User", in: context)
        let  NewUser = NSManagedObject(entity: entity!, insertInto: context)
        NewUser.setValue(NameTxt.text, forKey: "name")
        NewUser.setValue(EmailTxt.text, forKey: "email")
        NewUser.setValue(NoChildTxt.text, forKey: "number_of_children")
        do {
            try context.save()
            
            people.append(NewUser)
        } catch {
            print("Failed saving")
        }
        
        
        let Nextview = self.storyboard?.instantiateViewController(withIdentifier: "ShowView") as! ShowDataViewController
       self.navigationController?.pushViewController(Nextview, animated: true)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

