//
//  BibliaViewController.swift
//  tempoComDeusApp
//
//  Created by Lidiane Gomes Barbosa on 13/08/20.
//  Copyright © 2020 Lidiane Gomes Barbosa. All rights reserved.
//

import UIKit

class BibliaViewController: UIViewController {

    // MARK: Properties
       
       
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        // Do any additional setup after loading the view.
    }
    
    // MARK: Selectors
     
     
     // MARK: Helpers
    
    func configureUI(){
         
            view.backgroundColor = .white
         //   navigationController?.navigationBar.barStyle = .black
         //   navigationController?.navigationBar.isHidden = true
            navigationItem.title = "Biblia"
          // let image = UIImageView(image: UIImage(named: "twitter_logo_blue"))
        //   image.contentMode = .scaleAspectFit
        //   navigationItem.titleView = image
       }

}
