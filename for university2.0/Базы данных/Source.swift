//
//  Source.swift
//  for university2.0
//
//  Created by 123 on 11.04.23.
//

import Foundation
import UIKit

struct Contact {
    let name: String
    let image: UIImage
}
struct ImageName {
    static let person = "person"
    static let fillPerson = "person.fill"
}
struct Info {
    var number: String
    var city: String
    var status: String
    
    init(number: String, city: String, status: String) {
        self.number = number
        self.city = city
        self.status = status
    }
}

struct Information{
 static func studentInfo() -> [Info] {
        [
        Info(number: "+375 29 110 3100",city: "Бобруйск", status: "Студент"), //Днепр
        Info(number: "+375 29 321 0877", city: "Шклов", status: "Студент"), //Стас
        Info(number: "+375 29 247 8518", city: "Светлогорск", status: "Студент"), //Илья
        Info(number: "+375 29 377 1229", city: "Гомель", status: "Студент"), //Зимин
        Info(number: "+375 29 836 9712", city: "Комарин", status: "Студент"), //Шубенок
        Info(number: "+375 44 509 3059", city: "Речица", status: "Студент"), //Цыбук
        Info(number: "+375 29 337 2706", city: "Жлобин", status: "Студент"), //Староста
        Info(number: "+375 29 432 6789", city: "Гомель", status: "Студент"), //Лята
        Info(number: "+375 29 098 6543", city: "Гомель", status: "Студент"), //Прищепов
        Info(number: "+375 29 421 5431", city: "Гомель", status: "Студент"), //Любезный
        Info(number: "+375 33 982 7654", city: "Чечерск", status: "Студет"), //Лимонтов
        Info(number: "+375 44 590 0932", city: "Cветлогорск", status: "Студентка"), //Воробей
        Info(number: "+375 33 123 5678", city: "Гомель", status: "Студент"), //Турмович
        Info(number: "+375 29 765 8901", city: "Гомель", status: "Студент"), //Ярошевич
        Info(number: "+375 33 164 3216", city: "Калинковичи", status: "Студент"), //Жигарь
        Info(number: "+375 44 321 3216", city: "Минск", status: "Студент") //Я
        
        ]
    }
}
struct Source {
    static func makeContacts() -> [Contact] {
        [
            Contact(name: "Александр Днепровский", image: .init(systemName: ImageName.fillPerson)!),
            Contact(name: "Стас Печеньков", image: .init(systemName: ImageName.fillPerson)!),
            Contact(name: "Илья Михальцов", image: .init(systemName: ImageName.fillPerson)!),
            Contact(name: "Даниил Зимин", image: .init(systemName: ImageName.fillPerson)!),
            Contact(name: "Cергей Шубенок", image: .init(systemName: ImageName.fillPerson)! ),
            Contact(name: "Сергей Цыбук", image: .init(systemName: ImageName.fillPerson)!),
            Contact(name: "Даниил Фильченко", image: .init(systemName: ImageName.fillPerson)!),
            Contact(name: "Данил Ляточевский", image: .init(systemName: ImageName.fillPerson)!),
            Contact(name: "Иван Прищепов", image: .init(systemName: ImageName.fillPerson)!),
            Contact(name: "Дмитрий Любезный", image: .init(systemName: ImageName.fillPerson)!),
            Contact(name: "Дмитрий Лимонтов", image: .init(systemName: ImageName.fillPerson)!),
            Contact(name: "Екатерина Воробей", image: .init(systemName: ImageName.fillPerson)!),
            Contact(name: "Владислав Турмович", image: .init(systemName: ImageName.fillPerson)!),
            Contact(name: "Игорь Ярошевич", image: .init(systemName: ImageName.fillPerson)!),
            Contact(name: "Владислав Жигарь", image: .init(systemName: ImageName.fillPerson)!),
            Contact(name: "Владислав Перелыгин", image: .init(systemName: ImageName.fillPerson)!)
        ]
    }
}
