//
//  SearchGithubRepositoryViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/20.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

final class SearchGithubRepositoryViewController: UITableViewController {
    private var presenter: SearchGithubRepositoryPresenterInput?
    @IBOutlet private weak var searchBar: UISearchBar!

    func inject(presenter: SearchGithubRepositoryPresenterInput) {
        self.presenter = presenter
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        searchBar.text = "GitHubのリポジトリを検索できるよー"
        searchBar.delegate = self
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.viewState?.cells.count ?? .zero
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        guard let cellViewState = presenter?.viewState?.cells[indexPath.row] else {
            return cell
        }
        cell.textLabel?.text = cellViewState.fullName
        cell.detailTextLabel?.text = cellViewState.language
        cell.tag = indexPath.row
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelectRepository(row: indexPath.row)
    }
}

// MARK: - UISearchBarDelegate
extension SearchGithubRepositoryViewController: UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        // ↓こうすれば初期のテキストを消せる
        searchBar.text = ""
        return true
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter?.searchTextDidChange()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        presenter?.searchGithubRepositries(word: searchBar.text)
    }
}

// MARK: - SearchGithubRepositoryPresenterOutput
extension SearchGithubRepositoryViewController: SearchGithubRepositoryPresenterOutput {
    func didSearchGithubRepositories() {
        tableView.reloadData()
    }
}
