//
//  <%= entity.name %>.swift
//  SightWords
//
//  Created by Johan Jordaan on 14/8/19.
//  Copyright © 2019 Johan Jordaan. All rights reserved.
//

import Foundation
import CoreData

class <%= entity.name %> {
    private static var cache:[<%= entity.name %>] = []
    private static var cacheLookup:[String:<%= entity.name %>] = [:]


    public static func GetAll(context:NSManagedObjectContext) throws -> [<%= entity.name %>] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "<%= entity.name %>")
        request.returnsObjectsAsFaults = false
        let items = try context.fetch(request)

        self.cache  = (items as! [NSManagedObject]).map {
            (item:NSManagedObject) -> <%= entity.name %> in
                return <%= entity.name %>(context:context,managedObject:item)
        }
        self.cacheLookup = Dictionary(uniqueKeysWithValues: self.cache.map { ($0.id,$0)})
        return self.cache
    }
    
    public static func DeleteAll(context:NSManagedObjectContext) throws {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "<%= entity.name %>")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
        try context.execute(deleteRequest)
    }

  
    public static func Create(context:NSManagedObjectContext,managedObject:NSManagedObject) -> <%= entity.name %> {
        guard let retVal = self.cacheLookup[managedObject.value(forKey: "id")  as! String] else {
            let newItem = <%= entity.name %>(context:context,managedObject:managedObject)
            cache.append(newItem)
            cacheLookup[newItem.id] = newItem
            return newItem
        }
        return retVal;
    }

    public static func Create(context:NSManagedObjectContext,<%= entity.fields.filter(i=>i.name!=='id').map(i=>`${i.name}:${i.type}`).join(',') %>) -> <%= entity.name %> {
        let newItem = <%= entity.name %>(context:context,<%= entity.fields.filter(i=>i.name!=='id').map(i=>`${i.name}:${i.name}`).join(',') %>)
        cache.append(newItem)
        cacheLookup[newItem.id] = newItem        
        return newItem
    }

    private var context:NSManagedObjectContext
    private var entityDescription:NSEntityDescription
    private var managedObject:NSManagedObject
    private init(context:NSManagedObjectContext,managedObject:NSManagedObject) {    
        self.context = context
        self.entityDescription = NSEntityDescription.entity(forEntityName: "<%= entity.name %>", in: self.context)!
        self.managedObject = managedObject
        <%_ entity.fields.forEach((a)=>{ -%>
            <%_ if(a.isrelstionship) { -%>
                <%_ if(a.hasMany) { -%>
        self.<%= a.name %> = (managedObject.value(forKey: "<%= a.name %>") as! [NSManagedObject]).map {
            (managedObject:NSManagedObject) -> <%= a.itemType %> in 
                return <%= a.itemType %>.Create(context:context,managedObject:managedObject)
        }
                <%_} else { -%>
        self.<%= a.name %> = <%= a.itemType %>.Create(context:context,managedObject:managedObject)
                <%_} -%>        
            <%_} else { -%>
        self.<%= a.name %> = managedObject.value(forKey: "<%= a.name %>")  as! <%= a.type %>
            <%_} -%>
        <%_ }) -%>
    }

    private init(context:NSManagedObjectContext,<%= entity.fields.filter(i=>i.name!=='id').map(i=>`${i.name}:${i.type}`).join(',') %>) {
        self.context = context
        self.entityDescription = NSEntityDescription.entity(forEntityName: "<%= entity.name %>", in: self.context)!
        self.id = NSUUID().uuidString
        <%_ entity.fields.filter(i=>i.name!=='id').forEach((p)=>{ -%>
        self.<%= p.name %> = <%= p.name %>
        <%_ }) -%>
    
        self.managedObject = NSManagedObject(entity: self.entityDescription, insertInto: self.context)
        <%_ entity.fields.forEach((a)=>{ -%>
        self.managedObject.setValue(self.<%= a.name %>, forKey: "<%= a.name %>")
        <%_ }) -%>
    }

    <%_ entity.fields.filter(i=>!i.isrelstionship&&!i.hasMany).forEach((p)=>{ -%>
    private var <%= p.name %>:<%= p.type %>
    public func set<%= p.pascalNname %>(<%= p.name %>:<%= p.type %>) throws {
      self.<%= p.name %> = <%= p.name %>
      self.managedObject.setValue(self.<%= p.name %>, forKey: "<%= p.name %>")
    }
    public func get<%= p.pascalName %>() -> <%= p.type %> {
      return self.<%= p.name %>
    }

    <%_ }) -%>


    <%_ entity.fields.filter(i=>i.isrelstionship&&!i.hasMany).forEach((p)=>{ -%>
    private var <%= p.name %>:<%= p.type %>
    public func set<%= p.pascalNname %>(<%= p.name %>:<%= p.type %>) throws {
      self.<%= p.name %> = <%= p.name %>
      self.managedObject.setValue(self.<%= p.name %>, forKey: "<%= p.name %>")
    }
    public func get<%= p.pascalName %>() -> <%= p.type %> {
      return self.<%= p.name %>
    }

    <%_ }) -%>

    <%_ entity.fields.filter(i=>i.isrelstionship&&i.hasMany).forEach((p)=>{ -%>
    private var <%= p.name %>:<%= p.type %>
    public func add<%= p.pascalNname %>(item:<%= p.itemType %>) throws {
      guard let _ = self.words.firstIndex(where :{
          (i:<%= p.itemType %>) -> Bool in
              return item.getId() == i.getId()
      }) else {
        self.<%= p.name %>.append(item)
        return
      }
    }
    public func remove<%= p.pascalNname %>(item:<%= p.itemType %>) throws {
        guard let foundIndex = self.words.firstIndex(where :{
            (i:<%= p.itemType %>) -> Bool in
                return item.getId() == i.getId()
        }) else {
            return
        }
        self.<%= p.name %>.remove(at: foundIndex)
    }
    public func get<%= p.pascalName %>() -> <%= p.type %> {
      return self.<%= p.name %>
    }

    <%_ }) -%>



    public func save() throws {
        try self.context.save()
    }
}