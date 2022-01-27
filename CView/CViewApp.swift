//
//  CViewApp.swift
//  CView
//
//  Created by jurgitonas on 1/17/22.
//

import SwiftUI

@main
struct CViewApp: App {
    @StateObject private var store = CVstore()

    var body: some Scene {
        WindowGroup {
            NavigationView {
                CView(cvs: $store.cvs) {
                    CVstore.save(cvs: store.cvs) { result in
                        if case .failure(let error) = result {
                            fatalError(error.localizedDescription)
                        }
                    }
                }
            }
            .onAppear {
                CVstore.load { result in
                    switch result {
                    case .failure(let error):
                        fatalError(error.localizedDescription)
                    case .success(let cvs):
                        store.cvs = cvs
                    }
                }
            }
        }
    }
}
