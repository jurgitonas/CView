//
//  DetailEditView.swift
//  CView
//
//  Created by jurgitonas on 1/18/22.
//

import SwiftUI

struct DetailEditView: View {
    @Binding var data: CV.Data
    @State private var newSegmentTitle = ""

    var body: some View {
        Form {
            Section(header: Text("Personal Information")) {
                TextField("Name", text: $data.name)
                TextField("Surname", text: $data.surname)
                DatePicker("Birthday", selection: $data.birthday, in: ...Date(), displayedComponents: .date)
                TextField("City", text: $data.city)
                TextField("Phone", text: $data.phone)
                TextField("Email", text: $data.email)
                    .autocapitalization(.none)
            }
            Section(header: Text("Overview")) {
                TextEditor(text: $data.about)
            }
            Section(header: Text("Contents")) {
                ForEach(data.segments) { segment in
                    Text(segment.title)
                }
                .onDelete { indices in
                    data.segments.remove(atOffsets: indices )
                }
                HStack {
                    TextField("New Title", text: $newSegmentTitle)
                }
                Button(action: {
                    withAnimation {
                        let segment = CV.Segment(title: newSegmentTitle, parts: [], theme: .oxblood)
                        data.segments.append(segment)
                        newSegmentTitle = ""
                    }
                }) {
                    Image(systemName: "plus.circle.fill")
                        .accessibilityLabel("Add Segment")
                }
                .disabled(newSegmentTitle.isEmpty)
            }
            Section(header: Text("Looks")) {
                ThemePicker(selection: $data.theme)
            }
        }
    }
}

struct DetailEditView_Previews: PreviewProvider {
    static var previews: some View {
        DetailEditView(data: .constant(CV.sampleData[0].data))
            .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
    }
}
