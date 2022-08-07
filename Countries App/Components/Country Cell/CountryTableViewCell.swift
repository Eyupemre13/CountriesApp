//
//  CountryTableViewCell.swift
//  Countries App
//
//  Created by Eyup Emre Aygun on 6.08.2022.
//

import UIKit

class CountryTableViewCell: UITableViewCell {
    // MARK: Outlets
    @IBOutlet weak var countryName: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    let coreDataManager = CoreDataManager()
    
    private var data: CountryCellData?
    weak var delegate: CountryTableViewCellDelegate?

    // MARK: Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        favoriteButton.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
    }
    
    @objc func favoriteButtonTapped() {
        guard let data = returnData() else { return }
        coreDataManager.controlData(data: data)
        favoriteImageChange(data: data)
    }
    
    public func setData(data: CountryCellData) {
        self.data = data
        loadDataView()
    }
    
    public func returnData() -> CountryCellData? {
        return data
    }
    
    private func favoriteImageChange(data: CountryCellData?) {
        if(data?.isFavorited ?? false) {
            favoriteButton.setImage(UIImage(systemName: "star"), for: .normal)
            setData(data: CountryCellData(countryName: data?.countryName, isFavorited: false, countryCode: data?.countryCode))
            delegate?.reloadData()
        }
        else {
            favoriteButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
            setData(data: CountryCellData(countryName: data?.countryName, isFavorited: true, countryCode: data?.countryCode))
            delegate?.reloadData()
        }
    }
    
    private func loadDataView() {
        guard let data = returnData() else { return }
        if(data.isFavorited ?? false) {

            favoriteButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        }
        else {

            favoriteButton.setImage(UIImage(systemName: "star"), for: .normal)
        }
        countryName.text = data.countryName
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        selectionStyle = .none
    }
}

protocol CountryTableViewCellDelegate: AnyObject {
    func reloadData()
}
