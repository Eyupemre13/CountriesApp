//
//  CoreDataManager.swift
//  ToDo
//
//  Created by Eyup Emre Aygun on 06.08.2022.
//
import Foundation

import Foundation
import CoreData
import UIKit

protocol CoreManager {
    
    func getData() -> [CountryCellData]?
    func addData(data: CountryCellData)
    func deleteDataByRow(data: CountryCellData)

    var appDelegate: AppDelegate { get set }
    var managedContext: NSManagedObjectContext { get set }
    var entity: NSEntityDescription { get set}
    var fetchRequest: NSFetchRequest<NSManagedObject> { get set }
    var request: NSFetchRequest<NSFetchRequestResult> { get set}
}

class CoreDataManager : CoreManager {
    
    lazy var appDelegate = UIApplication.shared.delegate as! AppDelegate
    lazy var managedContext = appDelegate.persistentContainer.viewContext
    lazy var fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavoritedCountries")
    lazy var entity = NSEntityDescription.entity(forEntityName: "FavoritedCountries", in: managedContext)!
    lazy var request = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoritedCountries")
    
    
    
    func controlData(data: CountryCellData) {
        guard let favoritedCheck = data.isFavorited else { return }
        if(favoritedCheck) {
            deleteDataByRow(data: data)
        }
        else {
            addData(data: data)
        }
    }
    
    func getData() -> [CountryCellData]?{
        var results = [NSManagedObject]()
        var data = [CountryCellData]()
 //       deleteDataByRow(data: CountryCellData(countryName: "", isFavorited: false, countryCode: ""))
        do{
            results = try managedContext.fetch(fetchRequest)
            for item in results {
                let temp = CountryCellData(countryName: item.value(forKey: "countryName") as! String, isFavorited: item.value(forKey: "isFavorited") as! Bool, countryCode: item.value(forKey: "countryCode") as! String)
                data.append(temp)
            }
            
        } catch let err as NSError{
            print("Error", err)
        }
        return data
    }
    
    func favoritedCount() -> Int? {
        guard let data = getData() else { return 0}
        return data.count
    }
    
    func checkFavorited(countryCode: String?) -> Bool{
        guard let favoritedDatas = getData() else { return false }
        
        var tempBool = false
        
        for favoritedData in favoritedDatas {
            if(countryCode == favoritedData.countryCode) {
                tempBool = true
                break
            }
            else {
                tempBool = false
            }
        }
        return tempBool
    }
    
    func addData(data: CountryCellData) {
        let event = NSManagedObject(entity: entity, insertInto: managedContext)
        
        event.setValue(data.countryName, forKeyPath: "countryName")
        event.setValue(data.countryCode, forKeyPath: "countryCode")
        event.setValue(data.isFavorited, forKeyPath: "isFavorited")

        saveContext()
    }

   
    func deleteDataByRow(data: CountryCellData) {
        do {
            let results = try managedContext.fetch(request) as! [NSManagedObject]
            for result in results{
          //      managedContext.delete(result)
                if(result.value(forKey: "countryCode") as! String == data.countryCode ?? ""){
                    managedContext.delete(result)
                }
            }
        } catch{
            print("error in deleting")
        }
        saveContext()
    }
    
    func saveContext(){
        do {
          try managedContext.save()
        } catch let error as NSError {
          print("Could not save. \(error), \(error.userInfo)")
        }
    }
}
