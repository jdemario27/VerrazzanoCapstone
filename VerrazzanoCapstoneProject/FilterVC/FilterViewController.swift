//
//  FilterViewController.swift
//  VerrazzanoCapstoneProject
//
//  Created by Joseph  DeMario on 2/25/22.
//

import UIKit

class FilterViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating, FilterResultsViewControllerDelegate {
    
    func filterResultsViewControllerTapItem(_ viewModel: TrailerViewModel) {
        DispatchQueue.main.async { [weak self] in
            let vc = TrailerViewController()
            vc.configure(with: viewModel)
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        let filterBar = searchController.searchBar
        guard let query = filterBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty,
              query.trimmingCharacters(in: .whitespaces).count >= 3,
              let resultsController = searchController.searchResultsController as? FilterResultsViewController else {
                  return
              }
        
        resultsController.delegate = self
        
        MovieAPICaller.shared.filter(with: query) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let titles):
                    resultsController.titles = titles
                    resultsController.filterResultsCollectionView.reloadData()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier, for: indexPath) as? TitleTableViewCell else {
            return UITableViewCell()
        }
        let title = titles[indexPath.row]
        let model = TitleViewModel(titleName: title.original_name ?? title.original_title ?? "No title name found", posterURL: title.poster_path ?? "")
        
        cell.configure(with: model)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let title = titles[indexPath.row]
        guard let titleName = title.original_title ?? title.original_name else { return }
        MovieAPICaller.shared.getMovie(with: titleName) { [weak self] result in
            switch result {
            case .success(let vidEl):
                DispatchQueue.main.async {
                    let vc = TrailerViewController()
                    vc.configure(with: TrailerViewModel(title: titleName, YouTubeView: vidEl, synopsis: title.overview ?? "", releaseDate: title.release_date ?? ""))
                    self?.navigationController?.pushViewController(vc, animated: true)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private var titles: [Title] = [Title]()
    
    private let filterController: UISearchController = {
        let controller = UISearchController(searchResultsController: FilterResultsViewController())
        controller.searchBar.placeholder = "Find your movie or TV show here..."
        controller.searchBar.searchBarStyle = .minimal
        return controller
    }()
    
    private let findTable: UITableView = {
        let table = UITableView()
        table.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.identifier)
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        title = "Find a Movie"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        view.addSubview(findTable)
        findTable.delegate = self
        findTable.dataSource = self
        
        navigationItem.searchController = filterController
        navigationController?.navigationBar.tintColor = .white
        
        fetchDiscoverMovies()
        
        filterController.searchResultsUpdater = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        findTable.frame = view.bounds
    }
    
    private func fetchDiscoverMovies() {
        MovieAPICaller.shared.getDiscoverMovies { [weak self] result in
            switch result {
            case .success(let titles):
                self?.titles = titles
                DispatchQueue.main.async {
                    self?.findTable.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
