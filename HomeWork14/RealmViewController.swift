//
//  RealmViewController.swift
//  HomeWork14
//
//  Created by Albert on 13.08.2020.
//  Copyright © 2020 Albert. All rights reserved.
//

import UIKit

class RealmViewController: UIViewController, UITableViewDataSource{
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var removeBtn: UIBarButtonItem!
    
    private let todoList=TodoList()//класс, где будут хранится все дела
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        todoList.ReadFromRealm()
        updateRemoveBtn()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)//вид исчезает - сохраним значения
        todoList.SaveToRealm()
    }
    
    @IBAction func addPressed(_ sender: Any) {
        let alert = UIAlertController(title: "New what to do",
        message: "Add a new to do text", preferredStyle: .alert)

        alert.addTextField {
           (textField: UITextField!) -> Void in
        }
        
        let picker = UIDatePicker()
        picker.translatesAutoresizingMaskIntoConstraints = false
        alert.view.addSubview(picker)
        alert.view.heightAnchor.constraint(equalToConstant: 350).isActive = true
        picker.leadingAnchor.constraint(equalTo: alert.view.leadingAnchor).isActive = true
        picker.trailingAnchor.constraint(equalTo: alert.view.trailingAnchor).isActive = true
        picker.topAnchor.constraint(equalTo: alert.view.topAnchor, constant: 100).isActive = true
       
        
        let saveAction = UIAlertAction(title: "Save", style: .default) {
            (action: UIAlertAction!) -> Void in
            let textField = alert.textFields![0]
            self.todoList.addTodo(Todo(what: textField.text!, when: picker.date))
            self.tableView.reloadData()
        }
               
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) {
           (action: UIAlertAction!) -> Void in
        }
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }

    
    @IBAction func removePressed(_ sender: Any) {
        let selected=tableView.indexPathForSelectedRow
        if selected != nil {//удаляем ячейку
//            selected?.first as! Int
            todoList.removeTodAt((selected?.first ?? -1))
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.todoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell") as! TodoTableViewCell
        
        let todo=self.todoList.getTodoAt(indexPath.row)
        if todo != nil {
            cell.whatLabel!.text = todo!.whatTodo
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM-dd-yyyy HH:mm:SS"
            cell.whenLabel!.text = dateFormatter.string(from: todo!.whenTodo)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        updateRemoveBtn()
    }
    
    func updateRemoveBtn(){
        let selected=tableView.indexPathForSelectedRow
        removeBtn.isEnabled = (selected != nil)        
    }
}
