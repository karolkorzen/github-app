//
//  RepositoryCell.swift
//  github app
//
//  Created by Karol Korzeń on 11/12/2020.
//

import UIKit
import SDWebImage

class RepositoryCell: UITableViewCell {
    
    //MARK: - Properties
    
    private var profileImageView = Utilities.shared.profileImageView()
    private var repositoryTitleLabel = Utilities.shared.boldLabel(withSize: 17)
    private var starsCountLabel = Utilities.shared.standardLabel(withSize: 17, withWeight: .light)
    private var isBiggerLabel: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage.init(systemName: "chevron.right")
        if let image = iv.image {
            iv.setDimensions(width: image.size.width, height: image.size.height)
        }
        iv.tintColor = .darkGray
        return iv
    }()
    var viewModel: RepositoryCellViewModel? {
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
    
    
    override var frame: CGRect {
        get {
            return super.frame
        }
        set (newFrame) {
            var frame = newFrame
            frame.origin.x += 10
            let f = CGRect(x: frame.origin.x+8, y: frame.origin.y, width: frame.width-36, height: frame.height-10)
            super.frame = f
        }
    }
    
    func putData(){
        guard let viewModel = self.viewModel else {return}
        profileImageView.sd_setImage(with: viewModel.profileImageUrl)
        repositoryTitleLabel.text = viewModel.titleLabelText
        starsCountLabel.text = viewModel.startsLabelText
    }
    
    func configureCell(){
        backgroundColor = UIColor.rgb(red: 245, green: 245, blue: 245)
        layer.cornerRadius = 13
        
        addSubview(profileImageView)
        let stack = UIStackView.init(arrangedSubviews: [repositoryTitleLabel, starsCountLabel])
        stack.axis = .vertical
        addSubview(stack)
        addSubview(isBiggerLabel)
        
        profileImageView.centerY(inView: self, leftAnchor: leftAnchor, paddingLeft: 10)
        stack.centerY(inView: self, leftAnchor: profileImageView.rightAnchor, paddingLeft: 10)
        isBiggerLabel.centerY(inView: self)
        isBiggerLabel.anchor(right: rightAnchor, paddingRight: 10)
        stack.anchor(right: isBiggerLabel.leftAnchor, paddingRight: 5)
    }
    
}
