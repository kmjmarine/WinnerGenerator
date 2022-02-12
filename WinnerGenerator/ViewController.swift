//
//  ViewController.swift
//  QuotesGenerator
//
//  Created by kmjmarine on 2022/02/06.
//

import UIKit
import SnapKit
import FirebaseDatabase
import Charts

class ViewController: UIViewController {
    var ref: DatabaseReference! //Firebase RealTime Database를 가져오는 레퍼런스 선언
    
    var userList: [User] = []
    
    @IBOutlet weak var winnerLabel: UILabel!
    @IBOutlet weak var winnerInfoLabel: UILabel!
    @IBOutlet weak var winnerImageView: UIImageView!
    @IBOutlet weak var winnerButton: UIButton!
    @IBOutlet weak var pieChartView: PieChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setButtonLayout()
        
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
        
        self.pieChartView.data = PieChartData(dataSet: dataSet)
        self.pieChartView.spin(duration: 0.3, fromAngle: self.pieChartView.rotationAngle, toAngle: self.pieChartView.rotationAngle + 80)
    }

    @IBAction func tabGetWinner(_ sender: UIButton){
        let random = Int.random(in: 0...4) //0 ~ 4 사이의 난수를 발생
        let user = self.userList[random]
        let url = URL(string: user.imageURL)
        let currentWinCount = user.wincount
        
        self.winnerLabel.text = ("\(user.nickname) 님 당첨을 축하합니다.")
        self.winnerInfoLabel.text = ("\(user.team) \(user.realname) (\(user.age)세)")
        
        do {
            let data = try Data(contentsOf: url!)
            winnerImageView.image = UIImage(data: data)
        } catch let error {
            print("ERROR Image Parsing \(error.localizedDescription)")
        }
        //당첨횟수 +1
        self.ref.child("Item\(user.id)/wincount").setValue(currentWinCount + 1)
    }
}

extension ViewController {
    func setButtonLayout() {
        winnerButton.backgroundColor = .lightGray
        winnerButton.layer.borderWidth = 1.0
        winnerButton.layer.borderColor = UIColor.black.cgColor
        winnerButton.layer.cornerRadius = 4.0
        winnerButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(25.0)
        }
        
        //winnerImageView.backgroundColor = .red
        winnerImageView.layer.cornerRadius = winnerImageView.frame.size.width / 2
        winnerImageView.clipsToBounds = true
    }
}

