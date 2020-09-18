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
        addBackView()
        addTextView()
        addStackBottom()
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
                        right: contentView.rightAnchor,
                        paddingTop: 0,
                        paddingLeft: 8,
                        paddingRight: 8)
    }
    
    func addStackBottom() {
        let cor1 = createButtonCor(cor: "nota1")
            cor1.addTarget(self, action: #selector(changeColor1), for: .touchUpInside)
              
            let cor2 = createButtonCor(cor: "nota2")
            cor2.addTarget(self, action: #selector(changeColor2), for: .touchUpInside)
              
            let cor3 = createButtonCor(cor: "nota3")
            cor3.addTarget(self, action: #selector(changeColor3), for: .touchUpInside)
              
            let cor4 = createButtonCor(cor: "nota4")
            cor4.addTarget(self, action: #selector(changeColor4), for: .touchUpInside)
              
            let cor5 = createButtonCor(cor: "nota5")
            cor5.addTarget(self, action: #selector(changeColor5), for: .touchUpInside)
              
            let stackViewBottom = UIStackView(arrangedSubviews:
                  [cor1, cor2, cor3, cor4, cor5, UIView(), UIView(), UIView()])
            stackViewBottom.alignment = .leading
            stackViewBottom.spacing = 10
            
            contentView.addSubview(stackViewBottom)
            stackViewBottom.anchor(top: backView.bottomAnchor,
                                     left: contentView.leftAnchor,
                                     bottom: contentView.bottomAnchor,
                                     right: contentView.rightAnchor,
                                     paddingTop: 8,
                                     paddingLeft: 16,
                                     paddingBottom: 0,
                                     paddingRight: 16)
    }
    private func createButtonCor(cor: String) -> UIButton {
        let button = UIButton()
        button.backgroundColor = .getColor(name: cor)
        button.layer.borderWidth = 0.3
        button.layer.borderColor = UIColor.black.cgColor
        button.setDimensions(width: 32, height: 32)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 16
        return button
    }
    
    @objc func changeColor1() {
        backView.backgroundColor = .nota1
        color = "nota1"
    }
    @objc func changeColor2() {
        backView.backgroundColor = .nota2
        color = "nota2"
    }
    @objc func changeColor3() {
        backView.backgroundColor = .nota3
        color = "nota3"
    }
    @objc func changeColor4() {
        backView.backgroundColor = .nota4
        color = "nota4"
    }
    @objc func changeColor5() {
        backView.backgroundColor = .nota5
        color = "nota5"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
