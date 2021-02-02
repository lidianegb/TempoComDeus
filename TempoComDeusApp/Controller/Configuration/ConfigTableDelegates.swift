//
//  ConfigTableDelegates.swift
//  TempoComDeusApp
//
//  Created by Lidiane Gomes Barbosa on 06/01/21.
//  Copyright © 2021 Lidiane Gomes Barbosa. All rights reserved.
//

import Foundation
import UIKit

extension ConfigViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: sectionOne, for: indexPath)
                as? ConfigSectionOneTableViewCell else { return UITableViewCell() }
            return cell
            
        }
        if indexPath.row == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: sectionTwo, for: indexPath)
                as? ConfigSectionTwoTableViewCell else { return UITableViewCell() }
            cell.setupFonteSize()
            return cell
        }
        
        let cell = UITableViewCell()
        cell.layer.cornerRadius = 8
        cell.layer.masksToBounds = true
        cell.backgroundColor = .backViewColor
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
      UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 50
        }
        if indexPath.row == 1 {
            return 100
        }
        
        return CGFloat(tableView.frame.height - 150)
    }
}
