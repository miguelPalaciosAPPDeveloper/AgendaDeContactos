//
//  Persona+CoreDataProperties.swift
//  ejemploAgendaSwift
//
//  Created by Miguel Palacios on 28/11/15.
//  Copyright © 2015 Miguel Palacios. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Persona {

    @NSManaged var nombre: String?
    @NSManaged var apellidos: String?
    @NSManaged var edad: String?
    @NSManaged var direccion: String?
    @NSManaged var codigoPostal: String?
    @NSManaged var telefono: String?
    @NSManaged var ciudad: String?

}
