//
//  DataPersistenceManager.swift
//  VerrazzanoCapstoneProject
//
//  Created by Joseph  DeMario on 3/4/22.
//

import Foundation
import UIKit
import CoreData

class DataPersistenceManager {
    
    enum DBError: Error {
        case failedToSaveData
        case failedToFetch
        case failedToDelete
    }
    static let shared = DataPersistenceManager()
    
    func favoriteTitleWith(model: Title, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        let item = TitleItem(context: context)
        
        item.original_title = model.original_title
        item.id = Int64(model.id)
        item.original_name = model.original_name
        item.overview = model.overview
        item.media_type = model.media_type
        item.poster_path = model.poster_path
        item.release_date = model.release_date
        item.vote_count = Int64(model.vote_count)
        item.vote_average = model.vote_average
        
        do {
            try context.save()
            completion(.success(()))
        } catch {
            completion(.failure(DBError.failedToSaveData))
        }
    }
    
    func fetchFromDatabase(completion: @escaping (Result<[TitleItem], Error>) -> Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        
        let request: NSFetchRequest<TitleItem>
        request = TitleItem.fetchRequest()
        
        do {
            let titles = try context.fetch(request)
            completion(.success(titles))
        } catch {
            completion(.failure(DBError.failedToFetch))
        }
    }
    
    func deleteFavorite(model: TitleItem, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        context.delete(model) //database deletes specified object
        
        do {
            try context.save()
            completion(.success(()))
        } catch {
            completion(.failure(DBError.failedToDelete))
        }
    }
}
