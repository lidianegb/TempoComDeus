//
//  BibliaPageViewController.swift
//  TempoComDeusApp
//
//  Created by Lidiane Gomes Barbosa on 15/09/20.
//  Copyright © 2020 Lidiane Gomes Barbosa. All rights reserved.
//

import UIKit

class BibliaPageViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    var myViewController = BibliaViewController()
     var paginationCV: UICollectionView?
     var currentPage = 0
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        leftSwipe()
        print(abbrev)
        print(chapter)
        
        return myViewController
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        rightSwipe()
        print(abbrev)
        print(chapter)
        return myViewController
    }
    
    let biblia = File().readBiblia()
    var allLivros: [Livro] = []
    var version: String = NVI
    var abbrev: String = "gn"
    var chapter: Int = 0
    
    var livroAtual: Livro?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        self.delegate = self
      
        allLivros = File().readBibleByVersion(version: version)
        livroAtual = getLivroAtual(abreviacao: abbrev)
    }
    func getLivroAtual(abreviacao: String) -> Livro? {
        allLivros.filter {$0.abbrev == abreviacao}.first ?? nil
    }
    
    func rightSwipe() {
        for (ind, book) in biblia.enumerated() where abbrev == book.abbrev["pt"] {
            if chapter <  (book.chapters ?? 0) - 1 {
                chapter += 1
                return
            } else if ind < (biblia.count - 1) {
                self.chapter = 0
                abbrev = allLivros[ind + 1].abbrev
                livroAtual = getLivroAtual(abreviacao: abbrev)
                return
            }
        }
    }
    
    func leftSwipe() {
        for (ind, book) in biblia.enumerated() where abbrev == book.abbrev["pt"] {
            if chapter > 0 {
                chapter -= 1
                return
            } else if ind > 0 {
                abbrev = allLivros[ind - 1].abbrev
                livroAtual = getLivroAtual(abreviacao: abbrev)
                chapter = (livroAtual?.chapters.count ?? 0) - 1
                return
            }
        }
    }
}
