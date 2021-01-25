//
//  UITableBibliaViewController.swift
//  TempoComDeusApp
//
//  Created by Lidiane Gomes Barbosa on 07/09/20.
//  Copyright © 2020 Lidiane Gomes Barbosa. All rights reserved.
//

import UIKit

extension BibliaViewController: UITableViewDelegate, UITableViewDataSource {
    
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
        tableView.register(BibliaTableViewCell.self, forCellReuseIdentifier: cellId)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if chapter < livroAtual?.chapters.count ?? 0 {
            return livroAtual?.chapters[chapter].count ?? 0
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard  let myCell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as?
            BibliaTableViewCell else { return UITableViewCell() }
        
        let num = "\(indexPath.row + 1)"
        let verso =  "\(livroAtual?.chapters[chapter ][indexPath.row] ?? "")"
        
        myCell.createCell(num: num, verso: verso)
        return myCell
    }
}

extension BibliaViewController: LivrosTableViewDelegate {
    func didSelectSection(abbr: String, chapter: Int) {
        self.chapter = chapter
        self.abbrev = abbr
        livroAtual = getLivroAtual(abreviacao: abbr)
        tableView.scrollToRow(at: IndexPath.init(row: 0, section: 0), at: .top, animated: true)
    }
}
