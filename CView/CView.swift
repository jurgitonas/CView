//
//  CView.swift
//  CView
//
//  Created by jurgitonas on 1/18/22.
//

import SwiftUI

struct CView: View {
    @Binding var cvs: [CV]
    @Environment(\.scenePhase) private var scenePhase
    @State private var isPresentingNewCView = false
    @State private var newCVData = CV.Data()
    let saveAction: ()->Void

    var body: some View {
        List {
            ForEach(cvs) { cv in
                NavigationLink(destination: DetailView(cv: binding(for: cv))) {
                    CardView(cv: cv)
                }
                .listRowBackground(cv.theme.mainColor)
            }
            .onDelete { indices in
                cvs.remove(atOffsets: indices )
            }
        }
        .navigationTitle("List of CVs")
        .toolbar {
            Button(action: {
                isPresentingNewCView = true
            }) {
                Image(systemName: "plus")
            }
            .accessibilityLabel("New CV")
        }
        .sheet(isPresented: $isPresentingNewCView) {
            NavigationView {
                DetailEditView(data: $newCVData)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Dismiss") {
                                isPresentingNewCView = false
                                newCVData = CV.Data()
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Add") {
                                let newCV = CV(name: newCVData.name, surname: newCVData.surname, birthday: newCVData.birthday, city: newCVData.city, phone: newCVData.phone, email: newCVData.email, github: newCVData.github, linkedin: newCVData.linkedin, about: newCVData.about, segments: newCVData.segments.map { $0.title }, theme: newCVData.theme)
                                cvs.append(newCV)
                                isPresentingNewCView = false
                                newCVData = CV.Data()
                            }
                        }
                    }
            }
        }
        .onChange(of: scenePhase) { phase in
            if phase == .inactive { saveAction() }
        }
    }
    private func binding(for cv: CV) -> Binding<CV> {
        guard let cvIndex = cvs.firstIndex(where: { $0.id == cv.id }) else {
            fatalError("Can't find cv in array")
        }
        return $cvs[cvIndex]
    }
}


struct CView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CView(cvs: .constant(CV.sampleData), saveAction: {})
                .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
        }
    }
}
