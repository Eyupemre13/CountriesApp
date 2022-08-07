// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let countryDetailModel = try? newJSONDecoder().decode(CountryDetailModel.self, from: jsonData)

import Foundation

// MARK: - CountryDetailModel
struct CountryDetailModel: Codable {
    var data: CountryDetailDataClass?
}

// MARK: - DataClass
struct CountryDetailDataClass: Codable {
    var capital, code, callingCode: String?
    var currencyCodes: [String]?
    var flagImageURI: String?
    var name: String?
    var numRegions: Int?
    var wikiDataID: String?

    enum CodingKeys: String, CodingKey {
        case capital, code, callingCode, currencyCodes
        case flagImageURI = "flagImageUri"
        case name, numRegions
        case wikiDataID = "wikiDataId"
    }
}
