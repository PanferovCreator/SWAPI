//
//  ViewController.swift
//  SWAPI
//
//  Created by Dmitriy Panferov on 05/07/23.
//

import UIKit

class CharacterListViewController: UITableViewController {
    
    private var swapi: Characters?
    private var nextPage: String?
    private let cellID = "character"
    private let networkManager = NetworkManager.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView(cellID: cellID)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "character", for: indexPath)
        var content = cell.defaultContentConfiguration()
        let character = swapi?.results[indexPath.row]
        content.text = character?.name
        content.secondaryText = character?.gender
        content.image = UIImage(named: character?.name ?? "")
        content.imageProperties.cornerRadius = tableView.rowHeight / 2
        cell.contentConfiguration = content
    
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let character = swapi?.results[indexPath.row]
        let detailVC = CharacterDetailViewController()
        let navVC = UINavigationController(rootViewController: detailVC)
        navVC.modalPresentationStyle = .fullScreen
        detailVC.character = character
        detailVC.navigationItem.backBarButtonItem?.title = "Back"
        present(navVC, animated: true)
    }
}
// MARK: - Extensions
// Fetch Data
extension CharacterListViewController {
    private func fetchData() {
        networkManager.fetchData(Characters.self, from: Link.characters.url) { [weak self] result in
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
        networkManager.fetchPage(Characters.self, from: nextPage) { [weak self] result in
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
// Setup TableView
extension UITableViewController {
    func setupTableView(cellID: String) {
        tableView.separatorColor = .systemYellow
        tableView.rowHeight = 80
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
    }
}

