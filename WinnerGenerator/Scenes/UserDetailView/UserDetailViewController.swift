//
//  UserDetailViewController.swift
//  WinnerGenerator
//
//  Created by kmjmarine on 2022/02/09.
//

import UIKit
import Kingfisher
import SnapKit
import SwiftUI

final class UserDetailViewController: UIViewController {
    var userDetail: User?
    var totalWinCount: Int?
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.borderWidth = 1.0
        imageView.backgroundColor = .tertiaryLabel
        imageView.layer.borderColor = UIColor.quaternaryLabel.cgColor
        imageView.contentMode = .scaleAspectFit

        return imageView
    }()
    
    private lazy var teamTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 20.0, weight: .bold)
        //label.text = "소속팀"
        label.textAlignment = .left
    
        let attributedString = NSMutableAttributedString(string: "")
            
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(systemName: "person.2.crop.square.stack")?.withRenderingMode(.alwaysTemplate).withTintColor(.systemBlue)
        imageAttachment.bounds = CGRect(x: 0, y: -2, width: 18, height: 18)
    
        attributedString.append(NSAttributedString(attachment: imageAttachment))
        attributedString.append(NSAttributedString(string: " 소속팀"))
    
        label.attributedText = attributedString
        label.sizeToFit()
        
        return label
    }()
    
    private lazy var teamLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 20.0, weight: .light)
        label.text = "전산팀"
        label.textAlignment = .left
         
        return label
    }()
    
    private lazy var nicknameTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 20.0, weight: .bold)
        //label.text = "닉네임"
        label.textAlignment = .left
        
        let attributedString = NSMutableAttributedString(string: "")
            
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(systemName: "person.text.rectangle")?.withRenderingMode(.alwaysTemplate).withTintColor(.systemBlue)
        imageAttachment.bounds = CGRect(x: 0, y: -2, width: 18, height: 18)
    
        attributedString.append(NSAttributedString(attachment: imageAttachment))
        attributedString.append(NSAttributedString(string: " 닉네임"))
    
        label.attributedText = attributedString
        label.sizeToFit()
         
        return label
    }()
    
    private lazy var nicknameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 20.0, weight: .light)
        label.text = "NoName"
        label.textAlignment = .left
        
        return label
    }()
    
    private lazy var realnameTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 20.0, weight: .bold)
        //label.text = "이름"
        label.textAlignment = .left
        
        let attributedString = NSMutableAttributedString(string: "")
        
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(systemName: "n.square")?.withRenderingMode(.alwaysTemplate).withTintColor(.systemBlue)
        imageAttachment.bounds = CGRect(x: 0, y: -2, width: 18, height: 18)
    
        attributedString.append(NSAttributedString(attachment: imageAttachment))
        attributedString.append(NSAttributedString(string: " 이름"))
    
        label.attributedText = attributedString
        label.sizeToFit()
         
        return label
    }()
    
    private lazy var realnameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 20.0, weight: .light)
        label.text = "홍길동"
        label.textAlignment = .left
        
        return label
    }()
    
    private lazy var ageTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 20.0, weight: .bold)
        //label.text = "나이"
        label.textAlignment = .left
        
        let attributedString = NSMutableAttributedString(string: "")
        
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(systemName: "waveform.path.ecg.rectangle")?.withRenderingMode(.alwaysTemplate).withTintColor(.systemBlue)
        imageAttachment.bounds = CGRect(x: 0, y: -2, width: 18, height: 18)
    
        attributedString.append(NSAttributedString(attachment: imageAttachment))
        attributedString.append(NSAttributedString(string: " 나이"))
    
        label.attributedText = attributedString
        label.sizeToFit()
         
         return label
    }()

    private lazy var ageLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 20.0, weight: .light)
        label.text = "0세"
        label.textAlignment = .left
        
        return label
    }()
    
    private lazy var winCountTitleLabel: UILabel = {
         let label = UILabel()
         label.textColor = .label
         label.font = .systemFont(ofSize: 20.0, weight: .bold)
        //label.text = "당첨횟수"
         label.textAlignment = .left
        
        let attributedString = NSMutableAttributedString(string: "")
        
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(systemName: "bolt.square")?.withRenderingMode(.alwaysTemplate).withTintColor(.systemBlue)
        imageAttachment.bounds = CGRect(x: 0, y: -2, width: 18, height: 18)
    
        attributedString.append(NSAttributedString(attachment: imageAttachment))
        attributedString.append(NSAttributedString(string: " 당첨횟수"))
    
        label.attributedText = attributedString
        label.sizeToFit()
         
         return label
    }()
    
    private lazy var winCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 20.0, weight: .light)
        label.text = "0회"
        label.textAlignment = .left
        
        return label
    }()
    
    private lazy var totalwinCountTitleLabel: UILabel = {
         let label = UILabel()
         label.textColor = .label
         label.font = .systemFont(ofSize: 20.0, weight: .bold)
         label.text = "당첨횟수"
         label.textAlignment = .left
         
         return label
    }()
    
    private lazy var totalWinCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 20.0, weight: .light)
        label.text = "0%"
        label.textAlignment = .left
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUILayout()
        
        guard let detail = userDetail else { return }
        
        //Kingfisher 사용 구문 (이미지를 다운로드 받지 않고 URL형태를 이미지로 보여줌)
        let imageURL = URL(string: detail.imageURL)
        imageView.kf.setImage(with: imageURL)
        
        teamLabel.text = detail.team
        nicknameLabel.text = detail.nickname
        realnameLabel.text = detail.realname
        ageLabel.text = "\(detail.age)세"
        winCountLabel.text = "\(detail.wincount)회"
        
        //당첨확률 double형 변환, 소숫점 아래 2자리까지 표시
        let winRate: Double = Double(detail.wincount) / Double(10.0) * 100
                
        totalWinCountLabel.text = "\(String(format: "%.2f", winRate))%"
    }
}

private extension UserDetailViewController {
    func setUILayout() {
        
        view.backgroundColor = .systemBackground
        view.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 0, right: 20)
        
        let titleStackView = UIStackView(arrangedSubviews: [teamTitleLabel, nicknameTitleLabel, realnameTitleLabel, ageTitleLabel, winCountTitleLabel])
        titleStackView.axis = .vertical
        titleStackView.alignment = .leading
        titleStackView.distribution = .fill
        titleStackView.spacing = 20.0
        
        let contentStackView = UIStackView(arrangedSubviews: [teamLabel, nicknameLabel, realnameLabel, ageLabel, winCountLabel])
        contentStackView.axis = .vertical
        contentStackView.alignment = .leading
        contentStackView.distribution = .fill
        contentStackView.spacing = 20.0
        
        let horizonStackView = UIStackView(arrangedSubviews: [titleStackView, contentStackView])
        horizonStackView.axis = .horizontal
        horizonStackView.alignment = .top
        horizonStackView.distribution = .fill
        horizonStackView.spacing = 10.0
        
        [imageView, horizonStackView].forEach {
            view.addSubview($0)
        }
        
        imageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(90.0)
            $0.width.equalTo(170.0)
            $0.height.equalTo(imageView.snp.width)
        }
        
        horizonStackView.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(90.0)
            $0.leading.equalToSuperview().offset(20.0)
            $0.width.equalTo(170.0)
            $0.height.equalTo(400.0)
        }
    }
}
