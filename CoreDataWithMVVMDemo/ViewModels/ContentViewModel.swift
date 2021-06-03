//
//  ContentViewModel.swift
//  CoreDataWithMVVMDemo
//
//  Created by Fred Javalera on 6/3/21.
//

import Foundation
import CoreData

class ContentViewModel: ObservableObject {
  
  // MARK: Properties
  let container: NSPersistentContainer
  @Published var savedEntities: [FruitEntity] = []
  
  // MARK: Init
  init() {
    container = NSPersistentContainer(name: "FruitsContainer")
    container.loadPersistentStores { description, error in
      if let error = error {
        print("ERROR LOADING CORE DATA. \(error)")
      }
    }
    fetchFruits()
  }
  
  // MARK: CRUD Operations
  func fetchFruits() {
    let request = NSFetchRequest<FruitEntity>(entityName: "FruitEntity")
    
    do {
      savedEntities = try container.viewContext.fetch(request)
    } catch let error {
      print("Error fetching. \(error)")
    }
  }
  
  func addFruit(text: String) {
    let newFruit = FruitEntity(context: container.viewContext)
    newFruit.name = text
    saveData()
  }
  
  func updateFruit(entity: FruitEntity) {
    let currentName = entity.name ?? ""
    let newName = currentName + "!"
    entity.name = newName
    saveData()
  }
  
  func deleteFruit(indexSet: IndexSet) {
    // indexSet may contain many indices, but we know it's only one, therefore, we call .first. Stores index.
    guard let index = indexSet.first else {return}
    // Gets entity at index.
    let entity = savedEntities[index]
    // Delete the entity swipped.
    container.viewContext.delete(entity)
    // Save the remaining entities in the list after the delete.
    saveData()
  }
  
  func saveData() {
    do {
      try container.viewContext.save()
      fetchFruits()
    } catch let error {
      print("Error saving. \(error)")
    }
  }
}
