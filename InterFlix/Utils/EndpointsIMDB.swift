//
//  EndpointsIMDB.swift
//  InterFlix
//
//  Created by Pablo Ruan Ribeiro Silva  on 05/01/22.
//

import Foundation

enum IdiomaFilmes: String {
    case BR = "&language=pt-PT"
    case US = "&language=en-US"
}

struct EndpointsIMDB {
    static let API_KEY = "?api_key=400a4115c1691c16170f7c6e88c2481c"
    static let URL_BASE = "https://api.themoviedb.org/3/"
    
    
    static func filmesRecomendandos(idioma: IdiomaFilmes = .BR, pagina: Int = 1) -> String {
        URL_BASE+"movie/top_rated"+API_KEY+idioma.rawValue+"&page="+pagina.description
    }
    
    static func filmesPopulares(idioma: IdiomaFilmes = .BR, pagina: Int = 1) -> String {
        URL_BASE+"movie/popular"+API_KEY+idioma.rawValue+"&page="+pagina.description
    }
    
    static func filmesEmCartaz(idioma: IdiomaFilmes = .BR, pagina: Int = 1) -> String {
        URL_BASE+"movie/now_playing"+API_KEY+idioma.rawValue+"&page="+pagina.description
    }
    
    static func filmesLancamentos(idioma: IdiomaFilmes = .BR, pagina: Int = 1) -> String {
        URL_BASE+"movie/upcoming"+API_KEY+idioma.rawValue+"&page="+pagina.description
    }
    
}
