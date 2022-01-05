//
//  Filme.swift
//  InterFlix
//
//  Created by Pablo Ruan Ribeiro Silva  on 05/01/22.
//

import Foundation

struct Filme: Codable {
    
    var titulo: String
    var id: Int
    var poster: String
    var posterFundo: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case titulo = "title"
        case poster = "poster_path"
        case posterFundo = "backdrop_path"
    }
    
    func getUrlPoster(size: Int = 300) -> String {
        "https://image.tmdb.org/t/p/w"+size.description+"/"+self.poster
    }
    
    func getUrlPosterFundo(size: Int = 300) -> String {
        "https://image.tmdb.org/t/p/w"+size.description+"/"+self.posterFundo
    }
}
