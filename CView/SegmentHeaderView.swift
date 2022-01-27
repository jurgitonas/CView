//
//  SegmentHeaderView.swift
//  CView
//
//  Created by jurgitonas on 1/19/22.
//

import SwiftUI

struct SegmentHeaderView: View {
    @EnvironmentObject var cvSegments: CVSegments
    let elementsIndex: Int
    let elementsTotal: Int
    let theme: Theme

    private var progress: Double {
        guard elementsTotal > 0 else { return 1 }
        return Double(elementsIndex + 1) / Double(elementsTotal)
    }

    var body: some View {
        VStack {
            if elementsTotal > 0 {
                ProgressView(value: progress)
                    .progressViewStyle(CVProgressViewStyle(theme: theme))
                HStack {
                    VStack(alignment: .leading) {
                        Text("\(elementsIndex + 1) Viewed")
                            .font(.caption)
                    }
                    Spacer()
                    VStack(alignment: .trailing) {
                        Text("Remaining \(elementsTotal - elementsIndex - 1)")
                            .font(.caption)
                    }
                }
            }
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("Elements remaining")
        .accessibilityValue("\(elementsTotal - elementsIndex - 1) elements")
        .padding([.top, .horizontal])
    }
}

struct MeetingHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        SegmentHeaderView(elementsIndex: 0, elementsTotal: 5, theme: .bubblegum)
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
    }
}
