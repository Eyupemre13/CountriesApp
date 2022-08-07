//
//  HomePageViewController.swift
//  Countries App
//
//  Created by Eyup Emre Aygun on 5.08.2022.
//

import UIKit

class HomePageViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    
    lazy var viewModel: HomePageViewModel = HomePageViewModel()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        viewModel.getData()
    }
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Countries"
        viewModel.delegate = self
        setupUI()
    }
    
    private func setupUI() {
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: String(describing: CountryTableViewCell.self), bundle: nil), forCellReuseIdentifier: "CountryTableViewCell")
    }
}

extension HomePageViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfRows() ?? 0
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CountryTableViewCell", for: indexPath as IndexPath) as? CountryTableViewCell else { return UITableViewCell() }
        cell.delegate = self
        guard let data = viewModel.getCountryData(at: indexPath) else { return cell }
        cell.setData(data: data)
        
        return cell
    }
}

extension HomePageViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = viewModel.getCountryData(at: indexPath)
        
        self.navigationController?.pushViewController(DetailPageBuilder.build(data: CountryDetailData(countryCode: data?.countryCode, isFavorited: data?.isFavorited, countryName: data?.countryName)), animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        viewModel.controlLoadMoreData(index: indexPath)
    }
}

extension HomePageViewController: HomePageViewModelDelegate {
    func reloadNews() {
        tableView.reloadData()
    }
}

extension HomePageViewController: CountryTableViewCellDelegate {
    func reloadData() {
        tableView.reloadInputViews()
    }
}
