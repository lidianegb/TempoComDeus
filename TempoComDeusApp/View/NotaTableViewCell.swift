//
//  NotaTableViewCell.swift
//  TempoComDeusApp
//
//  Created by Lidiane Gomes Barbosa on 17/09/20.
//  Copyright © 2020 Lidiane Gomes Barbosa. All rights reserved.
//

import UIKit

class NotaTableViewCell: UITableViewCell, UITextViewDelegate {
   
    var nota: Nota = Nota(body: nil, cor: nil, versos: [])
    
    var color: String? {
        didSet {
            nota.cor = color ?? ""
            delegate?.getNota(nota: nota)
            textView.backgroundColor = .getColor(name: color ?? "nota1")
        }
    }
    weak var delegate: NewNotaDelegate?
    
    var textView: UITextView = {
        let text = UITextView()
        text.isScrollEnabled = false
        text.textAlignment = .left
        text.textContainerInset = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        text.font = UIFont.systemFont(ofSize: 20)
        text.textColor = .label
        text.layer.cornerRadius = 8
        text.clipsToBounds = true
        return text
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    func createCell() {
        contentView.backgroundColor = .backgroundColor
    
        addTextView()
    }
    func textViewDidChange(_ textView: UITextView) {
        nota.body = textView.text
        delegate?.getNota(nota: nota)
        delegate?.updateHeightOfRow(self, textView)
      
    }

    func addTextView() {
        textView.backgroundColor = .getColor(name: color ?? "")
        textView.addDoneButton(title: "Done", target: self, selector: #selector(tapDone(sender:)))
        textView.text = "O que está no seu coração?"
        textView.textColor = .secondaryLabel
        textView.delegate = self
        contentView.addSubview(textView)
        textView.anchor(top: contentView.topAnchor,
                        left: contentView.leftAnchor,
                        bottom: contentView.bottomAnchor,
                        right: contentView.rightAnchor,
                        paddingTop: 16,
                        paddingLeft: 0,
                        paddingBottom: 16,
                        paddingRight: 0)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .secondaryLabel {
            textView.text = nil
            textView.textColor = .label
        }
    }
    
    func textViewDidChangeSelection(_ textView: UITextView) {
        delegate?.updateHeightOfRow(self, textView)
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "O que está no seu coração?"
            textView.textColor = .secondaryLabel
        }
    }
 
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    @objc func tapDone(sender: UITextView) {
        textView.resignFirstResponder()
    }
    
}

extension NotaTableViewCell: ChangeColorDelegate {
    func didChangeColor(color: String) {
        self.color = color
    }
}
