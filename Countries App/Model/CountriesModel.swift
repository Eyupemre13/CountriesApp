// MARK: - CountriesModel
struct CountriesModel: Codable {
    let data: [CountryData]
    let links: [Link]
    let metadata: Metadata
}

// MARK: - Datum
struct CountryData: Codable {
    let code: String?
    let currencyCodes: [String]?
    let name, wikiDataID: String?

    enum CodingKeys: String, CodingKey {
        case code, currencyCodes, name
        case wikiDataID
    }
}

// MARK: - Link
struct Link: Codable {
    let rel, href: String?
}

// MARK: - Metadata
struct Metadata: Codable {
    let currentOffset, totalCount: Int?
}
