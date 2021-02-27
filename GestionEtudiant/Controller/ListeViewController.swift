//
//  ListeViewController.swift
//  GestionEtudiant
//
//  Created by Macbook on 8/29/20.
//  Copyright © 2020 MacOthmane. All rights reserved.
//

import UIKit
import CoreData
var listEtudiants = [Etudiant]()
var currentId: Int=0
class ListeViewController: UIViewController, UITableViewDelegate {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
//        override func viewDidLoad() {
//                super.viewDidLoad()
//                NotificationCenter.default.addObserver(self, selector: #selector(self.refresh), name: NSNotification.Name(rawValue: "newDataNotif"), object: nil)
//                //ajjouterEtudiant()
////                chargerEtudiants()
////                tableView.reloadData()
//        //        currentid = listEtudiant.count
//                
////                tableView.delegate=self
////                tableView.dataSource = self
//                // Do any additional setup after loading the view.
//            }
    override func viewWillAppear(_ animated: Bool) {
        chargerEtudiants()
        tableView.reloadData()
        searchBar.delegate = self
    }
}


extension ListeViewController : UITableViewDataSource,UISearchBarDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        listEtudiants.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "etudiantCell", for: indexPath) as! etudiantCell
        let etudiant = listEtudiants[indexPath.row]
        cell.nom.text = etudiant.name
        cell.photo.image = UIImage(data : etudiant.image ?? Data())
        cell.date.text = "Date de naissance : " +  etudiant.date!.debugDescription.prefix(10)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "SegueUpdateEtudiant", sender: indexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SegueUpdateEtudiant"{
            print("dayzaaa 3wachar")
            let UpdateVC = segue.destination as! AddEtudiantViewController
            UpdateVC.indiceUpdate = tableView.indexPathForSelectedRow?.row
        }
    }
   
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            AppDelegate.viewContext.delete(listEtudiants[indexPath.row])
            listEtudiants.remove(at: indexPath.row)
            do{
                try AppDelegate.viewContext.save()
            }catch{
                alert(message: "Etudiant non suprimer")
            }
            alert(message: "Etudiant suprimer")
            tableView.reloadData()
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
    func chargerEtudiants(){
               let request: NSFetchRequest<Etudiant> = Etudiant.fetchRequest()
               do{
                listEtudiants = try AppDelegate.viewContext.fetch(request)
               }catch{
                   print("error loading content \(error)")
               }
               print("successfully charged")
           }
         @objc func refresh() {
            chargerEtudiants()
            self.tableView.reloadData() // a refresh the tableView.

        }
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            if(searchText != ""){
                var predicate: NSPredicate = NSPredicate()
                predicate = NSPredicate(format: "name contains[c] '\(searchText)'")
                let request = NSFetchRequest<Etudiant>(entityName: "Etudiant")
                request.predicate = predicate
                do{
                    listEtudiants = try AppDelegate.viewContext.fetch(request)
                    print(listEtudiants)
                }catch{
                }
                tableView.reloadData()
            }else{
                chargerEtudiants()
                tableView.reloadData()
            }
        }
}




















//import UIKit
//import CoreData
//var currentId: Int=0
//class ListeViewController: UIViewController {
//    
//    @IBOutlet weak var tableView: UITableView!
//    var etudiants = Etudiant.all
//    
//    override func viewWillAppear(_ animated: Bool) {
//        etudiants = Etudiant.all
//        tableView.reloadData()
//        
//    }
//}
//
//
//extension ListeViewController : UITableViewDataSource{
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        Etudiant.all.count
//    }
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "etudiantCell", for: indexPath) as! etudiantCell
//        let etudiant = Etudiant.all[indexPath.row]
//        cell.nom.text = etudiant.name
//        cell.photo.image = UIImage(data : etudiant.image ?? Data())
//        cell.date.text = "Date de naissance : " +  etudiant.date!.debugDescription.prefix(10)
//        return cell
//    }
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        performSegue(withIdentifier: "SegueUpdateEtudiant", sender: indexPath.row)
//    }
//    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "SegueUpdateEtudiant"{
//            print("dayzaaa 3wachar")
//            let UpdateVC = segue.destination as! AddEtudiantViewController
//            UpdateVC.indiceUpdate = tableView.indexPathForSelectedRow?.row
//        }
//    }
//   
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == UITableViewCell.EditingStyle.delete {
//            AppDelegate.viewContext.delete(etudiants[indexPath.row])
//            etudiants.remove(at: indexPath.row)
//            do{
//                try AppDelegate.viewContext.save()
//            }catch{
//                alert(message: "Etudiant non suprimer")
//            }
//            alert(message: "Etudiant suprimer")
//            tableView.reloadData()
//        }
//    }
//    func alert(message: String){
//           
//           let alert = UIAlertController(title: "Info", message: message, preferredStyle: .alert)
//           let subButton = UIAlertAction(title: "OK", style: .default, handler: self.hdlr)
//           alert.addAction(subButton)
//           self.present(alert, animated: true, completion: nil)
//       }
//    func hdlr(alert: UIAlertAction){
//    }
//}
