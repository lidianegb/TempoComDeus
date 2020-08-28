//
//  VisualizarNotaViewController.swift
//  tempoComDeusApp
//
//  Created by Lidiane Gomes Barbosa on 14/08/20.
//  Copyright © 2020 Lidiane Gomes Barbosa. All rights reserved.
//

import UIKit

protocol UpdateNotaDelegate: class {
    func notaIsUpdated(updated: Bool)
}

class VisualizarNotaViewController: UIViewController {
    // MARK: Properties
    
    weak var delegate: UpdateNotaDelegate?
    
    var notaView = NotaView()
    private let notaRepository: NotaRepository
    private let notaID: UUID
    private var nota: Nota {
        didSet {
            notaView.textView.text = nota.body
            notaView.backgroundColor = .getColor(name: nota.cor)
        }
    }
    
       // MARK: Lifecycle
       override func viewDidLoad() {
            super.viewDidLoad()
            configureUI()
            setupNotaView()
       }
    
    init(notaRepository: NotaRepository, notaId: UUID) {
        self.notaRepository = notaRepository
        self.notaID = notaId
        self.nota = notaRepository.readItem(itemId: notaID) ?? Nota(body: nil, cor: nil)
        notaView.textView.text = nota.body
        notaView.backgroundColor = .getColor(name: nota.cor)
              
        super.init(nibName: nil, bundle: nil)
    }
   
       required init?(coder aDecoder: NSCoder) {
           fatalError("We aren't using storyboards")
       }
       
       // MARK: Selectors
        @objc  func editNota() {
            let notaViewController = CriarEditarNota(notaRepository: notaRepository, notaId: notaID, acao: .editar)
            notaViewController.modalPresentationStyle = .fullScreen
            notaViewController.notadelegate = self
            self.present(notaViewController, animated: true)
         }
        
        // MARK: Helpers
       
       func configureUI() {
        navigationController?.navigationBar.shadowImage = UIImage()
        view.backgroundColor = .backgroundColor
            
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit,
                                                            target: self, action: #selector(editNota) )
       }
    
    private func setupNotaView() {
        view.insertSubview(notaView, at: 0)
      notaView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
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

    func didChange(body: String, cor: String, notaId: UUID) {
        nota.body = body
        nota.cor = cor
        notaRepository.update(item: nota)
        nota = notaRepository.readItem(itemId: notaId) ?? Nota(body: nil, cor: nil)
        self.delegate?.notaIsUpdated(updated: true)
    }

}
