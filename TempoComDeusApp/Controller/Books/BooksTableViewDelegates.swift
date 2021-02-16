//
//  BooksTableViewDelegates.swift
//  TempoComDeusApp
//
//  Created by Lidiane Gomes Barbosa on 06/01/21.
//  Copyright © 2021 Lidiane Gomes Barbosa. All rights reserved.

import Foundation
import UIKit

extension BooksTableViewController: UITableViewDelegate, UITableViewDataSource {
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
                BooksTableViewSections else { return UITableViewCell()}
            cell.textLabel?.text = tableData[indexPath.section].name
            cell.didSelected(isSelected: tableData[indexPath.section].opened ?? false)
            cell.createCell()
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId)  as?
                ChaptersTableViewCell else { return UITableViewCell()}
            
            cell.onDidTap = { chapter in
                self.didTap(chapter: chapter)
            }
            
            cell.createCell(items: tableData[indexPath.section].totalChapters ?? 0)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableData[indexPath.section].opened == true {
            tableData[indexPath.section].opened = false
            let sections = IndexSet.init(integer: indexPath.section)
            tableView.beginUpdates()
            tableView.reloadSections(sections, with: .fade)
            tableView.endUpdates()
        } else {
                tableData[indexPath.section].opened = true
            let sections = IndexSet.init(integer: indexPath.section)
            tableView.beginUpdates()
            tableView.reloadSections(sections, with: .fade)
            tableView.endUpdates()
            
        }
        self.abbreviation = tableData[indexPath.section].abbreviation["pt"]
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 44
        } else {
            let items = Double(tableData[indexPath.section].totalChapters ?? 0)
            return CGFloat(Calculator.calculeBooksTableViewCellHeight(totalItems: items))
        }
    }
}
