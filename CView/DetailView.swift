//
//  DetailView.swift
//  CView
//
//  Created by jurgitonas on 1/17/22.
//

import SwiftUI

struct DetailView: View {
    @Binding var cv: CV
    @State private var data = CV.Data()
    @State private var isPresentingEditView = false

    var body: some View {
        List {
            Section(header: Text("Personal Information")) {
                Label(title: { Text(cv.birthday, style: .date) }, icon: { Image(systemName: "calendar") })
                if !cv.city.isEmpty {
                    Label("\(cv.city)", systemImage: "map")
                }
                if !cv.phone.isEmpty {
                    Label("\(cv.phone)", systemImage: "iphone")
                }
                if !cv.email.isEmpty {
                    Label("\(cv.email)", systemImage: "envelope")
                }
                if !cv.github.isEmpty {
                    Label {
                        Text("\(cv.github)")
                    } icon: {
                        Image("GitHub")
                            .scaleEffect(0.8)
                    }
                }
                if !cv.linkedin.isEmpty {
                    Label {
                        Text("\(cv.linkedin)")
                    } icon: {
                        Image("LinkedIn")
                            .scaleEffect(0.8)
                    }
                }
            }
            if !cv.about.isEmpty {
                Section(header: Text("Overview")) {
                    Text(cv.about)
                }
            }
            if !cv.segments.isEmpty {
                Section(header: Text("Contents")) {
                    ForEach(cv.segments.indices, id: \.self) { index in
                        NavigationLink(destination: SegmentView(cv: $cv, elementsIndex: index)) {
                            SegmentCardView(segment: cv.segments[index], theme: cv.segments[index].theme)
                        }
                        .listRowBackground(cv.segments[index].theme.mainColor)
                    }
                }
            }
            Section(header: Text("Looks")) {
                HStack {
                    Label("Theme", systemImage: "paintpalette")
                    Spacer()
                    Text(cv.theme.name)
                        .padding(4)
                        .foregroundColor(cv.theme.accentColor)
                        .background(cv.theme.mainColor)
                        .cornerRadius(4)
                }
                .accessibilityElement(children: .combine)
            }
        }
        .navigationTitle([cv.name, cv.surname].joined(separator: " "))
        .toolbar {
            Button("Edit") {
                isPresentingEditView = true
                data = cv.data
            }
        }
        .sheet(isPresented: $isPresentingEditView) {
            NavigationView {
                DetailEditView(data: $data)
                    .navigationTitle("\(cv.name) \(cv.surname)")
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") {
                                isPresentingEditView = false
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Done") {
                                isPresentingEditView = false
                                cv.update(from: data)
                            }
                        }
                    }
            }
        }
    }
}


struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailView(cv: .constant(CV.sampleData[0]))
                .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
        }
    }
}

