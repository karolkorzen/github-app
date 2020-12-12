//
//  RepositoryCellViewModel.swift
//  github app
//
//  Created by Karol Korzeń on 12/12/2020.
//

import Foundation

class RepositoryViewModel {
    
    //MARK: - Properties
    
    var repositories: [Repository] = []
    
    //MARK: - API
    
    func search(withPhrase phrase: String, completion:(@escaping()->Void)) {
        GithubService.shared.searchRepositories(withPhrase: phrase) { (response) in
            self.repositories = response.items
            completion()
        }
    }
    
    func reset(completion:(@escaping()->Void)){
        repositories.removeAll()
        completion()
    }
}
