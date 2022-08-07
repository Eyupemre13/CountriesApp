//
//  DetailPageBuilder.swift
//  Countries App
//
//  Created by Eyup Emre Aygun on 6.08.2022.
//

import Foundation
import UIKit

class DetailPageBuilder {
    class func build(data: CountryDetailData) -> UIViewController {
        let viewModel = DetailPageViewModel(countryCode: data.countryCode ?? "", isFavorited: data.isFavorited ?? false)
        
        let viewController = DetailPageViewController(viewModel: viewModel)
        viewController.title = data.countryName
        return viewController
    }
}
