//
//  NewViewController.swift
//  for university2.0
//
//  Created by 123 on 11.04.23.
//

import UIKit

class ContactDetailsViewController: UIViewController {
    var contact: Info?
    var info: Info?
    var phoneNumberLabel = UILabel()
    var cityLabel = UILabel()
    var statusLabel = UILabel()
    let phoneNumberTextField = UITextField()
    let cityTextField = UITextField()
    let buttonTapped: UIButton = .init()
    
    init(contact: Info? = nil, info: Info? = nil, phoneNumberLabel: UILabel = UILabel(), cityLabel: UILabel = UILabel(), statusLabel: UILabel = UILabel()) {
        self.contact = contact
        self.info = info
        self.phoneNumberLabel = phoneNumberLabel
        self.cityLabel = cityLabel
        self.statusLabel = statusLabel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateLabels()
        buttonTepsed()
        view.backgroundColor = .white
        
        if let info = info {
            phoneNumberLabel.text = info.number
            cityLabel.text = info.city
            statusLabel.text = info.status
        }
        
        
        phoneNumberLabel.textColor = .black
        phoneNumberLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        phoneNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(phoneNumberLabel)
        NSLayoutConstraint.activate([
            phoneNumberLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50),
            phoneNumberLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            phoneNumberLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        cityLabel.textColor = .black
        cityLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(cityLabel)
        NSLayoutConstraint.activate([
            cityLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50),
            cityLabel.topAnchor.constraint(equalTo: phoneNumberLabel.bottomAnchor, constant: 20),
            cityLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        statusLabel.textColor = .black
        statusLabel.font = UIFont.systemFont(ofSize: 18,weight: .bold)
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(statusLabel)
        NSLayoutConstraint.activate([
            statusLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50),
            statusLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 20),
            statusLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    func updateLabels() {
        phoneNumberLabel.text = info?.number
        cityLabel.text = info?.city
        statusLabel.text = info?.status
    }
    func buttonTepsed() {
        view.addSubview(buttonTapped)
        buttonTapped.setTitle("Доб./Ред.", for: .normal)
        buttonTapped.layer.cornerRadius = 10
        buttonTapped.setTitleColor(.systemBlue, for: .normal)
        
        buttonTapped.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            buttonTapped.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            buttonTapped.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
        ])
        buttonTapped.addTarget(self, action: #selector(showEditInfoAlert), for: .touchUpInside)
    }
    @objc func showEditInfoAlert() {
        UIView.animate(withDuration: 0.1, animations: {
            self.buttonTapped.backgroundColor = .systemGray4
        }) { _ in
            UIView.animate(withDuration: 0.1) {
                self.buttonTapped.backgroundColor = .clear
            }
        }
        
        let alert = UIAlertController(title: "Добавить", message: nil, preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "Номер телефона"
            textField.text = self.info?.number
        }
        alert.addTextField { textField in
            textField.placeholder = "Город"
            textField.text = self.info?.city
        }
        alert.addTextField { textField in
            textField.placeholder = "Статус"
            textField.text = self.info?.status
        }
        
        alert.addAction(UIAlertAction(title: "Добавить/Редактировать", style: .default, handler: { [weak self, weak alert] _ in
            guard let self = self, let alert = alert else { return }
            let number = alert.textFields?[0].text ?? ""
            let city = alert.textFields?[1].text ?? ""
            let status = alert.textFields?[2].text ?? ""
            
            self.info = Info(number: number, city: city, status: status)
            self.updateLabels()
        }))
        
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
    
}
