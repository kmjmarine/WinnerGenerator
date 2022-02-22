//
//  UserListCell.swift
//  WinnerGenerator
//
//  Created by kmjmarine on 2022/02/09.
//

import UIKit
import SnapKit
import Kingfisher

final class UserListCell: UITableViewCell {
    
    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.borderWidth = 1.0
        imageView.backgroundColor = .tertiaryLabel
        imageView.layer.borderColor = UIColor.quaternaryLabel.cgColor
        imageView.contentMode = .scaleAspectFit

        return imageView
    }()
    
    private lazy var teamLabel: UILabel = {
         let label = UILabel()
         label.textColor = .systemGray
         label.font = .systemFont(ofSize: 17.0, weight: .semibold)
         label.text = "전산팀"
         label.textAlignment = .left
         
         return label
     }()
    
    private lazy var ageLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.backgroundColor = .lightGray
        label.font = .systemFont(ofSize: 13.0, weight: .semibold)
        label.text = "0세"
        label.textAlignment = .left
        
        return label
    }()
    
    private lazy var nickNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 21.0, weight: .bold)
        label.text = "NoName"
        label.textAlignment = .left
        
        return label
    }()
    
    private lazy var detailView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.right")
        imageView.contentMode = .scaleAspectFit

        return imageView
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setUILayout()
    }
    
    func configure(with userList: User) {
        let imageURL = URL(string: userList.imageURL)
        profileImageView.kf.setImage(with: imageURL, placeholder: nil)
        teamLabel.text = userList.team
        ageLabel.text = " \(userList.age)세 "
        nickNameLabel.text = userList.nickname
    }
}

private extension UserListCell {
    func setUILayout() {
        layer.cornerRadius = 12.0
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 10
        
        backgroundColor = .systemBackground
        
        let horizonStackView1 = UIStackView(arrangedSubviews: [teamLabel, ageLabel, detailView])
        horizonStackView1.axis = .horizontal
        horizonStackView1.alignment = .center
        horizonStackView1.distribution = .fill
        horizonStackView1.spacing = 4.0
        
        let horizonStackView2 = UIStackView(arrangedSubviews: [nickNameLabel])
        horizonStackView2.axis = .horizontal
        horizonStackView2.alignment = .center
        //horizonStackView2.spacing = 4.0
        
        let verticalStackView = UIStackView(arrangedSubviews: [horizonStackView1, horizonStackView2])
        verticalStackView.axis = .vertical
        verticalStackView.spacing = 4.0
        
        [profileImageView, verticalStackView, detailView]
            .forEach { contentView.addSubview($0) }

        profileImageView.snp.makeConstraints {
            $0.top.equalTo(15.0)
            $0.leading.equalTo(20.0)
            $0.width.equalTo(50.0)
            $0.height.equalTo(profileImageView.snp.width)
        }
        
        verticalStackView.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.top)
            $0.leading.equalTo(profileImageView.snp.trailing).offset(8.0)
            $0.width.equalTo(100.0)
        }
        
        detailView.snp.makeConstraints {
            $0.width.equalTo(20.0)
            $0.height.equalTo(detailView.snp.width)
            $0.centerY.equalTo(profileImageView.snp.centerY)
            $0.right.equalTo(contentView.snp.right).offset(-20.0)
        }
    }
}


