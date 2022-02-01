//
//  SegmentView.swift
//  CView
//
//  Created by jurgitonas on 1/18/22.
//

import SwiftUI

struct SegmentView: View {
    @Binding var cv: CV
    @State private var data = CV.Data()
    @StateObject var cvSegments = CVSegments()
    var elementsIndex: Int
    @State private var isPresentingSegmentEditView = false

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(cv.segments[cvSegments.elementsIndex].theme.mainColor)
            VStack {
                let partsCount = cv.segments[elementsIndex].parts.count
                SegmentHeaderView(elementsIndex: cvSegments.elementPartsIndex, elementsTotal: partsCount, theme: cv.segments[cvSegments.elementsIndex].theme)
                RoundedRectangle(cornerRadius: 16)
                    .strokeBorder(lineWidth: 0)
                    .overlay(GeometryReader { geometry in
                        ScrollView(.vertical) {
                            VStack {
                                if partsCount > 0 {
                                    Text(cv.segments[cvSegments.elementsIndex].parts[cvSegments.elementPartsIndex])
                                        .padding(.horizontal)
                                } else {
                                    Button(action: {
                                        isPresentingSegmentEditView = true
                                        data = cv.data
                                    }) {
                                        Text("Add \(cv.segments[cvSegments.elementsIndex].title)")
                                            .padding(.horizontal)
                                    }
                                }
                            }
                            .frame(width: geometry.size.width)
                            .frame(minHeight: geometry.size.height)
                        }
                    })
                SegmentFooterView(elements: cvSegments.elements, previousAction: cvSegments.previousElementPart, nextAction: cvSegments.nextElementPart, elementsIndex: cvSegments.elementsIndex, elementPartsIndex: cvSegments.elementPartsIndex)
            }
        }
        .padding()
        .foregroundColor(cv.segments[cvSegments.elementsIndex].theme.accentColor)
        .onAppear {
            cvSegments.reset(segments: cv.segments)
            cvSegments.changeToElement(at: elementsIndex)
            cvSegments.changeToElementPart(at: 0)
        }
        /*
        .onDisappear {
        }
        */
        .navigationTitle(cv.segments[elementsIndex].title)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing:
            Button("Edit") {
                isPresentingSegmentEditView = true
                data = cv.data
            }
        )
        .sheet(isPresented: $isPresentingSegmentEditView) {
            NavigationView {
                SegmentEditView(data: $data, elementsIndex: cvSegments.elementsIndex)
                    .navigationTitle(cv.segments[cvSegments.elementsIndex].title)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") {
                                isPresentingSegmentEditView = false
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Done") {
                                isPresentingSegmentEditView = false
                                cv.update(from: data)
                                cvSegments.reset(segments: cv.segments)
                                cvSegments.changeToElementPart(at: 0)
                            }
                        }
                    }
            }
        }
    }
}

struct SegmentView_Previews: PreviewProvider {
    static var previews: some View {
        SegmentView(cv: .constant(CV.sampleData[0]), elementsIndex: 0)
            .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
    }
}
