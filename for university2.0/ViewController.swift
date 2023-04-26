//
//  ViewController.swift
//  for university2.0
//
//  Created by 123 on 11.04.23.
//

import UIKit

class ViewController: UIViewController{

    var contacts = Source.makeContacts()
    var allInfo = Information.studentInfo()
    let tableView: UITableView = .init()
    let titleLabel: UILabel = .init()
    let setupButton: UIButton = .init()
    var sortedButton: UIButton = .init()
    var searchBar: UISearchBar = .init()
    var filteredContacts: [Contact] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupTitleLabel()
        tableView.register(ContactCell.self, forCellReuseIdentifier: "ContactCell")
        tableView.delegate = self
        setupButtonTapped()
        tableView.dataSource = self
        searchBar.delegate = self
        searchString()
        
        
    }

}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredContacts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath) as? ContactCell
        else {fatalError()}
        
        cell.configure(contact: contacts[indexPath.row])
        
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        filteredContacts.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .left)
    }
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let sortedPerson = contacts.remove(at: sourceIndexPath.row)
        contacts.insert(sortedPerson, at: destinationIndexPath.row)
        tableView.reloadData()
    }
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let searchText = (searchBar.text! as NSString).replacingCharacters(in: range, with: text)
        if searchText.isEmpty {
            tableView.reloadData()
        }
        return true
    }
    func searchBar(_ searchBar: UISearchBar, shouldReloadTableForSearchScope searchOption: Int) -> Bool {
        filterContentForSearchText(searchBar.text!)
        return true
    }
    func filterContentForSearchText(_ searchText: String) {
        filteredContacts = contacts.filter({ (contact: Contact) -> Bool in
            return contact.name.lowercased().contains(searchText.lowercased())
        })
        tableView.reloadData()
    }
}

extension ViewController {
    func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            
        ])
    }
    func setupTitleLabel() {
        view.addSubview(titleLabel)
                titleLabel.translatesAutoresizingMaskIntoConstraints = false
                titleLabel.text = "PhoneBook"
                titleLabel.font = UIFont.systemFont(ofSize: 28, weight: .bold)
                titleLabel.textColor = .black
        titleLabel.backgroundColor = .white
                NSLayoutConstraint.activate([
                    titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                    titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                    titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 50)
                ])
        tableView.contentInset = UIEdgeInsets(top: 100, left: 0, bottom: 0, right: 0)// это то что нам позволяет установить отступы в таблице
    
}
    func setupButtonTapped() {
        view.addSubview(setupButton)
        setupButton.setTitle("Добавить", for: .normal)
                setupButton.layer.cornerRadius = 10
        setupButton.setTitleColor(.systemBlue, for: .normal)
        
        setupButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            setupButton.topAnchor.constraint(equalTo: titleLabel.topAnchor),
            setupButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
        ])
        setupButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    }
    @objc func buttonAction() {
        UIView.animate(withDuration: 0.1, animations: {
               self.setupButton.backgroundColor = .systemGray4
           }) { _ in
               UIView.animate(withDuration: 0.1) {
                   self.setupButton.backgroundColor = .clear
               }
           }
            let alertController = UIAlertController(title: "Добавить нового пользователя", message: nil, preferredStyle: .alert)
            alertController.addTextField { (textField) in
                textField.placeholder = "Имя пользователя"
            }
            let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
            let addAction = UIAlertAction(title: "Добавить", style: .default) { [self] (_) in
                guard let name = alertController.textFields?[0].text, !name.isEmpty else { return }
                let newContact = Contact(name: name, image: UIImage(systemName: ImageName.fillPerson)!)
                contacts.insert(newContact, at: 0)
                tableView.reloadData()
                
            }
            alertController.addAction(cancelAction)
            alertController.addAction(addAction)
            present(alertController, animated: true, completion: nil)
        }

}
extension ViewController {
    func searchString() {
        searchBar.searchBarStyle = UISearchBar.Style.prominent
        searchBar.placeholder = "Search"
        searchBar.sizeToFit()
        searchBar.layer.borderColor = UIColor.systemBlue.cgColor
        navigationItem.titleView = searchBar
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(searchBar)
        NSLayoutConstraint.activate([
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
                        searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
                        searchBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
                        searchBar.heightAnchor.constraint(equalToConstant: 50),
                        searchBar.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
    }
    func filterContacts(with searchText: String) {
        filteredContacts = searchText.isEmpty ? contacts : contacts.filter { (contact: Contact) -> Bool in
            return contact.name.range(of: searchText, options: .caseInsensitive) != nil
        }
        tableView.reloadData()
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.2, animations: {
                    tableView.cellForRow(at: indexPath)?.backgroundColor = .systemGray
                }) { (completed) in
                    UIView.animate(withDuration: 0.1) {
                        tableView.cellForRow(at: indexPath)?.backgroundColor = .white
                    }
                }
        let contactDetailsVC = ContactDetailsViewController()
        contactDetailsVC.contact = allInfo[indexPath.row]
        if indexPath.row < contacts.count {
            contactDetailsVC.info = Info.infoForStudent(name: contacts[indexPath.row].name)
        }else{
            fatalError()
        }
        present(contactDetailsVC, animated: true)
    }

}

extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterContacts(with: searchText)
        if searchText.isEmpty {
            filteredContacts = contacts
            tableView.reloadData()
        }
    }
}

extension Info {
    static func infoForStudent(name: String) -> Info {
        switch name {
        case "Александр Днепровский":
            return Info(number: "+375 29 110 3100", city: "Бобруйск", status: "Студент")
        case "Стас Печеньков":
            return Info(number: "+375 29 321 0877", city: "Шклов", status: "Студент")
        case "Илья Михальцов":
            return Info(number: "+375 29 247 8518", city: "Светлогорск", status: "Студент")
        case "Даниил Зимин":
            return Info(number: "+375 29 377 1229", city: "Гомель", status: "Студент")
        case "Cергей Шубенок":
            return Info(number: "+375 29 836 9712", city: "Комарин", status: "Студент")
        case "Сергей Цыбук":
            return Info(number: "+375 44 509 3059", city: "Речица", status: "Студент")
        case "Даниил Фильченко":
            return Info(number: "+375 29 337 2706", city: "Жлобин", status: "Студент")
        case "Данил Ляточевский":
            return Info(number: "+375 29 432 6789", city: "Гомель", status: "Студент")
        case "Иван Прищепов":
            return Info(number: "+375 29 098 6543", city: "Гомель", status: "Студент")
        case "Дмитрий Любезный":
            return Info(number: "+375 29 421 5431", city: "Гомель", status: "Студент")
        case "Дмитрий Лимонтов":
            return Info(number: "+375 33 982 7654", city: "Чечерск", status: "Студент")
        case "Екатерина Воробей":
            return Info(number: "+375 44 590 0932", city: "Светлогорск", status: "Студентка")
        case "Владислав Турмович":
            return Info(number: "+375 33 123 5678", city: "Гомель", status: "Студент")
        case "Игорь Ярошевич":
            return Info(number: "+375 29 765 8901", city: "Гомель", status: "Студент")
        case "Владислав Жигарь":
            return Info(number: "+375 33 164 3655", city: "Калинковичи", status: "Студент")
        case "Владислав Перелыгин":
            return Info(number: "+375 44 321 3216", city: "Минск", status: "Студент")
        default:
            return Info(number: "", city: "", status: "")
        }
    }
}
