//
//  FavoritePageViewController.swift
//  Countries App
//
//  Created by Eyup Emre Aygun on 7.08.2022.
//

import UIKit

class FavoritePageViewController: UIViewController {
    // MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    
    lazy var viewModel: FavoritePageViewModel = FavoritePageViewModel()

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        viewModel.getData()
        tableView.reloadData()
    }
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Favorited Countries"
        prepareUI()
    }
    
    private func prepareUI() {
        prepareTableView()
    }
    
    private func prepareTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: String(describing: CountryTableViewCell.self), bundle: nil), forCellReuseIdentifier: "CountryTableViewCell")
    }
}

extension FavoritePageViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = viewModel.getCountryData(at: indexPath)
        self.navigationController?.pushViewController(DetailPageBuilder.build(data: CountryDetailData(countryCode: data?.countryCode, isFavorited: data?.isFavorited, countryName: data?.countryName)), animated: true)
    }
}

extension FavoritePageViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CountryTableViewCell", for: indexPath as IndexPath) as? CountryTableViewCell else { return UITableViewCell() }
        cell.delegate = self
        guard let data = viewModel.getCountryData(at: indexPath) else { return cell }
        cell.setData(data: data)
        
        return cell
    }
}

extension FavoritePageViewController: CountryTableViewCellDelegate {
    func reloadData() {
        viewModel.getData()
        tableView.reloadData()
        
    }
}
