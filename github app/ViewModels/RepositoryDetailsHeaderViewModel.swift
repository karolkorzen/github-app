//
//  RepositoryDetailsHeaderViewModel.swift
//  github app
//
//  Created by Karol Korzeń on 13/12/2020.
//

import Foundation
import SDWebImage

class RepositoryDetailsHeaderViewModel {
    
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
    
    var startsLabelText: String{
        return "✩ Number of Stars (\(repository.stargazers_count))"
    }
}
