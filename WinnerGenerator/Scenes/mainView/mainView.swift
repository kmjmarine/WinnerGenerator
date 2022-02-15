//
//  mainView.swift
//  WinnerGenerator
//
//  Created by kmjmarine on 2022/02/13.
//

import UIKit
import SnapKit
import Charts

final class mainView: UIView {
    lazy var winnerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 40.0
        imageView.layer.borderWidth = 1.0
        imageView.layer.borderColor = UIColor.quaternaryLabel.cgColor
        //imageView.backgroundColor = .tertiaryLabel
        imageView.image = UIImage(systemName: "person")
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
   lazy var winnerLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 24.0, weight: .bold)
        label.text = "Aeron님 당첨을 축하합니다."
        label.textAlignment = .center
        
        return label
    }()
    
    lazy var winnerInfoLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 18.0, weight: .semibold)
        label.text = "IT팀 김민재 (45세)"
        
        return label
    }()
    
    lazy var winnerButton: UIButton = {
       let button = UIButton()
        button.setTitle("당첨자 추첨", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18.0, weight: .semibold)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 3.0
       
        return button
    }()
    
    lazy var pieChartView: PieChartView = {
        let chartView = PieChartView()
        chartView.backgroundColor = .tertiaryLabel
        
        return chartView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUILayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension mainView {
    func setUILayout() {
        [winnerImageView, winnerLabel, winnerInfoLabel, winnerButton, pieChartView]
            .forEach { addSubview($0) }
        
        winnerImageView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(16.0)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(100.0)
            $0.height.equalTo(winnerImageView.snp.width)
        }
        
        winnerLabel.snp.makeConstraints {
            //$0.leading.equalToSuperview().inset(24.0)
            $0.top.equalTo(winnerImageView.snp.bottom).offset(14.0)
            $0.width.equalToSuperview()
            $0.height.equalTo(20.0)
        }
        
        winnerInfoLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(24.0)
            $0.top.equalTo(winnerLabel.snp.bottom).offset(60.0)
            $0.width.equalToSuperview()
            $0.height.equalTo(20.0)
        }
        
        winnerButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(24.0)
            $0.trailing.equalToSuperview().inset(24.0)
            $0.top.equalTo(winnerInfoLabel.snp.bottom).offset(20.0)
            $0.height.equalTo(40.0)
        }
        
        pieChartView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(24.0)
            $0.trailing.equalToSuperview().inset(24.0)
            $0.top.equalTo(winnerButton.snp.bottom).offset(20.0)
            $0.height.equalTo(400.0)
        }
    }
}
