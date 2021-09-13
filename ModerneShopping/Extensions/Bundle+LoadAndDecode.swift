//
//  Bundle+LoadAndDecode.swift
//  ModerneShopping
//
//  Created by Djallil Elkebir on 2021-09-01.
//

import Foundation

extension Bundle {
    /// Load and decode a JSON File
    /// - Parameter filename: file name in the bundle
    /// - Throws: you got to catch the error :)
    /// - Returns: a decoded object
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
    /// format a double base on objective-c formating
    /// - Parameter f: ".2" to return only the 2 number etc
    /// - Returns: a trimmed double in stringly typed
    func format(f: String) -> String {
        return String(format: "%\(f)f", self)
    }
}
