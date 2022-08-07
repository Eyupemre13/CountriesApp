//
//  FavoritePageViewModel.swift
//  Countries App
//
//  Created by Eyup Emre Aygun on 7.08.2022.
//

import Foundation

class FavoritePageViewModel {
    
    private let coreDataManager = CoreDataManager()
    private var itemsArray = [CountryCellData]()
    
    func getData() {
        guard let data = coreDataManager.getData() else { return }
        itemsArray = data
    }
    
    func dataCount() -> Int? {
        return itemsArray.count
    }
    
    public func getCountryData(at index: IndexPath) -> CountryCellData? {
        let isFavorited = self.coreDataManager.checkFavorited(countryCode: itemsArray[index.item].countryCode)
        itemsArray[index.item].isFavorited = isFavorited
        return itemsArray[index.item]
    }
}
