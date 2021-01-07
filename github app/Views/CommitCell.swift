//
//  CommitCell.swift
//  github app
//
//  Created by Karol Korzeń on 12/12/2020.
//

import UIKit

class CommitCell: UITableViewCell {
    
    //MARK: - Properties
    
    private var numberLabel: UILabel = {
        let label = UILabel()
        label.setDimensions(width: 36, height: 36)
        label.layer.cornerRadius = 18
        label.layer.backgroundColor = UIColor.rgb(red: 245, green: 245, blue: 245).cgColor
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.init(name: "SFProText-Medium", size: 17)
        return label
    }()
    
    private var authorNameLabel = Utilities.shared.standardLabel(withSize: 11, withWeight: .semibold, withColor: UIColor.rgb(red: 0, green: 122, blue: 255))
    private var authorEmailLabel = Utilities.shared.standardLabel(withSize: 17, withWeight: .regular, withColor: .black)
    private var commitMessageLabel = Utilities.shared.standardLabel(withSize: 17, withWeight: .regular, withColor: UIColor.rgb(red: 158, green: 158, blue: 158))
    
    var viewModel: RepositoryDetailsCellViewModel? {
        didSet{
            putData()
        }
    }
    
    //MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    func putData(){
        guard let viewModel = self.viewModel else {return}
        numberLabel.text = viewModel.numberLabelText
        authorNameLabel.text = viewModel.authorName
        authorEmailLabel.text = viewModel.authorEmailLabelText
        commitMessageLabel.text = viewModel.commitMessageLabelText
        commitMessageLabel.numberOfLines = 0
    }
    
    func configureCell(){
        addSubview(numberLabel)
        numberLabel.anchor(top: topAnchor, left: leftAnchor, paddingTop: 26, paddingLeft: 20)
        
        
        let stack = UIStackView(arrangedSubviews: [authorNameLabel, authorEmailLabel, commitMessageLabel])
        stack.spacing = 2
        stack.axis = .vertical
        addSubview(stack)
        stack.anchor(top: topAnchor, left: numberLabel.rightAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 16, paddingLeft: 20, paddingBottom: 12, paddingRight: 16)
    }
}
