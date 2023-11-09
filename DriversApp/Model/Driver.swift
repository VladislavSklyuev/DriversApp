//
//  Driver.swift
//  FirstGradProject2
//
//  Created by Владислав Склюев on 01.08.2023.
//

import Foundation
import FirebaseFirestore

struct Driver: Identifiable, Hashable {
    var id: String = UUID().uuidString
    var surname: String
    var name: String
    var lastname: String
    var birthDay: Date
    var numberPhone: String
    var numberDriverLicense: String
    var dateOfdriverLic: Date
    var driverLicExpDate: Date
    var raiting: Double
    
    
//    var dateOfdriverLic: String
//    var driverLicExpDate: String

}

//extension Driver {
//    static var drivers: [Driver] = [Driver(surname: "Николаев", name: "Николай", lastname: "Николаевич")]
//}


extension Driver {
    init?(snapshot: QueryDocumentSnapshot) {
        let data = snapshot.data()
        guard let id = data["id"] as? String,
              let surname = data["surname"] as? String,
              let name = data["name"] as? String,
              let numberPhone = data["numberPhone"] as? String,
              let lastname = data["lastname"] as? String,
              let numberDriverLicense = data["numberDriverLicense"] as? String,
              let birthDay = data["birthDay"] as? Timestamp,
              let dateOfdriverLic = data["dateOfdriverLic"] as? Timestamp,
              let driverLicExpDate = data["driverLicExpDate"] as? Timestamp,
              let raiting = data["raiting"] as? Double else { return nil }
                
              
        self.id = id
        self.surname = surname
        self.name = name
        self.lastname = lastname
        self.numberPhone = numberPhone
        self.numberDriverLicense = numberDriverLicense
        self.raiting = raiting
        self.birthDay = birthDay.dateValue()
        self.dateOfdriverLic = dateOfdriverLic.dateValue()
        self.driverLicExpDate = driverLicExpDate.dateValue()
        
    }
}

extension Driver {
    var representation: [String: Any] {
        var repres = [String: Any]()
        repres["id"] = id
        repres["surname"] = surname
        repres["name"] = name
        repres["lastname"] = lastname
        repres["numberPhone"] = numberPhone
        repres["numberDriverLicense"] = numberDriverLicense
        repres["raiting"] = raiting
        repres["birthDay"] = Timestamp(date: birthDay)
        repres["dateOfdriverLic"] = Timestamp(date: dateOfdriverLic)
        repres["driverLicExpDate"] = Timestamp(date: driverLicExpDate)
        return repres
    }
}
