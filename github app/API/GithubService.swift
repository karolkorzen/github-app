//
//  GithubService.swift
//  github app
//
//  Created by Karol Korzeń on 11/12/2020.
//

import UIKit

class GithubService {
    static let shared = GithubService()
    private var dataTask: URLSessionDataTask?
       
    func searchRepositories(withPhrase phrase: String, completion: @escaping ((RawRepositoryResponse) -> Void)) {
        
        let githubLink = "https://api.github.com/search/repositories?q=\(phrase)"
        
        guard let url = URL(string: githubLink) else {return}
        
        dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                
                print("DataTask error: \(error.localizedDescription)")
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                print("Empty Response")
                return
            }
            print("Response status code: \(response.statusCode)")
            
            guard let data = data else {
                print("Empty Data")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(RawRepositoryResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(jsonData)
                }
            } catch let error {
                print("ERROR!!!")
                print(error)
            }
            
        }
        dataTask?.resume()
    }
    
    func fetchCommits(withOwnerName owner: String, withRepositoryName name: String, completion: @escaping (([Commit]) -> Void)) {
        
        let githubLink = "https://api.github.com/repos/\(owner)/\(name)/commits"
        
        guard let url = URL(string: githubLink) else {return}
        print("url - \(url)")
        
        dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                
                print("DataTask error: \(error.localizedDescription)")
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                print("Empty Response")
                return
            }
            print("Response status code: \(response.statusCode)")
            
            guard let data = data else {
                print("Empty Data")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                var jsonData = try decoder.decode([RawCommitsResponse].self, from: data)
                if jsonData.count > 3 {
                    jsonData = Array(jsonData[0 ..< 3])
                }
                let data = jsonData.map{$0.commit}
                DispatchQueue.main.async {
                    completion(data)
                }
            } catch let error {
                print("ERROR!!!")
                print(error)
            }
            
        }
        dataTask?.resume()
    }
}
