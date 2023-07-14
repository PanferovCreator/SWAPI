//
//  ShipsListViewController.swift
//  SWAPI
//
//  Created by Dmitriy Panferov on 10/07/23.
//

import UIKit

class ShipListViewController: UITableViewController {
    
    private var swapi: Ships?
    private var nextPage: String?
    private let cellID = "ship"
    private let networkManager = NetworkManager.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView(cellID: "ship")
        fetchData()
    }
    // MARK: - TableView DataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return swapi?.results.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let results = swapi?.results else { return }
        if results.count - indexPath.row == 1 {
            getNextPage(from: nextPage)
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ship", for: indexPath)
        var content = cell.defaultContentConfiguration()
        let ship = swapi?.results[indexPath.row]
        content.text = ship?.name
        content.secondaryText = ship?.manufacturer
        content.image = UIImage(named: ship?.name ?? "")
        content.imageProperties.cornerRadius = tableView.rowHeight / 2
        cell.contentConfiguration = content
    
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let ship = swapi?.results[indexPath.row]
        performSegue(withIdentifier: "showDetails", sender: ship)
    }
}
// MARK: - Extensions
// Fetch Data
extension ShipListViewController {
    private func fetchData() {
        networkManager.fetchData(Ships.self, from: Link.starships.url) { [weak self] result in
            switch result {
            case .success(let swapi):
                self?.swapi = swapi
                self?.nextPage = swapi.next
                self?.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }

    private func getNextPage(from url: String?) {
        networkManager.fetchPage(Ships.self, from: nextPage) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let swapi):
                self.swapi?.results.append(contentsOf: swapi.results)
                self.nextPage = swapi.next
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}


