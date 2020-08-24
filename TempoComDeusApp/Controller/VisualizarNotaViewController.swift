//
//  VisualizarNotaViewController.swift
//  tempoComDeusApp
//
//  Created by Lidiane Gomes Barbosa on 14/08/20.
//  Copyright © 2020 Lidiane Gomes Barbosa. All rights reserved.
//

import UIKit

class VisualizarNotaViewController: UIViewController {
    // MARK: Properties

     let backView = BackView()
    
    private let notaRepository: NotaRepository
    private let notaID: UUID
    private var nota: Nota {
        didSet {
            textView.text = nota.body
            backView.backgroundColor = .getColor(name: nota.cor)
        }
    }
       
    let textView: UITextView = {
        let text = UITextView()
        text.allowsEditingTextAttributes = false
        text.isEditable = false
        text.textAlignment = .left
        text.backgroundColor = .clear
        text.showsVerticalScrollIndicator = false
        text.font = UIFont.systemFont(ofSize: 20)
        return text
    }()
    
       // MARK: Lifecycle
       override func viewDidLoad() {
            super.viewDidLoad()
            configureUI()
            addBackView()
            addTextView()
            
       }
    
        init(notaRepository: NotaRepository, notaId: UUID) {
              self.notaRepository = notaRepository
              self.notaID = notaId
            self.nota = notaRepository.readItem(itemId: notaID) ?? Nota(body: nil, cor: nil)
              super.init(nibName: nil, bundle: nil)
          }
       
           required init?(coder aDecoder: NSCoder) {
               fatalError("We aren't using storyboards")
           }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        nota = notaRepository.readItem(itemId: notaID) ?? Nota(body: nil, cor: nil)
    }
       
       // MARK: Selectors
        @objc  func editNota() {
            let notaViewController = EditNota(notaRepository: notaRepository, notaId: notaID)
             notaViewController.modalPresentationStyle = .fullScreen
            notaViewController.delegate = self
             self.present(notaViewController, animated: true)
         }
        
        // MARK: Helpers
       
       func configureUI() {
           navigationController?.navigationBar.shadowImage = UIImage()
           view.backgroundColor = .blueBackgroud
            
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit,
                                                            target: self, action: #selector(editNota) )
        
            backView.layer.cornerRadius = 10
            backView.layer.masksToBounds = true
       }

        func addTextView() {
            backView.addSubview(textView)
            textView.anchor(top: backView.topAnchor,
                            left: backView.leftAnchor,
                            bottom: backView.bottomAnchor,
                            right: backView.rightAnchor,
                            paddingTop: 20,
                            paddingLeft: 16,
                            paddingBottom: 20,
                            paddingRight: 16)
            
        }
    
        private func addBackView() {
           view.insertSubview(backView, at: 0)
           backView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                           left: view.leftAnchor,
                           bottom: view.safeAreaLayoutGuide.bottomAnchor,
                           right: view.rightAnchor,
                           paddingTop: 0 ,
                           paddingLeft: 8,
                           paddingBottom: 0,
                           paddingRight: 8)
       }

}

extension VisualizarNotaViewController: NotaDelegate {

    func didChange(body: String, cor: String) {
        nota.body = body
        nota.cor = cor
        notaRepository.update(item: nota)
    }

}
