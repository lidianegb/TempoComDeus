//
//  SearchControllerDelegates.swift
//  TempoComDeusApp
//
//  Created by Lidiane Gomes Barbosa on 16/02/21.
//  Copyright © 2021 Lidiane Gomes Barbosa. All rights reserved.
//

import UIKit
extension NotesViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchString = searchController.searchBar.text else { return }
        if searchString.isEmpty {
            notesViewModel.restartNotes()
        } else {
            textSearch = searchString
            notesViewModel.filterNotes(string: searchString)
        }

        collectionView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            searchActive = false
            notesViewModel.restartNotes()
            collectionView.reloadData()
        } else {
            searchActive = true
            textSearch = searchText
        }
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
        notesViewModel.restartNotes()
        collectionView.reloadData()
    }
}
