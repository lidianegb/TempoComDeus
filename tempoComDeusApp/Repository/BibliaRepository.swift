//
//  BibliaRepository.swift
//  tempoComDeusApp
//
//  Created by Lidiane Gomes Barbosa on 18/08/20.
//  Copyright © 2020 Lidiane Gomes Barbosa. All rights reserved.
//

import Foundation
class BibliaRepository{
    
    func getLivros(completion: @escaping ([Livro]) -> Void){
        HTTP.get.request(url: .getLivros){
               data, response, error in
               
               if let error = error {
                             print(error)
                            completion([])
                             return
                         }
                         
                         guard let data = data, let response = response else {
                             completion([])
                             return
                         }
            

                         let json = try? JSONSerialization.jsonObject(with: data, options: [])
        
                        var books = [Livro]()
                        if let obj = json as? [String:Any]{
                                    print(obj)
                        }else if let obj = json as? [Any]{
                            for item in obj as! [Dictionary<String, AnyObject>]{
                                let name =  item["name"] as! String
                                let abbrev = item["abbrev"] as! Dictionary<String, String>
                                let author = item["author"] as! String
                                let chapters = item["chapters"] as! Int
                                let group = item["group"] as! String
                                let version = item["version"] as? String
                                let testment = item["testment"] as? String
                                let livro = Livro(abbrev: abbrev, name: name, author: author, chapters: chapters, group: group, testament: testment ?? "", version: version ?? "")
                                books.append(livro)
                                
                                }
                            }
                        
                         switch response.statusCode {
                         case 200:
                                completion(books)
                             return
                         default:
                             completion([])
                             return
                         }
                         
                     }
                     
           }
    
    
    func getCapitulo(livro: String, cap: Int, completion: @escaping (Biblia) -> Void){
      HTTP.get.request(url: .getCapitulo(abbrev: livro, cap: cap)){
                 data, response, error in
                 
                 if let error = error {
                               print(error)
                          //     completion([])
                               return
                           }
                           
                           guard let data = data, let response = response else {
                           //    completion([])
                               return
                           }
        
        
                        let aux = Biblia(book: Livro(abbrev: ["pt": "", "en": ""], name: "", author: "", chapters: 0, group: "", testament: "", version: ""), chapter: ["numero": 0, "versos": 0], verses: [Verso(number: 0, text: "")])
                                                     
                           switch response.statusCode {
                           case 200:
                            let biblia: Biblia = (try? JSONDecoder().decode(Biblia.self, from: data)) ?? aux
                                completion(biblia)
                               return
                           default:
                               completion(aux)
                               return
                }
                           
            }
                       
    }
  
}
