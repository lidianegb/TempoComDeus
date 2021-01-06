//
//  LivrosTableViewDelegates.swift
//  TempoComDeusApp
//
//  Created by Lidiane Gomes Barbosa on 06/01/21.
//  Copyright © 2021 Lidiane Gomes Barbosa. All rights reserved.
//

import Foundation
import UIKit

extension LivrosTableViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        tableData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableData[section].opened == true {
            return 2 } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellSection) as?
                LivrosTableViewSections else { return UITableViewCell()}
            cell.textLabel?.text = tableData[indexPath.section].name
            cell.didSelected(isSelected: tableData[indexPath.section].opened ?? false)
            cell.createCell()
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId)  as?
                CapitulosTableViewCell else { return UITableViewCell()}
            cell.delegate = self
            cell.createCell(items: tableData[indexPath.section].chapters ?? 0)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableData[indexPath.section].opened == true {
            tableData[indexPath.section].opened = false
            let sections = IndexSet.init(integer: indexPath.section)
            tableView.reloadSections(sections, with: .none) } else {
            tableData[indexPath.section].opened = true
            let sections = IndexSet.init(integer: indexPath.section)
            tableView.reloadSections(sections, with: .none)
            
        }
        self.abbr = tableData[indexPath.section].abbrev["pt"]
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 44
        } else {
            let items = Double(tableData[indexPath.section].chapters ?? 0)
            return calculaHeight(qtdItems: items)
        }
    }
    
    func calculaHeight(qtdItems: Double) -> CGFloat {
        let heigth = ceil(qtdItems / 7.0)
        return CGFloat( heigth == 1 ? 70 : heigth * 50 + 20 )
    }
}
