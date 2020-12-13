//
//  HeaderCommitView.swift
//  github app
//
//  Created by Karol Korzeń on 13/12/2020.
//

import UIKit

protocol CommitsHeaderViewDelegate: class {
    func popVC()
}

class CommitsHeaderView: UIView{
    
    //MARK: - Properties
    
    weak var delegate: CommitsHeaderViewDelegate?
    var viewModel: RepositoryDetailsHeaderViewModel
    
    private var repoByLabel = Utilities.shared.standardLabel(withSize: 15, withWeight: .semibold, withColor: .white)
    private var repoAuthorNameLabel = Utilities.shared.standardLabel(withSize: 28, withWeight: .bold, withColor: .white)
    private var numberOfStarsLabel = Utilities.shared.standardLabel(withSize: 13, withWeight: .regular, withColor: .white)
    private var repoTitleLabel = Utilities.shared.standardLabel(withSize: 17, withWeight: .semibold, withColor: .black)
    private var commitsHistoryLabel = Utilities.shared.standardLabel(withSize: 22, withWeight: .bold, withColor: .black)
    
    private var actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.rgb(red: 242, green: 242, blue: 247)
        button.setTitle("VIEW ONLINE", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        button.setTitleColor(UIColor.rgb(red: 0, green: 122, blue: 255), for: .normal)
        button.layer.cornerRadius = 17
        button.addTarget(self, action: #selector(viewOnlineTapped), for: .touchUpInside)
        button.isUserInteractionEnabled = true
        return button
    }()
    
    private var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.clear
        button.setImage(UIImage(named: "backIcon"), for: .normal)
        button.setTitle("Back", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        button.tintColor = .white
        button.isUserInteractionEnabled = true
        button.addTarget(self, action: #selector(popVC), for: .touchUpInside)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 5.5, bottom: 0, right: 0)
        return button
    }()
    
    //MARK: - Lifecycle
    
    init (frame: CGRect, withRepository repository: Repository){
        self.viewModel = RepositoryDetailsHeaderViewModel(withRepository: repository)
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Selectors
    
    @objc func viewOnlineTapped(){
        if let url = URL(string: viewModel.repository.html_url) {
            UIApplication.shared.open(url)
        }
    }
    
    @objc func popVC(){
        delegate?.popVC()
    }
    
    //MARK: - Helpers
    
    func configureUI(){
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.backgroundColor = .red
        iv.clipsToBounds = true
        iv.setDimensions(width: frame.width, height: 263)
        iv.sd_setImage(with: viewModel.profileImageUrl)
        addSubview(iv)
        iv.anchor(top:topAnchor, left: leftAnchor, right: rightAnchor)
        
        repoByLabel.alpha = 0.6
        numberOfStarsLabel.alpha = 0.5
        
        repoByLabel.text = "REPO BY"
        repoAuthorNameLabel.text = viewModel.repository.owner.login
        numberOfStarsLabel.text = viewModel.startsLabelText
        repoTitleLabel.text = viewModel.repository.name
        commitsHistoryLabel.text = "Commits History"
        
        addSubview(repoByLabel)
        addSubview(repoAuthorNameLabel)
        addSubview(numberOfStarsLabel)
        addSubview(repoTitleLabel)
        addSubview(commitsHistoryLabel)
        addSubview(actionButton)
        addSubview(backButton)
        
        actionButton.setDimensions(width: 118, height: 30)
        commitsHistoryLabel.anchor(left: leftAnchor, bottom: bottomAnchor, paddingLeft: 16, paddingBottom: 10, height: 28)
        repoTitleLabel.anchor(left: leftAnchor, bottom: commitsHistoryLabel.topAnchor, paddingLeft: 20, paddingBottom: 39, width: 300, height: 22)
        actionButton.centerY(inView: repoTitleLabel)
        actionButton.anchor(right: rightAnchor, paddingRight: 16)
        
        numberOfStarsLabel.anchor(left: leftAnchor, bottom: iv.bottomAnchor, paddingLeft: 20, paddingBottom: 22, height: 18)
        repoAuthorNameLabel.anchor(left: leftAnchor, bottom: numberOfStarsLabel.topAnchor, paddingLeft: 20, paddingBottom: 6, width: 300, height: 34)
        repoByLabel.anchor(left: leftAnchor, bottom: repoAuthorNameLabel.topAnchor, paddingLeft: 20, paddingBottom: 4)
        backButton.anchor(top: topAnchor, left: leftAnchor, paddingTop: 11.5+UIApplication.shared.statusBarFrame.height, paddingLeft: 8.5,width: 60, height: 20.5)
    }
}
