//
//  HistoryDataAccessProvider.swift
//  MercadolibreSearch
//
//  Created by Roberto Parra Castillo on 01-05-21.
//

import Foundation
import CoreData

class HistoryDataAccessProvider: DataAccessProvider<MLSearchObject> {
    var filter = "" {
        didSet { updateData() }
    }

    public func addSearchObject(text: String, mode: String, lastUpdate: Date) {
        let newValue = NSEntityDescription.insertNewObject(
            forEntityName: "\(MLSearchObject.self)",
            into: managedObjectContext) as? MLSearchObject
        newValue?.text = text
        newValue?.mode = mode
        newValue?.lastUpdate = lastUpdate

        do {
            try managedObjectContext.save()
            contentFromCoreData.accept(fetchData())
        } catch {
            fatalError("error saving data")
        }
    }
    public func updateDate(with date: Date, in index: Int) {
        contentFromCoreData.value[index].lastUpdate = date

        do {
            try managedObjectContext.save()
            contentFromCoreData.accept(fetchData())
        } catch {
            fatalError("error change data")
        }
    }
    override func customfetchRequest() -> NSFetchRequest<MLSearchObject> {
        let request = NSFetchRequest<MLSearchObject>(entityName: "\(MLSearchObject.self)")
        request.sortDescriptors = [NSSortDescriptor(key: "lastUpdate", ascending: false)]
        if filter.count > 1 {
            request.predicate = NSPredicate(format: "text CONTAINS[c] %@", argumentArray: [filter])

        }
        return request
    }
}
