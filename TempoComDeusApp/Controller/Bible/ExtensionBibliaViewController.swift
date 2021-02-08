//
//  UITableBibliaViewController.swift
//  TempoComDeusApp
//
//  Created by Lidiane Gomes Barbosa on 07/09/20.
//  Copyright © 2020 Lidiane Gomes Barbosa. All rights reserved.

import UIKit

extension BibleViewController: UITableViewDelegate, UITableViewDataSource {
    
    func setupTableView() {
        view.insertSubview(tableView, at: 0)
        tableView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                         left: view.leftAnchor,
                         bottom: view.safeAreaLayoutGuide.bottomAnchor,
                         right: view.rightAnchor,
                         paddingTop: 0,
                         paddingLeft: 8,
                         paddingBottom: 0,
                         paddingRight: 8)
        tableView.register(BibleTableViewCell.self, forCellReuseIdentifier: cellId)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        actualChapter?.totalVerses ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard  let myCell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as?
                BibleTableViewCell else { return UITableViewCell() }
            myCell.createCell(actualVerse: verses[indexPath.row])
        return myCell
    }
}
