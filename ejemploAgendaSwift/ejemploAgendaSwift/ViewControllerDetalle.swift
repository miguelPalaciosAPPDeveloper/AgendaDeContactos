//
//  ViewControllerDetalle.swift
//  ejemploAgendaSwift
//
//  Created by Miguel Palacios on 28/11/15.
//  Copyright © 2015 Miguel Palacios. All rights reserved.
//

import UIKit
import CoreData

class ViewControllerDetalle: UIViewController, UITextFieldDelegate {
    
    //MARK: - Propiedades
    
    @IBOutlet weak var textFieldNombre: UITextField!
    @IBOutlet weak var textFieldApellido: UITextField!
    @IBOutlet weak var textFieldEdad: UITextField!
    @IBOutlet weak var textFieldTelefono: UITextField!
    @IBOutlet weak var textFieldDireccion: UITextField!
    @IBOutlet weak var textFieldCP: UITextField!
    @IBOutlet weak var textFieldCiudad: UITextField!
    
    var nombre: String = ""
    var apellido: String = ""
    var edad: String = ""
    var telefono: String = ""
    var direccion: String = ""
    var codigoPostal: String = ""
    var ciudad: String = ""
    var existePersona:NSManagedObject!

    override func viewDidLoad() {
        super.viewDidLoad()
        if existePersona != nil{
            textFieldNombre.text = nombre
            textFieldApellido.text = apellido
            textFieldEdad.text = edad
            textFieldTelefono.text = telefono
            textFieldDireccion.text = direccion
            textFieldCP.text = codigoPostal
            textFieldCiudad.text = ciudad
        }
    }
    
    //MARK: - Metodos propios
    
    @IBAction func modificarDatos(_ sender: UIBarButtonItem) {
        //1. Crear una instacia a la clase APPDELEGATE para gestionar COREDATA
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        //2. Crear una instacia al objeto MANAGED OBJECT CONTEXT
        let managedObjectContext:NSManagedObjectContext = appDelegate.managedObjectContext
        
        //3. Crear una instancia a la ENTITY de COREDATA
        //let _ = NSEntityDescription.entityForName("Persona", inManagedObjectContext: managedObjectContext)
        
        //4. mediante la condicion se pregunta si exite el registre si es verdadero sobre escribe los datos
        if existePersona != nil{
            existePersona.setValue(textFieldNombre.text, forKey: "nombre")
            existePersona.setValue(textFieldApellido.text, forKey: "apellidos")
            existePersona.setValue(textFieldEdad.text, forKey: "edad")
            existePersona.setValue(textFieldTelefono.text, forKey: "telefono")
            existePersona.setValue(textFieldDireccion.text, forKey: "direccion")
            existePersona.setValue(textFieldCP.text, forKey: "codigoPostal")
            existePersona.setValue(textFieldCiudad.text, forKey: "ciudad")
        }else{
            //4.1 Si no existe crea una instancia de la clase persona, asignamos una entidad y un contexto de objeto gestionado
            let nuevaPersona:Persona = NSEntityDescription.insertNewObject(forEntityName: "Persona", into: managedObjectContext) as! Persona
            nuevaPersona.nombre = textFieldNombre.text
            nuevaPersona.apellidos = textFieldApellido.text
            nuevaPersona.edad = textFieldEdad.text
            nuevaPersona.telefono = textFieldTelefono.text
            nuevaPersona.direccion = textFieldDireccion.text
            nuevaPersona.codigoPostal = textFieldCP.text
            nuevaPersona.ciudad = textFieldCiudad.text
        }
        //5. Guardar valores
        
        do{
            try managedObjectContext.save()
            navigationController?.popToRootViewController(animated: true)
        }catch let error as NSError{
            print("Fetch failed: \(error.localizedDescription)")
        }
    }

    @IBAction func cancelar(_ sender: UIBarButtonItem) {
        
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedObjectContext:NSManagedObjectContext = appDelegate.managedObjectContext
        let _ = NSEntityDescription.entity(forEntityName: "Persona", in: managedObjectContext)
        
        if existePersona != nil{
        managedObjectContext.delete(existePersona)
        if managedObjectContext.deletedObjects.contains(existePersona){
                print("borrado")
            navigationController?.popToRootViewController(animated: true)
        }else{
            print("no se borro")
            navigationController?.popToRootViewController(animated: true)
        }
         //navigationController?.popToRootViewControllerAnimated(true)
        }
        
        do{
            try managedObjectContext.save()
            navigationController?.popToRootViewController(animated: true)
        }catch let error as NSError{
            print("Fetch failed: \(error.localizedDescription)")
        }
    }
    
    //MARK: - Metodos delegados
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.isEqual(textFieldNombre){
            textFieldApellido.becomeFirstResponder()
        }
        else if textField.isEqual(textFieldApellido){
            textFieldEdad.becomeFirstResponder()
        }
        else if textField.isEqual(textFieldEdad){
            textFieldTelefono.becomeFirstResponder()
        }
        else if textField.isEqual(textFieldTelefono){
            textFieldDireccion.becomeFirstResponder()
        }
        else if textField.isEqual(textFieldDireccion){
            textFieldCP.becomeFirstResponder()
        }
        else if textField.isEqual(textFieldCP){
            textFieldCiudad.becomeFirstResponder()
        }
        else if textField.isEqual(textFieldCiudad){
            textFieldCiudad.resignFirstResponder()
        }
        
        return true
    }
}
