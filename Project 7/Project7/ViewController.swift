//
//  ViewController.swift
//  Project7
//
//  Created by Alexander Thompson on 23/1/21.
//

import UIKit

class ViewController: UITableViewController {
    
    var petitions = [Petition]()
    var filteredPetitions = [Petition]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Credits", style: .plain, target: self, action: #selector(creditAlert))
       let filterButton = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(filterPressed))
        let clearButton = UIBarButtonItem(title: "Clear Filter", style: .plain, target: self, action: #selector(clearFilter))
        navigationItem.leftBarButtonItems = [filterButton, clearButton]
        
       parseData()
    }
    // created this func to call again when clearing filtered data
    func parseData() {
        
        let urlString: String
        if navigationController?.tabBarItem.tag == 0 {
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        } else {
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }
        
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                parse(json: data)
            return
            }
            showError()
    }
    }
    
    
    @objc func clearFilter() {
        petitions = [Petition]()
        parseData()
        tableView.reloadData()
    }
    
    @objc func creditAlert() {
        let ac = UIAlertController(title: nil, message: "The data in this app comes from the We The People API of the Whitehouse", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        present(ac, animated: true)
    }
    
    func search(_ searchItem: String) {
        filteredPetitions.removeAll(keepingCapacity: true)
       
        for i in petitions {
            if i.title.lowercased().contains(searchItem) {
                filteredPetitions.append(i)
                petitions = filteredPetitions
                tableView.reloadData()
            }
        }
    }
    
    @objc func filterPressed() {
        let ac = UIAlertController(title: "Filter Petitions", message: "Enter a keyword to search through petitions", preferredStyle: .alert)
        ac.addTextField()
        ac.addAction(UIAlertAction(title: "Search", style: .default, handler: { [weak self, weak ac] action in
            guard let result = ac?.textFields?[0].text else { return }
            self?.search(result)
        }))
        
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(ac, animated: true)
    }
    func parse(json: Data) {
        let decoder = JSONDecoder()
        
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitions.results
            tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let petition = petitions[indexPath.row]
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = petitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func showError() {
        let ac = UIAlertController(title: "Loading Error", message: "There was a problem loading the feed; please check yuour connection and try again.", preferredStyle: .alert)
        present(ac, animated: true)
    }
}

