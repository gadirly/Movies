//
//  APICaller.swift
//  Netflix
//
//  Created by Gadirli on 27.10.22.
//

import Foundation

struct Constants {
    static let API_KEY = "fdb8f6da0e1144db35b62cdbf91fbf1a"
    static let baseUrl = "https://api.themoviedb.org"
    static let youtubeApiKey = "AIzaSyDhaW_Ar7rMBvKaqWVS7risTJhvRRrQJms"
    static let youtubeBaseUrl = "https://youtube.googleapis.com"
}

enum APIError: Error {
    case failedToGetData
}

class APICaller {
    static let shared = APICaller()
    

    
    func getTrendingMovies(completion: @escaping (Result<[Movie],Error>) -> ()) {
        
        guard let url = URL(string: "\(Constants.baseUrl)/3/trending/movie/day?api_key=\(Constants.API_KEY)") else {return}
        
        print(url)
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            
            guard let data = data, error == nil else {return}
            
            do {
                let results = try JSONDecoder().decode(TrendingMoviesResponse.self, from: data)
                
                completion(.success(results.results))
            }
            catch {
                print("Error parsing JSON: \(error.localizedDescription)")
                completion(.failure(APIError.failedToGetData))
            }
            
            
            
            
        }
        
        task.resume()
        
        
    }
    
    
    func getTrendingTvs(completion: @escaping (Result<[Movie],Error>) -> Void) {
        
        guard let url = URL(string: "\(Constants.baseUrl)/3/trending/tv/day?api_key=\(Constants.API_KEY)") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {return}
            do{
                
                let results = try JSONDecoder().decode(TrendingMoviesResponse.self, from: data)
                completion(.success(results.results))
            }
            catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        
        task.resume()
        
    }
    
    func getPopularMovies(completion: @escaping (Result<[Movie],Error>) -> Void) {
        
        guard let url = URL(string: "\(Constants.baseUrl)/3/movie/popular?api_key=\(Constants.API_KEY)&language=en-US&page=1") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {return}
            do{
                
                let results = try JSONDecoder().decode(TrendingMoviesResponse.self, from: data)
                completion(.success(results.results))
      
            }
            catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        
        task.resume()
        
    }
    
    
    func getUpcomingMovies(completion: @escaping (Result<[Movie],Error>) -> Void) {
        guard let url  = URL(string: "\(Constants.baseUrl)/3/movie/upcoming?api_key=\(Constants.API_KEY)&language=en-US&page=1") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {return}
            
            do {
                let results = try JSONDecoder().decode(TrendingMoviesResponse.self, from: data)
                completion(.success(results.results))
                
                
            }
            catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        
        task.resume()
    }
    
    func getTopRatedMovies(completion: @escaping (Result<[Movie],Error>) -> Void) {
        guard let url  = URL(string: "\(Constants.baseUrl)/3/movie/top_rated?api_key=\(Constants.API_KEY)&language=en-US&page=1") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {return}
            
            do {
                let results = try JSONDecoder().decode(TrendingMoviesResponse.self, from: data)
                completion(.success(results.results))
                
                
            }
            catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        
        task.resume()
    }
    
    func getDiscoverMovies(completion: @escaping (Result<[Movie],Error>) -> Void) {
        //
        
        guard let url = URL(string: "\(Constants.baseUrl)/3/discover/movie?api_key=\(Constants.API_KEY)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {return}
            
            do {
                let results = try JSONDecoder().decode(TrendingMoviesResponse.self, from: data)
                completion(.success(results.results))
            }
            catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        
        task.resume()
       
    }
    
    func searchMovies(with query: String, completion: @escaping (Result<[Movie],Error>) -> Void) {
        
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
            return
        }
       
        guard let url = URL(string: "\(Constants.baseUrl)/3/search/movie?api_key=\(Constants.API_KEY)&query=\(query)") else {return}
        print(url)
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {return}
            
            do {
                let results = try JSONDecoder().decode(TrendingMoviesResponse.self, from: data)
                
                completion(.success(results.results))
            }
            catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        
        task.resume()
       
    }
    
    
    func getMovie(with query: String, completion: @escaping (Result<VideoElement,Error>) -> Void) {
        
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
            return
        }
        
        guard let url = URL(string: "\(Constants.youtubeBaseUrl)/youtube/v3/search?q=\(query)&key=\(Constants.youtubeApiKey)") else {
            return
        }
        print(url)
      
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            print(url)
            guard let data = data, error == nil else {return}
            
            do {
                let result = try JSONDecoder().decode(YoutubeResult.self, from: data)
                
                completion(.success(result.items[0]))
            }
            catch {
                
                completion(.failure(error))
            }
            
            
        }
        
        task.resume()
        
    }
    
    func getMovieById(movie: String, completion: @escaping (Result<Movie,Error>) -> Void) {
        //
        
        guard let url = URL(string: "\(Constants.baseUrl)/3/movie/\(movie)?api_key=\(Constants.API_KEY)&language=en-US") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {return}
            
            do {
                let results = try JSONDecoder().decode(Movie.self, from: data)
                completion(.success(results))
            }
            catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        
        task.resume()
       
    }
    
}
