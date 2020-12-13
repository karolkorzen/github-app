//
//  RepositoryDetailsViewModel.swift
//  github app
//
//  Created by Karol Korzeń on 12/12/2020.
//

import Foundation
import UIKit

class RepositoryDetailsViewModel {
 
    //MARK: - Properties
    
    let repository: Repository
    var commits: [Commit] = []
    
    //MARK: - Lifecycle
    
    init(withRepository repository: Repository){
        self.repository = repository
    }
    
    //MARK: - API
    
    func fetchCommit(completion:(@escaping()->Void)) {
        GithubService.shared.fetchCommits(withOwnerName: repository.owner.login, withRepositoryName: repository.name) { (response) in
            self.commits = response
            completion()
        }
    }
}
