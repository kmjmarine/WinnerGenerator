//
//  ViewController.swift
//  QuotesGenerator
//
//  Created by kmjmarine on 2022/02/06.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    @IBOutlet weak var winnerLabel: UILabel!
    @IBOutlet weak var winnerInfoLabel: UILabel!
    @IBOutlet weak var winnerButton: UIButton!
    
    let users = [
        Users(teamName: "IT팀", nickName: "Aeron", realName: "김민재", age: 45),
        Users(teamName: "IT팀", nickName: "River", realName: "이성진", age: 44),
        Users(teamName: "IT팀", nickName: "Sap", realName: "김원근", age: 32),
        Users(teamName: "IT팀", nickName: "Jaden", realName: "강영학", age: 32),
        Users(teamName: "IT팀", nickName: "Jeff", realName: "강민재", age: 32)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        winnerButton.backgroundColor = .lightGray
        winnerButton.layer.borderWidth = 1.0
        winnerButton.layer.borderColor = UIColor.black.cgColor
        winnerButton.layer.cornerRadius = 4.0
        winnerButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(25.0)
        }
    }

    @IBAction func tabGetWinner(_ sender: UIButton){
        let random = Int.random(in: 0...4) //0 ~ 4 사이의 난수를 발생
        let user = users[random]
        
        self.winnerLabel.text = ("\(user.nickName) 님 당첨을 축하합니다.")
        self.winnerInfoLabel.text = ("\(user.teamName) \(user.realName) (\(user.age)세)")
    }
}

