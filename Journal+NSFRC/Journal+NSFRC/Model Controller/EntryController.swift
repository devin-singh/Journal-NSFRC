//
//  EntryController.swift
//  Journal+NSFRC
//
//  Created by Karl Pfister on 5/9/19.
//  Copyright © 2019 Karl Pfister. All rights reserved.
//

import Foundation
import CoreData

class EntryController {
    
    static let sharedInstance = EntryController()
    
    // Create a variable to access the fetched results controller
    var fetchedResultsController: NSFetchedResultsController<Entry>
    
    // Create an initializer that gives our fetchedResultsController a value
    init() {
        // Step 2: Created a fetch request in order to fufill the parameter requirement of the resultsController initializer.
        let fetchRequest: NSFetchRequest<Entry> = Entry.fetchRequest()
        // Step 3: Accessed the sort descriptors property on our fetch request and told it we wanted our results sorted by timestamp in a desending order.
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "timestamp", ascending: false)]
        
        // Step 4: We filled in the parameters of our results controller initializer with our fetch request, context from coreDataStack and passed in nil for section and cachee as they are not needed for this app.
                    
        // Step 1: created a constant called results controller that was a NSFetchedResultsController initialized from the avalailable initializer.
        let resultsController: NSFetchedResultsController<Entry> = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.context, sectionNameKeyPath: nil, cacheName: nil)
        // Step 5: We assigned our results controller constant as the value of our fetchedResultsController variable (This got rid of the need to return in our initializer)

        fetchedResultsController = resultsController
        
        // Step 6: We accessed our fetchedResultsController and try to run the performFetch functon given to us by apple.
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print("Error with fetching results \(error.localizedDescription)")
        }
    }
    
//    var entries: [Entry] {
//        let fetchRequest: NSFetchRequest<Entry> = Entry.fetchRequest()
//        return (try? CoreDataStack.context.fetch(fetchRequest)) ?? []
//    }
    
    //CRUD
    func createEntry(withTitle: String, withBody: String) {
        let _ = Entry(title: withTitle, body: withBody)
        
        saveToPersistentStore()
    }
    
    func updateEntry(entry: Entry, newTitle: String, newBody: String) {
        entry.title = newTitle
        entry.body = newBody
        
        saveToPersistentStore()
    }
    
    func deleteEntry(entry: Entry) {
        entry.managedObjectContext?.delete(entry)
        saveToPersistentStore()
    }
    
    func saveToPersistentStore() {
        do {
             try CoreDataStack.context.save()
        } catch {
            print("Error saving Managed Object. Items not saved!! \(#function) : \(error.localizedDescription)")
        }
    }
}
