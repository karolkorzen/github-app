//
//  GithubService.swift
//  github app
//
//  Created by Karol Korzeń on 11/12/2020.
//

import UIKit

//                 https://api.github.com/repos/:user/:repo/branches
//FIXME: - commits https://api.github.com/repos/chvin/react-tetris/branches

//FIXME - commits corrct GET /repos/:owner/:repo/commits
//                          https://api.github.com/repos/chvin/react-tetris/commits

//FIXME: - repository https://api.github.com/search/repositories?q=tetris&sort=stars&order=desc

/*
 
 GithubService.shared.searchRepositories(withPhrase: "Training-App") { (response) in
     print("response => \(response.items.count)")
     print("response => \(response.items.first)")
     print("now tryin to fetch commits")
     guard let firstResponse = response.items.first else {return}
     GithubService.shared.fetchCommits(withOwnerName: firstResponse.owner.login, withRepositoryName: firstResponse.name) { (response) in
         print("response => \(response.count)")
         print("response => \(response)")
     }
 }
 
 */

class GithubService {
    static let shared = GithubService()
    private var dataTask: URLSessionDataTask?
       
    func searchRepositories(withPhrase phrase: String, completion: @escaping ((RawRepositoryResponse) -> Void)) {
        
        let githubLink = "https://api.github.com/search/repositories?q=\(phrase)&sort=stars&order=desc"
        
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
    
    func fetchCommits(withOwnerName owner: String, withRepositoryName name: String, completion: @escaping (([RawCommitsResponse]) -> Void)) {
        
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
}
