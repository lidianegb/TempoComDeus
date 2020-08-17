//
//  NotasCollectionViewCell.swift
//  tempoComDeusApp
//
//  Created by Lidiane Gomes Barbosa on 13/08/20.
//  Copyright © 2020 Lidiane Gomes Barbosa. All rights reserved.
//

import UIKit

protocol NotasCellDelegate: class{
    func deleteCell(cell: NotasCollectionViewCell)
}

class NotasCollectionViewCell: UICollectionViewCell, UIActionSheetDelegate {

    weak var viewController: UIViewController?
    weak var delegate: NotasCellDelegate?

    var nota:Nota?{
       didSet{
           if let nota = nota{
            labelPreview.text = nota.body
            labelDate.text = "\(String(describing: nota.date))"
           }
       }
    }
    let wrapperView = UIView()
    let labelPreview = UILabel()
    let labelDate = UILabel()
    let buttonDelete = UIButton()
    
 
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    
    func createCell(){
        addWrapperView()
        addTextPreview()
        addButtonDelete()
        addTextDate()
        
    }
    
    private func addWrapperView(){
        contentView.addSubview(wrapperView)
        wrapperView.backgroundColor = .nota1
        wrapperView.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 8)
        wrapperView.layer.masksToBounds = true
        wrapperView.layer.cornerRadius = 8
    }
    
    private func addTextPreview(){
        labelPreview.font = UIFont.systemFont(ofSize: 17)
        labelPreview.textAlignment = .left
        labelPreview.textColor = .black
        labelPreview.numberOfLines = 2
        wrapperView.addSubview(labelPreview)
        labelPreview.anchor(top: wrapperView.topAnchor, left: wrapperView.leftAnchor, right: wrapperView.rightAnchor, paddingTop: 30, paddingLeft: 12, paddingRight: 12)
    }
    
    
    private func addButtonDelete(){
        buttonDelete.setImage(UIImage(named: "delete"), for: .normal)
        buttonDelete.setDimensions(width: 16, height: 17)
        wrapperView.addSubview(buttonDelete)
        buttonDelete.anchor( top: labelPreview.bottomAnchor, bottom: wrapperView.bottomAnchor, right: wrapperView.rightAnchor, paddingTop: 10, paddingBottom: 20, paddingRight: 12)
        buttonDelete.addTarget(self, action: #selector(displayActionSheet), for: .touchUpInside)
    }
    
    private func addTextDate(){
        labelDate.font = UIFont.systemFont(ofSize: 14)
       labelDate.textAlignment = .left
       labelDate.textColor = .systemGray
       labelDate.numberOfLines = 1
       wrapperView.addSubview(labelDate)
        labelDate.anchor(top: labelPreview.bottomAnchor, left: wrapperView.leftAnchor, bottom: wrapperView.bottomAnchor, right: buttonDelete.leftAnchor, paddingTop: 10, paddingLeft: 12, paddingBottom: 20, paddingRight: 12)
    }
    
   @objc func displayActionSheet(){
        let menu = UIAlertController(title: nil, message: "Deletar nota?", preferredStyle: .actionSheet)
        let deleteAtion = UIAlertAction(title: "Deletar", style: .destructive, handler: { action in
            self.delegate?.deleteCell(cell: self)
            }
        )
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        
    
        menu.addAction(deleteAtion)
        menu.addAction(cancelAction)
        viewController?.present(menu, animated: true, completion: nil)
  
   }
}
