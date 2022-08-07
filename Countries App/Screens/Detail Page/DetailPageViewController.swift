//
//  DetailPageViewController.swift
//  Countries App
//
//  Created by Eyup Emre Aygun on 6.08.2022.
//

import UIKit
import Kingfisher
import WebKit

class DetailPageViewController: UIViewController {
    // MARK: Outlets
    @IBOutlet weak var webViewImage: WKWebView!
    @IBOutlet weak var countryCodeLabel: UILabel!
    @IBOutlet weak var routingButton: UIButton!
        
    var viewModel: DetailPageViewModel
    var favoriteButton = UIBarButtonItem()
    
    init(viewModel: DetailPageViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getData()
        prepareComponents()

    }
    
    private func prepareComponents() {
        prepareNavigationBar()
    }
    
    private func prepareNavigationBar() {
        favoriteButton = UIBarButtonItem(image: UIImage(systemName: "star"), style: .plain, target: self, action: #selector(favoriteButtonTapped))
        
        navigationItem.rightBarButtonItems = [favoriteButton]

    }
    
    @objc private func routingButtonAction() {
        let data = viewModel.returnData()
        let wikiDataID = data?.data?.wikiDataID
        if let url = URL(string: "https://www.wikidata.org/wiki/" + "\(wikiDataID ?? "")") {
            UIApplication.shared.open(url)
        }
    }
    
    @objc private func favoriteButtonTapped() {
        guard let isFavorited = self.viewModel.isFavoritedCheck() else { return }
        if(isFavorited) {
            self.favoriteButton.image = UIImage(systemName: "star")
            self.favoriteButton = UIBarButtonItem(image: UIImage(systemName: "star"), style: .plain, target: self, action: #selector(self.favoriteButtonTapped))

        }
        else {
            self.favoriteButton.image = UIImage(systemName: "star.fill")
            self.favoriteButton = UIBarButtonItem(image: UIImage(systemName: "star.fill"), style: .plain, target: self, action: #selector(self.favoriteButtonTapped))
        }
        viewModel.changeIsFavorited()
        navigationItem.rightBarButtonItems = [favoriteButton]

    }
}

extension DetailPageViewController: DetailPageViewModelDelegate {
    func prepareUI() {
        guard let data = self.viewModel.returnData() else { return }
        guard let isFavorited = self.viewModel.isFavoritedCheck() else { return }
        
        if(isFavorited) {
            self.favoriteButton.image = UIImage(systemName: "star.fill")
            self.favoriteButton = UIBarButtonItem(image: UIImage(systemName: "star.fill"), style: .plain, target: self, action: #selector(self.favoriteButtonTapped))

        }
        else {
            self.favoriteButton.image = UIImage(systemName: "star")
            self.favoriteButton = UIBarButtonItem(image: UIImage(systemName: "star"), style: .plain, target: self, action: #selector(self.favoriteButtonTapped))

        }
        navigationItem.rightBarButtonItems = [favoriteButton]

        routingButton.addTarget(self, action: #selector(routingButtonAction), for: .touchUpInside)
        
        self.countryCodeLabel.text = "Country Code: " + "\(data.data?.code ?? "")"
        
        guard let urlString = data.data?.flagImageURI else { return }
        let url = URLRequest(url: URL(string: urlString)!)
        webViewImage.load(url)
    }
}
