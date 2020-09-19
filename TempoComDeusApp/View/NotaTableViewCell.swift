//
//  NotaTableViewCell.swift
//  TempoComDeusApp
//
//  Created by Lidiane Gomes Barbosa on 17/09/20.
//  Copyright © 2020 Lidiane Gomes Barbosa. All rights reserved.
//

import UIKit

class NotaTableViewCell: UITableViewCell, UITextViewDelegate {
    let backView = BackView()
    var nota: Nota = Nota(body: nil, cor: nil, versos: [])
    
    var color: String? {
        didSet {
            nota.cor = color ?? ""
            delegate?.getNota(nota: nota)
            backView.backgroundColor = .getColor(name: color ?? "nota1")
        }
    }
    weak var delegate: NewNotaDelegate?
    
    var textView: UITextView = {
        let text = UITextView()
        text.isScrollEnabled = false
        text.textAlignment = .left
        text.backgroundColor = .clear
        text.font = UIFont.systemFont(ofSize: 20)
        text.textColor = .label
        return text
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    func createCell() {
        contentView.backgroundColor = .backgroundColor
        addBackView()
        addTextView()
    }
    func textViewDidChange(_ textView: UITextView) {
        nota.body = textView.text
        delegate?.getNota(nota: nota)
        delegate?.updateHeightOfRow(self, textView)
      
    }

    func addTextView() {
        textView.text = "O que está no seu coração"
        textView.textColor = .secondaryLabel
        textView.delegate = self
        backView.addSubview(textView)
        textView.anchor(top: backView.topAnchor,
                       left: backView.leftAnchor,
                       bottom: backView.bottomAnchor,
                       right: backView.rightAnchor,
                       paddingTop: 0,
                       paddingLeft: 16,
                       paddingBottom: 0,
                       paddingRight: 16)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .secondaryLabel {
            textView.text = nil
            textView.textColor = .label
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "O que está no seu coração"
            textView.textColor = .secondaryLabel
        }
    }
 
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText = textView.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: text)
        return updatedText.count <= 25000
    }
    
    private func addBackView() {
        backView.layer.cornerRadius = 8
        backView.backgroundColor = .getColor(name: color ?? "")
        contentView.insertSubview(backView, at: 0)
        backView.anchor(top: contentView.topAnchor,
                        left: contentView.leftAnchor,
                        bottom: contentView.bottomAnchor,
                        right: contentView.rightAnchor,
                        paddingTop: 0,
                        paddingLeft: 0,
                        paddingBottom: 0,
                        paddingRight: 0)
    }
 
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}

extension NotaTableViewCell: ChangeColorDelegate {
    func didChangeColor(color: String) {
        self.color = color
    }
}
