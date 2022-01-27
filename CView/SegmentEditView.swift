//
//  SegmentEditView.swift
//  CView
//
//  Created by jurgitonas on 1/23/22.
//

import SwiftUI

struct SegmentEditView: View {
    @Binding var data: CV.Data
    let elementsIndex: Int
    @State private var newSegmentPart = ""
    @State private var placeholderText = "New Part"

    var body: some View {
        Form {
            Section(header: Text("Contents")) {
                ForEach(data.segments[elementsIndex].parts, id: \.self) { part in
                    Text(part)
                }
                .onDelete { indices in
                    data.segments[elementsIndex].parts.remove(atOffsets: indices )
                }
                ZStack {
                    if newSegmentPart.isEmpty {
                        TextEditor(text: $placeholderText)
                            .disabled(true)
                            .foregroundColor(Color(UIColor.placeholderText))
                    }
                    TextEditor(text: $newSegmentPart)
                }
                Button(action: {
                    withAnimation {
                        let part = newSegmentPart
                        data.segments[elementsIndex].parts.append(part)
                        newSegmentPart = ""
                    }
                }) {
                    Image(systemName: "plus.circle.fill")
                        .accessibilityLabel("Add Part")
                }
                .disabled(newSegmentPart.isEmpty)
            }
            Section(header: Text("Looks")) {
                ThemePicker(selection: $data.segments[elementsIndex].theme)
            }
        }
    }
}

struct SegmentEditView_Previews: PreviewProvider {
    static var previews: some View {
        SegmentEditView(data: .constant(CV.sampleData[0].data), elementsIndex: 0)
            .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
    }
}
