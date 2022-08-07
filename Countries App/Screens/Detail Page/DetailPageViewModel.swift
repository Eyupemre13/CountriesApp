//
//  DetailPageViewModel.swift
//  Countries App
//
//  Created by Eyup Emre Aygun on 6.08.2022.
//

import Foundation

protocol DetailPageViewModelDelegate: AnyObject {
    func prepareUI()
}

class DetailPageViewModel {
    weak var delegate: DetailPageViewModelDelegate?

    var countryCode: String
    var isFavorited: Bool
    let networkManager = NetworkManager()
    let coreDataManager = CoreDataManager()
    
    private var itemsArray : CountryDetailModel?

    
    init(countryCode: String, isFavorited: Bool) {
        self.countryCode = countryCode
        self.isFavorited = isFavorited
    }
    
    func isFavoritedCheck() -> Bool? {
        return isFavorited
    }
    
    func changeIsFavorited() {
        guard let data = returnData() else { return }
        coreDataManager.controlData(data: CountryCellData(countryName: data.data?.name, isFavorited: isFavorited, countryCode: data.data?.code))
        if(isFavorited) {
            isFavorited = false

        }
        else {
            isFavorited = true
        }

    }
    
    func getData() {
        let endPoint = EndpointCases.getCountryDetail(countryCode: countryCode )
        networkManager.request(from: endPoint, completionHandler: { [weak self] (result: Result<CountryDetailModel, Error>) in
            switch result {
            case .success(let dataArray):
                self?.itemsArray = dataArray
                self?.delegate?.prepareUI()
            case .failure(let error):
                print(error)
            }
        })
    }
    
    public func returnData() -> CountryDetailModel? {
        guard let data = itemsArray else { return CountryDetailModel()}
        return data
    }
}
