//
//  UserListViewController.swift
//  WinnerGenerator
//
//  Created by kmjmarine on 2022/02/09.
//

import UIKit
import Kingfisher
import FirebaseDatabase
import SnapKit

final class UserListViewController: UITableViewController {
// 리프래쉬 TODO 지하철 정보 앱 참조
//    private lazy var refreshControl: UIRefreshControl = {
//        let refreshControl = UIRefreshControl()
//        refreshControl.addTarget(self, action: #selector(fetchData), for: .valueChanged)
//
//        return refreshControl
//    }()
    
    var ref: DatabaseReference! //Firebase RealTime Database를 가져오는 레퍼런스 선언
    
    var userList: [User] = []
    var totalWinCount: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNaviagtionBar()
        
        tableView.register(UserListCell.self, forCellReuseIdentifier: "UserListCell")
        tableView.rowHeight = 80
        
        ref = Database.database().reference()
        ref.observe(.value) { snapshot in
            guard let value = snapshot.value as? [String: Any] else { return }
            
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: value)
                let userData = try JSONDecoder().decode([String: User].self, from: jsonData)
                let userList = Array(userData.values)
                self.userList = userList.sorted{ $0.rank < $1.rank }
                
                //총 당첨수 구하기
                for i in 0...(userList.count - 1) {
                    self.totalWinCount = self.totalWinCount + self.userList[i].wincount
                }
         
                //view갱신은 메인 스레드에서 해야함
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch let error {
                print("ERROR JSON Parsing \(error.localizedDescription)")
            }
        }
    }
}

private extension UserListViewController {
    func setNaviagtionBar() {
        navigationItem.title = "참여자 정보"
        
        //rightBarButtonItem 추가 영역
        let rightButton = UIBarButtonItem(
            image: UIImage(systemName: "ellipsis"), style: .plain, target: self, action: nil
        )
        
        navigationItem.rightBarButtonItem = rightButton
    }
}

extension UserListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserListCell", for: indexPath) as? UserListCell else { return UITableViewCell() }
        
        let userList = userList[indexPath.row]
        cell.configure(with: userList)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedUser = userList[indexPath.row]
        let detailViewContoller = UserDetailViewController()
        
        detailViewContoller.userDetail = selectedUser
        self.show(detailViewContoller, sender: totalWinCount)
    }
}

