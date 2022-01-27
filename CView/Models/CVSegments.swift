//
//  CVSegments.swift
//  CView
//
//  Created by jurgitonas on 1/18/22.
//

import Foundation

/// Keeps track of segments and the title of the current segment.
class CVSegments: ObservableObject {
    /// A struct to keep track of segments.
    struct Element: Identifiable {
        /// The segment title.
        let title: String
        /// The segment parts.
        let parts: [String]
        /// Id for Identifiable conformance.
        let id = UUID()
    }
    
    /// All segments, listed in the order they will appear.
    private(set) var elements: [Element] = []

    @Published var elementsIndex: Int = 0
    @Published var elementPartsIndex: Int = 0

    /**
     Initialize a new CVSegments. Initializing a CVSegments with no arguments creates a CVSegments with no segments.
     
     - Parameters:
        - segments: A list of segments for the CVSegments.
     */
    init(segments: [CV.Segment] = []) {
        self.elements = segments.elements
    }

    /// Change to the previous element.
    func previousElement() {
        changeToElement(at: elementsIndex - 1)
    }
    
    /// Change to the next element.
    func nextElement() {
        changeToElement(at: elementsIndex + 1)
    }

    func changeToElement(at index: Int) {
        guard (index < elements.count) && (index > -1) else { return }
        elementsIndex = index
    }

    /// Change to the previous part.
    func previousElementPart() {
        changeToElementPart(at: elementPartsIndex - 1)
    }
    
    /// Change to the next part.
    func nextElementPart() {
        changeToElementPart(at: elementPartsIndex + 1)
    }
    func changeToElementPart(at index: Int) {
        guard (index < elements[elementsIndex].parts.count) && (index > -1) else { return }
        elementPartsIndex = index
    }

    /**
     Reset the CVSegments with new segments.
     
     - Parameters:
         - segments: The title of each segment.
     */
    func reset(segments: [CV.Segment]) {
        self.elements = segments.elements
    }
}

extension CV {
    /// A new `CVSegments` using segments in the `CV`.
    var newSegments: CVSegments {
        CVSegments(segments: segments)
    }
}

extension Array where Element == CV.Segment {
    var elements: [CVSegments.Element] {
        if isEmpty {
            return [CVSegments.Element(title: "Title", parts: [])]
        } else {
            return map { CVSegments.Element(title: $0.title, parts: $0.parts) }
        }
    }
}
