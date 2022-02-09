//
//  UserListViewController.swift
//  WinnerGenerator
//
//  Created by kmjmarine on 2022/02/09.
//

import UIKit
import Kingfisher

final class UserListViewController: UITableViewController {
    var userList: [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //UITableView Cell Register
        let nibName = UINib(nibName: "UserListCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "UserListCell")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserListCell", for: indexPath) as? UserListCell else { return UITableViewCell() }
        
        cell.teamNameLabel.text = userList[indexPath.row].team
        cell.nickNameLabel.text = userList[indexPath.row].nickname
        cell.ageLabel.text = "\(userList[indexPath.row].age)세"
        
        //Kingfisher 사용 구문 (이미지를 다운로드 받지 않고 URL형태를 이미지로 보여줌)
        let imageURL = URL(string: userList[indexPath.row].imageURL)
        cell.userImageView.kf.setImage(with: imageURL)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
