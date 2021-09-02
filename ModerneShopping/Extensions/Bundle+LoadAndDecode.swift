//
//  Bundle+LoadAndDecode.swift
//  ModerneShopping
//
//  Created by Djallil Elkebir on 2021-09-01.
//

import Foundation

extension Bundle {
    func loadAndDecodeJSON<D: Decodable>(filename: String) throws -> D? {
            guard let url = url(forResource: filename, withExtension: ".json") else {
                return nil
            }
            let data = try Data(contentsOf: url)
            let jsonDecoder = JSONDecoder()
            let decodedData = try jsonDecoder.decode(D.self, from: data)
            return decodedData
    }
}

extension Double {
    func format(f: String) -> String {
        return String(format: "%\(f)f", self)
    }
}
