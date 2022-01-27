//
//  SegmentFooterView.swift
//  CView
//
//  Created by jurgitonas on 1/18/22.
//

import SwiftUI

struct SegmentFooterView: View {
    let elements: [CVSegments.Element]
    var previousAction: ()->Void
    var nextAction: ()->Void
    let elementsIndex: Int
    let elementPartsIndex: Int
    private var elementText: String {
        guard elements[elementsIndex].parts.count > 0 else { return "No parts yet" }
        return "\(elements[elementsIndex].title) \(elementPartsIndex + 1) of \(elements[elementsIndex].parts.count)"
    }

    var body: some View {
        VStack {
            if elements[elementsIndex].parts.count > 0 {
                HStack() {
                    Button(action: previousAction) {
                        Image(systemName: "backward.fill")
                    }
                    .accessibilityLabel("Previous Part")
                    Spacer()
                    Text(elementText)
                    Spacer()
                    Button(action: nextAction) {
                        Image(systemName: "forward.fill")
                    }
                    .accessibilityLabel("Next Part")
                }
            }
        }
        .padding([.bottom, .horizontal])
    }
}


struct SegmentFooterView_Previews: PreviewProvider {
    static var previews: some View {
        SegmentFooterView(elements: CV.sampleData[0].segments.elements, previousAction: {}, nextAction: {}, elementsIndex: 0, elementPartsIndex: 0)
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
    }
}

