//
//  SearchControllerBooksTableView.swift
//  TempoComDeusApp
//
//  Created by Lidiane Gomes Barbosa on 16/02/21.
//  Copyright © 2021 Lidiane Gomes Barbosa. All rights reserved.
//

import UIKit
extension BooksTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            tableData = data.allBooks
        } else {
            tableData = data.getFilteredBook(string: searchText)
        }
        self.tableView.reloadData()
      
    }
    
}
