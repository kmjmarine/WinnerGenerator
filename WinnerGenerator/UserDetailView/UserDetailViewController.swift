//
//  UserDetailViewController.swift
//  WinnerGenerator
//
//  Created by kmjmarine on 2022/02/09.
//

import UIKit
import Kingfisher

final class UserDetailViewController: UIViewController {
    var userDetail: User?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var teamLabel: UILabel!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var realNameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var winCountLabel: UILabel!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let detail = userDetail else { return }
        
        //Kingfisher 사용 구문 (이미지를 다운로드 받지 않고 URL형태를 이미지로 보여줌)
        let imageURL = URL(string: detail.imageURL)
        imageView.kf.setImage(with: imageURL)
        
        teamLabel.text = detail.team
        nickNameLabel.text = detail.nickname
        realNameLabel.text = detail.realname
        ageLabel.text = "\(detail.age)세"
        winCountLabel.text = "\(detail.wincount)회"
    }
}
