//
//  TodoDataAccessProvider.swift
//  MercadolibreSearch
//
//  Created by Roberto Parra Castillo on 01-05-21.
//

import Foundation
import CoreData
import RxSwift
import RxCocoa

class DataAccessProvider<T: NSManagedObject> {

    internal var contentFromCoreData = BehaviorRelay<[T]>(value: [])
    internal var managedObjectContext: NSManagedObjectContext

    init() {
        // swiftlint:disable:next force_cast
        let delegate = UIApplication.shared.delegate as! AppDelegate
        contentFromCoreData.accept([])
        managedObjectContext = delegate.persistentContainer.viewContext

        contentFromCoreData.accept(fetchData())
    }

    internal func fetchData() -> [T] {
        let customFetchRequest = customfetchRequest()
        customFetchRequest.returnsObjectsAsFaults = false

        do {
            return try managedObjectContext.fetch(customFetchRequest)
        } catch {
            return []
        }
    }

    public func fetchObservableData() -> Observable<[T]> {
        contentFromCoreData.accept(fetchData())
        return contentFromCoreData.asObservable()
    }

    public func add(values: [String: Any]) {
        let newValue = NSEntityDescription.insertNewObject(
            forEntityName: "\(T.self)",
            into: managedObjectContext
        ) as! T
        // swiftlint:disable:previous force_cast
        newValue.loadWith(dictionary: values)

        do {
            try managedObjectContext.save()
            contentFromCoreData.accept(fetchData())
        } catch {
            fatalError("error saving data")
        }
    }

    public func removeValue(withIndex index: Int) {
        managedObjectContext.delete(contentFromCoreData.value[index])

        do {
            try managedObjectContext.save()
            contentFromCoreData.accept(fetchData())
        } catch {
            fatalError("error delete data")
        }
    }
    public func removeAll() {
        for item in contentFromCoreData.value {
            managedObjectContext.delete(item)
        }

        do {
            try managedObjectContext.save()
            contentFromCoreData.accept(fetchData())
        } catch {
            fatalError("error delete data")
        }
    }
    func customfetchRequest() -> NSFetchRequest<T> {
        return NSFetchRequest<T>(entityName: "\(T.self)")
    }
    func updateData() {
        contentFromCoreData.accept(fetchData())
    }
}
