//
//  TableViewControllerD.swift
//  14.3
//
//  Created by Satyavrata on 15.04.2022.
//

import UIKit
import Alamofire
import RealmSwift


class TableViewControllerD: UITableViewController {
    
    let realm = try! Realm()
    var items: Results<DataRealm>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.items = realm.objects(DataRealm.self)
    }
        
    
    
    
    func loadCategories(person: String){
        AF.request("https://rickandmortyapi.com/api/character/" + person).responseDecodable(of:Category.self ) { response in
            
            if let data = response.value{
                // передача данных в базу
                let dat = DataRealm()
                dat.name = data.name
                dat.gender = data.gender
                dat.location = data.location.name
                dat.status = data.status
                dat.image = data.image
                
                try! self.realm.write({
                    self.realm.add(dat)
                })
                self.tableView.reloadData()
            } else { print("error")}
        }
    }
    
    @IBAction func addPerson(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "Добавить персонажа", message: "Введите число", preferredStyle: .alert)
        let saveTask = UIAlertAction(title: "Сохранить", style: .default) { ACTION in
            let tf = alertController.textFields?.first
            if let newTask = tf?.text {
                self.loadCategories(person: newTask)
                self.tableView.reloadData()
            }
        }
        alertController.addTextField { _ in }
        let cancelAction = UIAlertAction(title: "Отмена", style: .default) { _ in }
        alertController.addAction(saveTask)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
        
    }
    func getImage(url: String) {
        AF.download(url).responseData {(response) in
            if let data = response.value {
                _ = UIImage(data: data)
            }
        }
    }
    
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CategoryCell
        let item = items[indexPath.row]
        cell.labelName.text = item.name
        cell.labelHuman.text = item.status + "  -  " + item.gender
        cell.labelLocation.text = item.location
        //получение изображения
        AF.download(item.image).responseData {(response) in
            if let data = response.value {
                let imageData = UIImage(data: data)
                cell.viewImage.image = imageData
            }
        }

        return cell
    }
    

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            let editingRow = items[indexPath.row]
            try! self.realm.write({
                self.realm.delete(editingRow)
            })
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0;//Choose your custom row height
    }

}
