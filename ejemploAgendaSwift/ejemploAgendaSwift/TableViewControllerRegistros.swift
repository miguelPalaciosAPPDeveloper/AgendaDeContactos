//
//  TableViewControllerRegistros.swift
//  ejemploAgendaSwift
//
//  Created by Miguel Palacios on 28/11/15.
//  Copyright © 2015 Miguel Palacios. All rights reserved.
//

import UIKit
import CoreData

class TableViewControllerRegistros: UITableViewController {
    
    var datosDeConsulta:Array<AnyObject> = []
    var indice:Int = 0
    let pantallaDetalles = "detalleContacto"
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        //Declarar una constante de  mi clase APPDELEGATE
        let appdel:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        //Declarar una constante de mi MANAGED OBJECT CONTEXT
        let managedObjectContext:NSManagedObjectContext = appdel.managedObjectContext
        
        //Delacarar una constante de la clase NSFETCHREQUEST, de consulta de datos
        let frequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Persona")
        
        //Cargar en mi matriz y hacer la consultat
        do{
            datosDeConsulta = try managedObjectContext.fetch(frequest)
            //Recargar mi tabla
            tableView.reloadData()
        }catch let error as NSError{
            print("Fetch failed: \(error.localizedDescription)")
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return datosDeConsulta.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        // Almacena las consultas
        let datos:NSManagedObject = datosDeConsulta[indexPath.row] as! NSManagedObject
        
        //Strings que almacenas el contacto
        let nombre = datos.value(forKey: "nombre") as! String
        let apellidos = datos.value(forKey: "apellidos") as! String
        
        cell.textLabel?.text = "\(nombre), \(apellidos)"
        cell.detailTextLabel?.text = datos.value(forKey: "direccion") as? String

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        indice = indexPath.row
        
        self.performSegue(withIdentifier: pantallaDetalles, sender: indice)
        
    }

    override func tableView(_ tableView: UITableView?, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        let appdel:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedObjectContext:NSManagedObjectContext = appdel.managedObjectContext
        
        if editingStyle == UITableViewCellEditingStyle.delete {
            if let tableV = tableView{
                managedObjectContext.delete(datosDeConsulta[indexPath.row] as! NSManagedObject)
                datosDeConsulta.remove(at: indexPath.row)
                
                tableV.deleteRows(at: [indexPath], with: UITableViewRowAnimation.fade)
            }
            
            do{
                try managedObjectContext.save()
            }catch let error as NSError{
                print("Fetch failed: \(error.localizedDescription)")
                abort()
            }
        }
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == pantallaDetalles{
            let seleccion = sender as! Int
            //Se crea una constante para albergar los datos de la consulta seleccionada
            let selectItem:NSManagedObject = datosDeConsulta[seleccion] as! NSManagedObject
            
            //Se crea un instancia de la vista a donde se mandaran los datos
            let vistaDetalle: ViewControllerDetalle = segue.destination as! ViewControllerDetalle
            
            //Se toman lo textFiled y se mandan los datos de las consultas segun sus llaves
            vistaDetalle.nombre = selectItem.value(forKey: "nombre") as! String
            vistaDetalle.apellido = selectItem.value(forKey: "apellidos") as! String
            vistaDetalle.edad = selectItem.value(forKey: "edad") as! String
            vistaDetalle.telefono = selectItem.value(forKey: "telefono") as! String
            vistaDetalle.direccion = selectItem.value(forKey: "direccion") as! String
            vistaDetalle.codigoPostal = selectItem.value(forKey: "codigoPostal") as! String
            vistaDetalle.ciudad = selectItem.value(forKey: "ciudad") as! String
            
            vistaDetalle.existePersona = selectItem
            
        }
    }

}

