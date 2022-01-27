//
//  CVstore.swift
//  CView
//
//  Created by jurgitonas on 1/17/22.
//

import Foundation
import SwiftUI

class CVstore: ObservableObject {
    @Published var cvs: [CV] = []
    
    private static func getFileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("cvs.data")
    }
    
    static func load(completion: @escaping (Result<[CV], Error>)->Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let fileURL = try getFileURL()
                guard let file = try? FileHandle(forReadingFrom: fileURL) else {
                    DispatchQueue.main.async {
                        completion(.success([]))
                    }
                    return
                }
                let newCV = try JSONDecoder().decode([CV].self, from: file.availableData)
                DispatchQueue.main.async {
                    completion(.success(newCV))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    
    static func save(cvs: [CV], completion: @escaping (Result<Int, Error>)->Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let data = try JSONEncoder().encode(cvs)
                let outFile = try getFileURL()
                try data.write(to: outFile)
                DispatchQueue.main.async {
                    completion(.success(cvs.count))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
}
