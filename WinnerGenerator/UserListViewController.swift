//
//  UserListViewController.swift
//  WinnerGenerator
//
//  Created by kmjmarine on 2022/02/09.
//

import UIKit
import Kingfisher
import FirebaseDatabase

final class UserListViewController: UITableViewController {
    var ref: DatabaseReference! //Firebase RealTime Database를 가져오는 레퍼런스 선언
    
    var userList: [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //UITableView Cell Register
        let nibName = UINib(nibName: "UserListCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "UserListCell")
        
        ref = Database.database().reference()
        ref.observe(.value) { snapshot in
            guard let value = snapshot.value as? [String: [String: Any]] else { return }
            
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: value)
                let userData = try JSONDecoder().decode([String: User].self, from: jsonData)
                let userList = Array(userData.values)
                self.userList = userList.sorted{ $0.rank < $1.rank }
         
                //view갱신은 메인 스레드에서 해야함
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch let error {
                print("ERROR JSON Parsing \(error.localizedDescription)")
            }
        }
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
        return 120
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //상세화면 전달
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let detailViewController = storyboard.instantiateViewController(identifier: "UserDetailViewController") as? UserDetailViewController else { return }
   
        detailViewController.userDetail = userList[indexPath.row]
        self.show(detailViewController, sender: nil)
    }
}
