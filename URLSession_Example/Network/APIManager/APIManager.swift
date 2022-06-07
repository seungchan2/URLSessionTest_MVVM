//
//  APIManager.swift
//  URLSession_Example
//
//  Created by 김승찬 on 2022/05/30.
//

import Foundation

struct MovieDataManager {
    
    static let shared = MovieDataManager()
    
    let searchURL = "https://openapi.naver.com/v1/search/movie.json"
    
    let clientID = ""
    let clientSecret = ""
    
    func fetchMovie(query: String, completion: @escaping ([MovieInfo]?) -> Void) {
        
        let movieQuery = query.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        
        let urlString = "\(searchURL)?query=\(movieQuery!)"
        performRequest(with: urlString) { movies in
            completion(movies)
        }
    }
    
    func performRequest(with urlString: String, completion: @escaping ([MovieInfo]?) -> Void) {
        
        guard let url = URL(string: urlString) else { return }
        
        let session = URLSession(configuration: .default)
        
        var requestURL = URLRequest(url: url)
        
        requestURL.addValue(clientID, forHTTPHeaderField: "X-Naver-Client-Id")
        requestURL.addValue(clientSecret, forHTTPHeaderField: "X-Naver-Client-Secret")
        
        let task = session.dataTask(with: requestURL) { (data, response, error) in
            if error != nil {
                completion(nil)
                return
            }
            
            guard let safeData = data else {
                completion(nil)
                return
            }
            
            if let movies = self.parseJSON(safeData) {
                completion(movies)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
    
    func parseJSON(_ movieData: Data) -> [MovieInfo]? {
        
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(MovieModel.self, from: movieData)
            
            let dailyLists = decodedData.items
            
            let myMovieList = dailyLists.map {
                MovieInfo(title: $0.title, image: $0.image, director: $0.director, actor: $0.actor)
            }
            
            return myMovieList
            
        } catch {
            return nil
        }
    }
}
