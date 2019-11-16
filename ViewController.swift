//
//  ViewController.swift
//  coreDataSwift
//
//  Created by Felix-ITS 012 on 27/12/17.
//  Copyright © 2017 felix. All rights reserved.
//

import UIKit
import CoreData
class ViewController: UIViewController {
    let delegate=UIApplication.shared.delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()
        readFromCoreData()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func readFromCoreData() {
        let context=delegate.persistentContainer.viewContext;

       let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Employee")
       //request.predicate = NSPredicate(format: "name = %@", "Nilesh")
      //request.returnsObjectsAsFaults = false
      do {
           let result = try context.fetch(request)
           for data in result as! [NSManagedObject] {
            let str=data.value(forKey: "name") as! String
            print(str)
            let contactNumber=data.value(forKey: "contactNo") as! String
               print(contactNumber)
           }
        
        
      }
        
       catch {
        
           print(error.localizedDescription)
       }
       
//        This will pr
        
//        do{
//      let  result = try request.execute()
//            for res in result {
//                print(res)
//            }
//            
//        }
//        catch
//        {
//            print(error.localizedDescription)
//        }
        
        
        
        
        
        
    }
    @IBAction func deleteButton(_ sender: Any) {
        let context=delegate.persistentContainer.viewContext;
                let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Employee")
        request.returnsObjectsAsFaults = false
        request.predicate = NSPredicate(format: "name = %@", employeeNameText.text!)
        do
        {
            let result = try context.fetch(request)
            print(result)
            if(result.count==1)
            {
                let object:NSManagedObject = result.first as! NSManagedObject
                print(object)
                context.delete(object)
               try context.save()
            }
            
        }
        catch
        {
            print(error.localizedDescription)
        }
        print("Delete:Success")
        
    }

    @IBAction func updateButton(_ sender: Any) {
        
        let context=delegate.persistentContainer.viewContext;
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Employee")
        request.returnsObjectsAsFaults = false

        request.predicate = NSPredicate(format: "name = %@", employeeNameText.text!)

        do
        {
        let result = try context.fetch(request)
            print(result)
            if(result.count==1)
            {
            let object:NSManagedObject = result.first as! NSManagedObject
                print(object)
                object.setValue(empContactNoText.text, forKey:"contactNo")
                try context.save()
            }
        }
        catch
        {
            print(error.localizedDescription)
        }
        print("Update:Success")
    }
    @IBAction func inserButton(_ sender: Any) {
        let context=delegate.persistentContainer.viewContext;

        //let entityDescription=NSEntityDescription .entity(forEntityName: "Employee", in: context);

        let empObject:NSObject=NSEntityDescription.insertNewObject(forEntityName: "Employee", into: context)
        empObject.setValue(self.employeeNotext.text, forKey: "employeeNo")
        empObject.setValue(self.employeeNameText.text, forKey: "name")
        empObject.setValue(self.empContactNoText.text, forKey: "contactNo")
        empObject.setValue(self.departmentNotext.text, forKey: "departmentNo")
        let formater=NumberFormatter()
        let sal=formater.number(from: self.salaryText.text!) as! Double
        empObject.setValue(sal, forKey: "salary")
         do
         {
            try context.save()
        }
        catch
        {
            print(error.localizedDescription)
        
        }
        print("Insert:Success")

    }
    
    @IBOutlet var salaryText: UITextField!
    @IBOutlet var departmentNotext: UITextField!
    @IBOutlet var employeeNotext: UITextField!
    
    @IBOutlet var employeeNameText: UITextField!
    
    @IBOutlet var empContactNoText: UITextField!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

