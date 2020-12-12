//
//  RepositoryCellViewModel.swift
//  github app
//
//  Created by Karol Korzeń on 12/12/2020.
//

import Foundation
import SDWebImage

class RepositoryCellViewModel {
    
    //MARK: - Properties
    
    let repository: Repository
    
    //MARK: - Lifecycle
    
    init(withRepository repository: Repository){
        self.repository = repository
    }
    
    //MARK: - Helpers

    var profileImageUrl: URL {
        guard let url = URL(string: repository.owner.avatar_url) else {return URL(string: "")!}
        return url
    }
    
    var titleLabelText: String{
        return repository.name
    }
    
    var startsLabelText: String{
        return "✩ \(repository.stargazers_count)"
    }
}
