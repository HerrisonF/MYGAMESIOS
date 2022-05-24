//
//  ConsolesTableViewController.swift
//  MyGames
//
//  Created by Herrison Feres on 23/05/22.
//

import UIKit

class ConsolesTableViewController: UITableViewController {
    
    var consoleManager = ConsolesManager.shared


    @IBAction func addConsole(_ sender: UIBarButtonItem) {
        showAlert(with: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadConsoles()
    }

    func loadConsoles(){
        consoleManager.loadConsoles(with: context)
        tableView.reloadData()
    }
    
    func showAlert(with console: Console?){
        let title = console == nil ? "Adicionar" : "Editar"
        let alert = UIAlertController(title: title + " plataforma", message: nil, preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "Nome da plataforma"
            if let name = console?.name {
                textField.text = name
            }
        }
        alert.addAction(UIAlertAction(title: title, style: .default, handler: { action in
            let console = console ?? Console(context: self.context)
            console.name = alert.textFields?.first?.text
            do {
                try self.context.save()
                self.loadConsoles()
            }catch{
                print(error.localizedDescription)
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel))
        alert.view.tintColor = UIColor(named: "second")
        present(alert, animated: true)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return consoleManager.consoles.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let console = consoleManager.consoles[indexPath.row]
        showAlert(with: console)
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            consoleManager.deleteConsole(index: indexPath.row, context: context)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        let console = consoleManager.consoles[indexPath.row]

        cell.textLabel?.text = console.name
        return cell
    }

}