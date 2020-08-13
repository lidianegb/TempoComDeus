//
//  NotasViewController.swift
//  tempoComDeusApp
//
//  Created by Lidiane Gomes Barbosa on 13/08/20.
//  Copyright © 2020 Lidiane Gomes Barbosa. All rights reserved.
//

import UIKit

class NotasViewController: UIViewController {

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
            navigationItem.title = "Anotações"
    }

}
