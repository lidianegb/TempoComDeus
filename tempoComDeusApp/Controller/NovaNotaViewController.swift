//
//  NovaNotaViewController.swift
//  tempoComDeusApp
//
//  Created by Lidiane Gomes Barbosa on 15/08/20.
//  Copyright © 2020 Lidiane Gomes Barbosa. All rights reserved.
//

import UIKit

class NovaNota: UIViewController, UITextViewDelegate{
    // MARK: Properties

     let backView = BackView()
    
    
    var nota: Nota?
    //{
     //   didSet{
           // if let nota = nota{
              //  textView.text = nota.text
             //   view.reloadInputViews()
                
          //  }
      //  }
 //   }
    
    var textView: UITextView = {
        let text = UITextView()
        text.isEditable = true
        text.textAlignment = .left
        text.backgroundColor = .clear
        text.font = UIFont.systemFont(ofSize: 20)
        return text

    }()
    
    
    
    let cancelButton : UIButton = {
        let button = UIButton()
        button.setTitle("Cancelar", for: .normal)
        button.setTitleColor(.blueAct, for: .normal)
        button.addTarget(self, action: #selector(cancelar), for: .touchUpInside)
        return button
    }()
    
    let saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Salvar", for: .normal)
       button.setTitleColor(.blueAct, for: .normal)
        button.setTitle("", for: .disabled)
        button.isEnabled = false
        button.addTarget(self, action: #selector(salvar), for: .touchUpInside)
        return button
    }()
    
    
    
       // MARK: Lifecycle
       override func viewDidLoad() {
            super.viewDidLoad()
            configureUI()
            addBackView()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
               
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHiden), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        
        let stackViewHeader = UIStackView(arrangedSubviews: [cancelButton, saveButton])
        stackViewHeader.distribution = .equalSpacing
        backView.addSubview(stackViewHeader)
        stackViewHeader.anchor(top: backView.topAnchor, left: backView.leftAnchor, right: backView.rightAnchor, paddingTop: 8, paddingLeft: 8, paddingRight: 8)
    
        
        textView.delegate = self
        backView.addSubview(textView)
        backView.backgroundColor = .nota1
        textView.anchor(top: stackViewHeader.bottomAnchor, left: backView.leftAnchor,bottom: backView.bottomAnchor, right: backView.rightAnchor, paddingTop: 50, paddingLeft: 16,paddingBottom: 80, paddingRight: 16)
        
        
        let cor1 = createButtonCor(cor: "cor1")
        cor1.addTarget(self, action: #selector(changeColor1), for: .touchUpInside)
        
        let cor2 = createButtonCor(cor: "cor2")
         cor2.addTarget(self, action: #selector(changeColor2), for: .touchUpInside)
        
        let cor3 = createButtonCor(cor: "cor3")
         cor3.addTarget(self, action: #selector(changeColor3), for: .touchUpInside)
        
        let cor4 = createButtonCor(cor: "cor4")
         cor4.addTarget(self, action: #selector(changeColor4), for: .touchUpInside)
        
        let cor5 = createButtonCor(cor: "cor5")
         cor5.addTarget(self, action: #selector(changeColor5), for: .touchUpInside)
        
        let stackViewBottom = UIStackView(arrangedSubviews: [cor1, cor2, cor3, cor4, cor5, UIView(), UIView(), UIView()])
        stackViewBottom.alignment = .leading
        stackViewBottom.spacing = 10
      //  stackViewBottom.distribution = .equalSpacing
        backView.addSubview(stackViewBottom)
        stackViewBottom.anchor(top: textView.bottomAnchor, left: backView.leftAnchor, bottom: backView.bottomAnchor, right: backView.rightAnchor, paddingTop: 20, paddingLeft: 16, paddingBottom: 10, paddingRight: 16)
    
       
       }
    
    func textViewDidChange(_ textView: UITextView) {
        if textView == self.textView {
            self.saveButton.isEnabled = !textView.text.isEmpty
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
       
       // MARK: Selectors
            
        @objc func cancelar(){
            if let text = textView.text, text.isEmpty{
                self.dismiss(animated: true, completion: nil)
            }else{
                displayActionSheet()
            }
        }
        @objc func salvar(){
            let nota = Nota(text: textView.text, color: backView.backgroundColor?.description ?? " ")
            print(nota.color)
            print(nota.date)
            print(nota.text)
            self.dismiss(animated: true, completion: nil)
        }
    
        @objc func displayActionSheet(){
          let menu = UIAlertController(title: nil, message: "Descartar alterações?", preferredStyle: .actionSheet)
          let deleteAtion = UIAlertAction(title: "Descartar", style: .destructive, handler: { action in
                self.dismiss(animated: true, completion: nil)
              }
          )
          let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
          
      
          menu.addAction(deleteAtion)
          menu.addAction(cancelAction)
          self.present(menu, animated: true, completion: nil)
        
         }
    
     
    
        @objc func changeColor1(){
            backView.backgroundColor = .nota1
        }
        @objc func changeColor2(){
                   backView.backgroundColor = .nota2
               }
        @objc func changeColor3(){
            backView.backgroundColor = .nota3
               }
        @objc func changeColor4(){
            backView.backgroundColor = .nota4
               }
        @objc func changeColor5(){
               backView.backgroundColor = .nota5
           }
    
        @objc func keyboardHiden(notification: NSNotification){
                if let duracao =  notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double{
                    UIView.animate(withDuration: duracao){
                        self.view.frame = UIScreen.main.bounds
                        self.view.layoutIfNeeded()
                    }
                }
            }
        @objc func keyboardShow(notification:NSNotification){
             if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue{
                 if let duracao = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double{
                     
                     UIView.animate(withDuration: duracao){
                         self.view.frame = CGRect(
                             x: UIScreen.main.bounds.origin.x,
                             y: UIScreen.main.bounds.origin.y,
                             width: UIScreen.main.bounds.width,
                             height: UIScreen.main.bounds.height - keyboardSize.height
                         )
                         self.view.layoutIfNeeded()
                     }
                     
                 }
             }
         }
    
    
        // MARK: Helpers
       
       private func configureUI(){
           navigationController?.navigationBar.shadowImage = UIImage()
           view.backgroundColor = .blueBackgroud
            
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: nil)
    
       }
    
    private func addBackView(){
        let window = UIApplication.shared.windows.filter{$0.isKeyWindow}.first
        let top = (window?.windowScene?.statusBarManager?.statusBarFrame.size.height ?? 0) + (navigationController?.navigationBar.frame.size.height ?? 0)
        let bottom = tabBarController?.tabBar.frame.size.height ?? 0
   
        view.insertSubview(backView, at: 0)
        backView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: top , paddingLeft: 8, paddingBottom: bottom, paddingRight: 8)
    }

    
    private func createButtonCor(cor: String) -> UIButton{
        let button = UIButton()
        let img = UIImage(named: cor)
        button.setImage(img, for: .normal)
        button.imageView?.contentMode = UIView.ContentMode.scaleToFill
        button.setDimensions(width: 32, height: 32)
        return button
    }
    
}
