//
//  mainViewController.swift
//  QuotesGenerator
//
//  Created by kmjmarine on 2022/02/06.
//

import UIKit
import SnapKit
import FirebaseDatabase
import Charts
import SwiftUI

class mainViewController: UIViewController {
    var ref: DatabaseReference! //Firebase RealTime Database를 가져오는 레퍼런스 선언
    
    var userList: [User] = []
    
    //메인 뷰 영역
    lazy var mainView: mainView = {
        return WinnerGenerator.mainView(frame: self.view.bounds)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNaviagtionBar()
        view = mainView
        
        ref = Database.database().reference()
        ref.observe(.value) { snapshot in
            guard let value = snapshot.value as? [String: Any] else { return }
            
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: value)
                let userData = try JSONDecoder().decode([String: User].self, from: jsonData)
                let userList = Array(userData.values)
                self.userList = userList
                
                self.configureChartView(userList: userList)
            } catch let error {
                print("ERROR JSON Parsing \(error.localizedDescription)")
            }
        }
        
        mainView.winnerButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    @objc func didTapButton() {
        let random = Int.random(in: 0...4) //0 ~ 4 사이의 난수를 발생
        let user = self.userList[random]
        let url = URL(string: user.imageURL)
        let currentWinCount = user.wincount

        mainView.winnerLabel.text = ("\(user.nickname) 님 당첨을 축하합니다.")
        mainView.winnerInfoLabel.text = ("\(user.team) \(user.realname) (\(user.age)세)")

        do {
            let data = try Data(contentsOf: url!)
            mainView.winnerImageView.image = UIImage(data: data)
        } catch let error {
            print("ERROR Image Parsing \(error.localizedDescription)")
        }
        //당첨횟수 +1
        self.ref.child("Item\(user.id)/wincount").setValue(currentWinCount + 1)
    }
    
    func configureChartView(userList: [User]) {
        let entries = userList.compactMap { [weak self] userinfo -> PieChartDataEntry? in
            guard let self = self else { return nil } //일시적으로 self가 strong method가 되게 함.
            
            return PieChartDataEntry(
                value: Double(userinfo.wincount),
                label: userinfo.nickname,
                data: nil
            )
        }
        
        let dataSet = PieChartDataSet(entries: entries, label: "누적 당첨 현황")
        dataSet.sliceSpace = 1
        dataSet.entryLabelColor = .label
        dataSet.valueTextColor = .label
        dataSet.xValuePosition = .outsideSlice
        dataSet.valueLinePart1OffsetPercentage = 0.8
        dataSet.valueLinePart1Length = 0.2
        dataSet.valueLinePart2Length = 0.3
        
        dataSet.colors = ChartColorTemplates.vordiplom() +
        ChartColorTemplates.joyful() +
        ChartColorTemplates.liberty() +
        ChartColorTemplates.pastel() +
        ChartColorTemplates.material()
        
        mainView.pieChartView.data = PieChartData(dataSet: dataSet)
        mainView.pieChartView.spin(duration: 0.3, fromAngle: mainView.pieChartView.rotationAngle, toAngle: mainView.pieChartView.rotationAngle + 80)
    }
}

private extension mainViewController {
    func setNaviagtionBar() {
        navigationItem.title = "당첨자 추첨기"
        
        //rightBarButtonItem 추가 영역
    }
}


