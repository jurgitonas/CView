//
//  CVProgressViewStyle.swift
//  CView
//
//  Created by jurgitonas on 1/19/22.
//

import SwiftUI

struct CVProgressViewStyle: ProgressViewStyle {
    var theme: Theme
    
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10.0)
                .fill(theme.accentColor)
                .frame(height: 20.0)
            ProgressView(configuration)
                .accentColor(theme.mainColor)
                .frame(height: 12.0)
                .padding(.horizontal)
        }
    }
}

struct CVProgressViewStyle_Previews: PreviewProvider {
    static var previews: some View {
        ProgressView(value: 0.4)
            .progressViewStyle(CVProgressViewStyle(theme: .buttercup))
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
    }
}
