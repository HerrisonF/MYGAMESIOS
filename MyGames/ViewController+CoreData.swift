//
//  ViewController+CoreData.swift
//  MyGames
//
//  Created by Herrison Feres on 23/05/22.
//

import Foundation
import UIKit
import CoreData


extension UIViewController {
    
    var context: NSManagedObjectContext{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
}
