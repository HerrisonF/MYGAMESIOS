//
//  ConsolesManager.swift
//  MyGames
//
//  Created by Herrison Feres on 23/05/22.
//

import Foundation
import CoreData

class ConsolesManager {
    static let shared = ConsolesManager()
    var consoles: [Console] = []
    
    func loadConsoles(with context: NSManagedObjectContext){
        let fetchRequest : NSFetchRequest<Console> = Console.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        do {
            consoles  = try context.fetch(fetchRequest)
        }catch {
            print(error.localizedDescription)
        }
    }
    
    func deleteConsole(index: Int, context: NSManagedObjectContext){
        let console = consoles[index]
        /// Esse primeiro delete, tira do context
        context.delete(console)
        /// O segundo delete, tira do banco de vdd(Persiste)
        do{
            try context.save()
            consoles.remove(at: index)
        }catch {
            print(error.localizedDescription)
        }
        
    }
    
    private init(){}
}
