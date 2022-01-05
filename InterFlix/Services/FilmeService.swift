//
//  FilmeService.swift
//  InterFlix
//
//  Created by Pablo Ruan Ribeiro Silva  on 05/01/22.
//

import Foundation

typealias FilmeResult = (_ filmes: [Filme], _ msg: String) -> ()


struct FilmeService {

    static func obtenhaRecomendados(idioma: IdiomaFilmes = .BR, pagina: Int = 1, completion: @escaping FilmeResult) {
        obtenha(endpoint: EndpointsIMDB.filmesRecomendandos(idioma: idioma, pagina: pagina), completion: completion)
    }
    
    static func obtenhaPopulares(idioma: IdiomaFilmes = .BR, pagina: Int = 1, completion: @escaping FilmeResult) {
        obtenha(endpoint: EndpointsIMDB.filmesPopulares(idioma: idioma, pagina: pagina), completion: completion)
    }
    
    static func obtenhaEmCartaz(idioma: IdiomaFilmes = .BR, pagina: Int = 1, completion: @escaping FilmeResult) {
        obtenha(endpoint: EndpointsIMDB.filmesEmCartaz(idioma: idioma, pagina: pagina), completion: completion)
    }
    
    static func obtenhaLancamentos(idioma: IdiomaFilmes = .BR, pagina: Int = 1, completion: @escaping FilmeResult) {
        obtenha(endpoint: EndpointsIMDB.filmesLancamentos(idioma: idioma, pagina: pagina), completion: completion)
    }
    
    private static func obtenha(endpoint: String, completion: @escaping FilmeResult) {
        API.request(endpoint, metodo: .get) { retorno in
            switch retorno {
            case let .sucesso(dados, _, msg):
                guard let result = dados as? Dictionary<String, Any>,
                      let filmesJson = result["results"] else {
                    completion([], "Nenhum filme encontrado")
                    return
                }
                
                if let filmesArrayData = jsonToData(json: filmesJson) {
                    do {
                        let objsFilmes = try JSONDecoder().decode([Filme].self, from: filmesArrayData)
                        completion(objsFilmes, msg)
                    } catch {
                        debugPrint(error)
                        completion([], error.localizedDescription)
                    }
                } else {
                    completion([], "Não foi possível gerar data")
                }
            case let .erro(_, _, msg):
                completion([], msg)
                return
            }
        }
    }
    
    private static func jsonToData(json: Any) -> Data? {
        do {
            return try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
        } catch {
            debugPrint(error)
        }
        return nil
    }
}
