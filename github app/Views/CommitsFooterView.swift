//
//  CommitsFooterView.swift
//  github app
//
//  Created by Karol Korzeń on 12/12/2020.
//

import UIKit

protocol FooterDelegate: class{
    func shareRepo()
}

class CommitsFooterView: UIView{
    
    //MARK: - Properties
    
    weak var delegate: FooterDelegate?
    let shareImage = UIImageView(image: UIImage(named: "shareIcon")!)
    let shareText = Utilities.shared.standardLabel(withSize: 17, withWeight: .semibold, withColor: UIColor.rgb(red: 0, green: 122, blue: 255))
    private lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.rgb(red: 242, green: 242, blue: 247)
        button.layer.cornerRadius = 10
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        button.isUserInteractionEnabled = true
        return button
    }()
    
    //MARK: - Lifecycle
    
    override init (frame: CGRect){
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Selectors
    
    @objc func shareTapped(){
        delegate?.shareRepo()
    }
    
    //MARK: - Helpers
    
    func configureUI(){
        addSubview(button)
        button.setImage(shareImage.image, for: .normal)
        button.setTitle("Share Repo", for: .normal)
        button.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 24, paddingLeft: 16, paddingRight: 16, height: 50)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 9, bottom: 0, right: 0)
        button.addTarget(self, action: #selector(shareTapped), for: .touchUpInside)
    }
}
