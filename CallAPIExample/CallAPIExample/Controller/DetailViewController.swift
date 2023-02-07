//
//  DetailViewController.swift
//  CallAPIExample
//
//  Created by imac-2437 on 2023/2/3.
//

import UIKit

class DetailViewController: UIViewController {

    
    @IBOutlet weak var contyLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var aqiLabel: UILabel!
    @IBOutlet weak var aqiTitleLabel: UILabel!
    @IBOutlet weak var impactTitleLabel: UILabel!
    @IBOutlet weak var impactBodyLabel: UILabel!
    @IBOutlet weak var adviceTitleLabel: UILabel!
    @IBOutlet weak var adviceBodyLabel: UILabel!
    
    enum Detail {
        case great, good, normal, fair, bad ,worst
        
        var color: UIColor {
            switch self {
            case .great:
                return .systemGreen
            case .good:
                return .systemYellow
            case .normal:
                return .systemOrange
            case .fair:
                return .systemRed
            case .bad:
                return .systemPurple
            case .worst:
                return UIColor(red: CGFloat(188/255), green: CGFloat(143/255), blue: CGFloat(143/255), alpha: 1)
            }
        }
        
        var impact: String {
            switch self {
            case .great:
                return "空氣品質令人滿意，基本無空氣污染"
            case .good:
                return "空氣品質可接受，但某些污染物可能對極少數異常敏感人群健康有較弱影響"
            case .normal:
                return "易感人群症狀有輕度加劇，健康人群出現刺激症狀"
            case .fair:
                return "進一步加劇易感人群症狀，可能對健康人群心臟、呼吸系統有影響"
            case .bad:
                return "心臟病和肺病患者症狀顯著加劇，運動耐受力降低，健康人群普遍出現症狀"
            case .worst:
                return "健康人群運動耐受力降低，有明顯強烈症狀，提前出現某些疾病"
            }
        }
        
        var advice: String {
            switch self {
            case .great:
                return "各類人群可正常活動"
            case .good:
                return "極少數異常敏感人群應減少戶外活動"
            case .normal:
                return "兒童、老年人及心臟病、呼吸系統疾病患者應減少長時間、高強度的戶外鍛鍊"
            case .fair:
                return "進一步加劇易感人群症狀，可能對健康人群心臟、呼吸系統有影響"
            case .bad:
                return "兒童、老年人及心臟病、呼吸系統疾病患者應停留在室內，停止戶外活動，一般人群應避免戶外活動"
            case .worst:
                return "兒童、老年人及心臟病、呼吸系統疾病患者應停留在室內，避免體力消耗，一般人群應避免戶外活動"
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    func setupUI() {
        setupLabel()
    }
    
    private func setupLabel() {
        contyLabel.text = "城市: " + UserPreferences.shared.city
        statusLabel.text = "狀態: " + UserPreferences.shared.status
        aqiTitleLabel.text = "aqi數值:"
        aqiLabel.text = "\(UserPreferences.shared.aqi)"
        impactTitleLabel.text = "對健康的影響"
        adviceTitleLabel.text = "建議採取的措施"
        setupOtherLabel(aqi: UserPreferences.shared.aqi)
    }
    
    private func setupOtherLabel(aqi: Int) {
        switch aqi {
        case 0...50:
            aqiLabel.backgroundColor = Detail.great.color
            impactBodyLabel.text = Detail.great.impact
            adviceBodyLabel.text = Detail.great.advice
        case 51...100:
            aqiLabel.backgroundColor = Detail.good.color
            impactBodyLabel.text = Detail.good.impact
            adviceBodyLabel.text = Detail.good.advice
        case 101...150:
            aqiLabel.backgroundColor = Detail.normal.color
            impactBodyLabel.text = Detail.normal.impact
            adviceBodyLabel.text = Detail.normal.advice
        case 151...200:
            aqiLabel.backgroundColor = Detail.fair.color
            impactBodyLabel.text = Detail.fair.impact
            adviceBodyLabel.text = Detail.fair.advice
        case 201...300:
            aqiLabel.backgroundColor = Detail.bad.color
            impactBodyLabel.text = Detail.bad.impact
            adviceBodyLabel.text = Detail.bad.advice
        case _ where aqi > 300:
            aqiLabel.backgroundColor = Detail.worst.color
            impactBodyLabel.text = Detail.worst.impact
            adviceBodyLabel.text = Detail.worst.advice
        default:
            break
        }
    }


}
