//
//  AddEtudiantViewController.swift
//  GestionEtudiant
//
//  Created by Macbook on 8/29/20.
//  Copyright © 2020 MacOthmane. All rights reserved.
//

import UIKit

class AddEtudiantViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    var indiceUpdate : Int?
    @IBOutlet weak var datePickerView: UIDatePicker!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ParcourirBtn: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var text: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        if indiceUpdate != nil {
            print(indiceUpdate)
            print(indiceUpdate)
            print(indiceUpdate)
            print(indiceUpdate)
            datePickerView.date = listEtudiants[indiceUpdate!].date ??  Date()
            nameTextField.text = listEtudiants[indiceUpdate!].name
            photoImageView.image = UIImage(data :listEtudiants[indiceUpdate!].image ?? Data())
        }

        // Do any additional setup after loading the view.
    }
    @IBAction func chooseImage(_ sender: Any) {
            let pki = UIImagePickerController()
             pki.delegate = self
            let actionSheet = UIAlertController(title: "Image Etudiant", message: "choisir photo", preferredStyle: .actionSheet)
            actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: {(action : UIAlertAction) in
                if UIImagePickerController.isSourceTypeAvailable(.camera){
                    pki.sourceType = .camera
                    self.present(pki,animated: true)
                }
                else{
                    self.alert(message: "NO CAMERA")
                }
                
            }))
            actionSheet.addAction(UIAlertAction(title: "Library", style: .default, handler: {(action : UIAlertAction) in
                pki.sourceType = .photoLibrary
                self.present(pki,animated: true)
            }))
            actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:  nil))
            self.present(actionSheet,animated: true)
            print("testtest")
            
           
    //        pki.sourceType = .photoLibrary
    //        present(pki,animated: true)
            
        }
    @IBAction func chargerImage(_ sender: Any) {
        let pki = UIImagePickerController()
         pki.delegate = self
        let actionSheet = UIAlertController(title: "Image Etudiant", message: "choisir photo", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: {(action : UIAlertAction) in
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                pki.sourceType = .camera
                self.present(pki,animated: true)
            }
            else{
                self.alert(message: "NO CAMERA")
            }
            
        }))
        actionSheet.addAction(UIAlertAction(title: "Library", style: .default, handler: {(action : UIAlertAction) in
            pki.sourceType = .photoLibrary
            self.present(pki,animated: true)
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:  nil))
        self.present(actionSheet,animated: true)
        print("testtest")
        
       
//        pki.sourceType = .photoLibrary
//        present(pki,animated: true)
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        photoImageView.image = (info[UIImagePickerController.InfoKey.originalImage] as! UIImage)
//        ParcourirBtn.isHidden=true
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    @IBAction func save() {
//        guard let content = nameTextField.text,let img = (photoImageView.image ?? nil)?.pngData(),datePickerView.date==nil else {
//            alert(message :"Ajoute non éffectué")
//                            return
//                   }
       if(indiceUpdate==nil){
        print(indiceUpdate)
        print(indiceUpdate)
        print(indiceUpdate)
        print(indiceUpdate)
        let etd = Etudiant(context: AppDelegate.viewContext)
        etd.name = nameTextField.text
        etd.image = (photoImageView.image ?? nil)?.pngData()
        etd.date=datePickerView.date
        currentId = currentId+1
        etd.id = Int16(currentId)
        if(etd.date == nil || etd.name == "" || etd.image == nil)
        {       AppDelegate.viewContext.delete(etd)
                alert(message: "donne incolete")
            }else{
            do{
                try AppDelegate.viewContext.save()
                navigationController?.popViewController(animated: true)
                }
        catch{
            alert(message: "Etudiant non ajouter")
            
            }
                alert(message: "Etudiant bien ajoute")
            }
        }
        else{
        print(indiceUpdate)
        print(indiceUpdate)
        print(indiceUpdate)
        print(indiceUpdate)
        listEtudiants[indiceUpdate!].date = datePickerView.date
        listEtudiants[indiceUpdate!].name = nameTextField.text
        listEtudiants[indiceUpdate!].image = (photoImageView.image ?? nil)?.pngData()
             do
             {
                 try AppDelegate.viewContext.save()
                navigationController?.popViewController(animated: true)
            }
                   catch{
                alert(message: "Mis a jor non effectuer")
                          }
                   alert(message: "Etudiant Mis a jour")
        }
    }
    func alert(message: String){
            
            let alert = UIAlertController(title: "Info", message: message, preferredStyle: .alert)
            let subButton = UIAlertAction(title: "OK", style: .default, handler: self.hdlr)
            alert.addAction(subButton)
            self.present(alert, animated: true, completion: nil)
        }
     func hdlr(alert: UIAlertAction){
     }
    
}
