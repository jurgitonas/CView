//
//  SegmentCardView.swift
//  CView
//
//  Created by jurgitonas on 1/20/22.
//

import SwiftUI

struct SegmentCardView: View {
    var segment: CV.Segment
    var theme: Theme
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(segment.title)
                .accessibilityAddTraits(.isHeader)
                .font(.headline)
        }
        .foregroundColor(theme.accentColor)
    }
}

struct SegmentCardView_Previews: PreviewProvider {
    static var segment = CV.sampleData[0].segments[0]
    static var theme: Theme { return .bubblegum }
    static var previews: some View {
        SegmentCardView(segment: segment, theme: theme)
            .background(theme.mainColor)
            .previewLayout(.fixed(width: 400, height: 60))
            .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
    }
}
