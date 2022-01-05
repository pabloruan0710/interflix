//
//  APIRequest.swift
//  InterFlix
//
//  Created by Pablo Ruan Ribeiro Silva  on 05/01/22.
//

import Foundation
import UIKit

enum HTTPMetodo: String {
    case get = "GET"
    case post = "POST"
}

enum RetornoResult {
    case sucesso(dados: Any?, sucesso: Bool, msg: String)
    case erro(dados: Any?, sucesso: Bool, msg: String)
}

typealias result = (RetornoResult) -> ()

protocol APIProtocol {
    static func request(_ endpoint: String, metodo: HTTPMetodo, completion: @escaping result)
    static func downloadImage(_ url: String, completion: @escaping (_ status: Bool, _ imagem: UIImage?) -> Void)
}

struct API: APIProtocol {
    static func request(_ endpoint: String, metodo: HTTPMetodo, completion: @escaping result) {
        let session = URLSession.shared
        
        guard let url = URL(string: endpoint) else {
            completion(.erro(dados: nil, sucesso: false, msg: "Url com formato incorreto "+endpoint))
            return
        }
        
        let task = session.dataTask(with: url) { data, response, error in
            if error != nil {
                completion(.erro(dados: nil, sucesso: false, msg: error?.localizedDescription ?? "Erro desconhecido"))
            } else {
                
                guard let dados = data else {
                    completion(.erro(dados: nil, sucesso: false, msg: "Dados não retornados"))
                    return
                }
                
                // parser do json
                do {
                    let json = try JSONSerialization.jsonObject(with: dados, options: .allowFragments)
                    completion(.sucesso(dados: json, sucesso: true, msg: "Dados retornados com sucesso"))
                } catch {
                    debugPrint(error)
                    completion(.erro(dados: nil, sucesso: false, msg: error.localizedDescription))
                }
            }
        }
        task.resume()
    }
    
    static func downloadImage(_ url: String, completion: @escaping (Bool, UIImage?) -> Void) {
        if let urlRequest = URL(string: url) {
            DispatchQueue.global(qos: .background).async {
                URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                    if let dados = data {
                        if let img = UIImage(data: dados) {
                            completion(true, img)
                            return
                        }
                    }
                    completion(false, nil)
                }.resume()
            }
        }
    }
}
