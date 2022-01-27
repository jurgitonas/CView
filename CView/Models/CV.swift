//
//  CV.swift
//  CView
//
//  Created by jurgitonas on 1/17/22.
//

import Foundation

struct CV: Identifiable, Codable {
    let id: UUID
    var name: String
    var surname: String
    var birthday: Date
    var city: String
    var phone: String
    var email: String
    var about: String
    var segments: [Segment]
    var theme: Theme
    
    init(id: UUID = UUID(), name: String, surname: String, birthday: Date, city: String, phone: String, email: String, about: String, segments: [String], theme: Theme) {
        self.id = id
        self.name = name
        self.surname = surname
        self.birthday = birthday
        self.city = city
        self.phone = phone
        self.email = email
        self.about = about
        self.segments = segments.map { Segment (title: $0, parts: [], theme: .oxblood) }
        self.theme = theme
    }
}

extension CV {
    struct Segment: Identifiable, Codable {
        let id: UUID
        var title: String
        var parts: [String]
        var theme: Theme
        
        init(id: UUID = UUID(), title: String, parts: [String], theme: Theme) {
            self.id = id
            self.title = title
            self.parts = parts
            self.theme = theme
        }
    }
    
    struct Data {
        var name: String = ""
        var surname: String = ""
        var birthday: Date = Date()
        var city: String = ""
        var phone: String = ""
        var email: String = ""
        var about: String = ""
        var segments: [Segment] = []
        var theme: Theme = .seafoam
    }
    
    var data: Data {
        Data(name: name, surname: surname, birthday: birthday, city: city, phone: phone, email: email, about: about, segments: segments, theme: theme)
    }
    
    mutating func update(from data: Data) {
        name = data.name
        surname = data.surname
        birthday = data.birthday
        city = data.city
        phone = data.phone
        email = data.email
        about = data.about
        segments = data.segments
        theme = data.theme
    }
}

extension CV {
    static let sampleData: [CV] =
    [
        CV(name: "Cathy", surname: "Daisy", birthday: Date(), city: "New York", phone: "+987654321", email: "design@black.com", about: "About Text", segments: ["Design", "Simon", "Jonathan"], theme: .yellow),
        CV(name: "Katie", surname: "Gray", birthday: Date(), city: "Toronto", phone: "+123456789", email: "app@dev.com", about: "App Dev", segments: ["iOS", "macOS", "Multiplatform"], theme: .orange),
        CV(name: "Chris", surname: "Chad", birthday: Date(), city: "Los Angeles", phone: "+192837465", email: "web@dev.com", about: "Web Dev", segments: ["Full-Stack", "Front-End", "Back-End", "Frameworks"], theme: .poppy)
    ]
}
