//
//  HomePageViewModel.swift
//  Countries App
//
//  Created by Eyup Emre Aygun on 6.08.2022.
//

import Foundation

protocol HomePageViewModelDelegate: AnyObject {
    func reloadNews()
}

class HomePageViewModel {
    weak var delegate: HomePageViewModelDelegate?
    private let networkManager = NetworkManager()
    private let coreDataManager = CoreDataManager()
    
    private var currentOffset = 0
    public var itemsArray = [CountryCellData]()
    
    public func getData() {
        let endPoint = EndpointCases.getCountries(offset: currentOffset)
        networkManager.request(from: endPoint, completionHandler: { [weak self] (result: Result<CountriesModel, Error>) in
            switch result {
            case .success(let dataArray):
                for data in dataArray.data {
                    let isFavorited = self?.coreDataManager.checkFavorited(countryCode: data.code)
                    
                    self?.itemsArray.append(CountryCellData(countryName: data.name, isFavorited: isFavorited, countryCode: data.code))
                }
                
                self?.delegate?.reloadNews()
                
            case .failure(let error):
                print(error)
            }
        })
    }
    
    public func controlLoadMoreData(index: IndexPath) {
        guard let itemCount = getNumberOfRows() else { return }
        if (index.row == itemCount-1) {
           getMoreData()
        }
    }
    
    private func getMoreData() {
        currentOffset = getNumberOfRows() ?? 0
        getData()
    }
    
    public func getNumberOfRows() -> Int? {
        return itemsArray.count
    }
    
    public func getCountryData(at index: IndexPath) -> CountryCellData? {
        let isFavorited = self.coreDataManager.checkFavorited(countryCode: itemsArray[index.item].countryCode)
        itemsArray[index.item].isFavorited = isFavorited
        return itemsArray[index.item]
    }
}
