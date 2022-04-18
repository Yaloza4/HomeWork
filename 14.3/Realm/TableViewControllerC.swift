

import UIKit
import RealmSwift

class TableViewControllerC: UITableViewController {
    
    let realm = try! Realm()
    var items: Results<TaskList>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.items = realm.objects(TaskList.self)
    }
    
    @IBAction func addButton(_ sender: UIBarButtonItem) {
        self.alert()
    }
    
    func alert() {
        let alertController = UIAlertController(title: "New task", message: "Please fill in the field", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default) { (ok) in
        let text = alertController.textFields?.first
            let task = TaskList()
            task.task = (text?.text)!
            try! self.realm.write({
                self.realm.add(task)
            })
            //self.items.append((text?.text)!)
            self.tableView.reloadData()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        alertController.addTextField { (textField) in
        }
        alertController.addAction(ok)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let item = items[indexPath.row]
        cell.textLabel?.text = item.task
        return cell

    }
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
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

    
}
