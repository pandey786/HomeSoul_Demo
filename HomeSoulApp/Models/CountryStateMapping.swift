//
//  CountryStateMapping.swift
//  HomeSoulApp
//
//  Created by Durgesh Pandey on 03/07/18.
//  Copyright © 2018 Durgesh Pandey. All rights reserved.
//

import Foundation

struct CountryListMappingModel: Codable {
    let countries: [Country]?
}

struct Country: Codable {
    let country: String?
    let states: [String]?
}

extension CountryListMappingModel {
    init(data: Data) throws {
        self = try JSONDecoder().decode(CountryListMappingModel.self, from: data)
    }
    
    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func jsonData() throws -> Data {
        return try JSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

extension Country {
    init(data: Data) throws {
        self = try JSONDecoder().decode(Country.self, from: data)
    }
    
    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }
    
    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }
    
    func jsonData() throws -> Data {
        return try JSONEncoder().encode(self)
    }
    
    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
