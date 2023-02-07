//
//  MainViewController.swift
//  CallAPIExample
//
//  Created by imac-2437 on 2023/2/3.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var aqiTableView: UITableView!
    
    var aqiArray: [AQIResponse.Records] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        hideKeyboardWhenTapped()
                
    }
    
    func setupUI() {
        setupTableView()
        setupTextField()
        setupButton()
    }
    
    private func setupTableView() {
        aqiTableView.delegate = self
        aqiTableView.dataSource = self
        aqiTableView.register(UINib(nibName: "AQITableViewCell", bundle: nil),
                              forCellReuseIdentifier: AQITableViewCell.identifier)
    }
    
    private func setupTextField() {
        numberTextField.placeholder = "請輸入要查詢的筆數"
        numberTextField.keyboardType = .numberPad
        numberTextField.text = UserPreferences.shared.lastSearchNum
    }
    
    private func setupButton() {
        searchButton.setTitle("開始查詢", for: .normal)
    }
    
    @IBAction func searchBtnClicked(_ sender: UIButton) {
        guard let text = numberTextField.text, !text.isEmpty else {
            return
        }
        UserPreferences.shared.lastSearchNum = text
        NetworkManager.shared.requestData(limit: text.toInt()) { (response: ResponseResult<AQIResponse>) in
            switch response {
            case .success(let results):
                print(results.records)
                self.aqiArray = results.records
                DispatchQueue.main.async {
                    self.aqiTableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }

    }
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return aqiArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AQITableViewCell.identifier,
                                                       for: indexPath) as? AQITableViewCell else {
            fatalError("AQITableViewCell Load Failed!")
            
        }
        
        cell.setInit(conty: aqiArray[indexPath.row].county + aqiArray[indexPath.row].sitename,
                     status: aqiArray[indexPath.row].status,
                     aqi: aqiArray[indexPath.row].aqi.toInt())
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let nextVC = DetailViewController()
        UserPreferences.shared.city = aqiArray[indexPath.row].county + aqiArray[indexPath.row].sitename
        UserPreferences.shared.status = aqiArray[indexPath.row].status
        UserPreferences.shared.aqi = aqiArray[indexPath.row].aqi.toInt()
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
