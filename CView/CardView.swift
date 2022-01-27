//
//  CardView.swift
//  CView
//
//  Created by jurgitonas on 1/18/22.
//

import SwiftUI

struct CardView: View {
    let cv: CV
    private var birthday: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY.MM.dd"
        return dateFormatter.string(from: cv.birthday)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(cv.name) \(cv.surname)")
                .accessibilityAddTraits(.isHeader)
                .font(.headline)
            Label(birthday, systemImage: "calendar.circle")
                .font(.caption)
                .foregroundColor(cv.theme.accentColor.opacity(0.5))
            Spacer()
            VStack(alignment: .leading) {
                if !cv.city.isEmpty {
                    Label("\(cv.city)", systemImage: "map")
                }
                if !cv.phone.isEmpty {
                    Label("\(cv.phone)", systemImage: "iphone")
                }
                if !cv.email.isEmpty {
                    Label("\(cv.email)", systemImage: "envelope")
                }
            }
            .font(.caption)
            if !cv.about.isEmpty {
                Spacer()
                Divider()
                Text(cv.about)
                    .font(.caption)
            }
        }
        .padding()
        .foregroundColor(cv.theme.accentColor)
    }
}

struct CardView_Previews: PreviewProvider {
    static var cv = CV.sampleData[0]
    static var previews: some View {
        CardView(cv: cv)
            .background(cv.theme.mainColor)
            .previewLayout(.fixed(width: 400, height: 60))
            .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
    }
}
