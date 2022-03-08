//
//  FilterResultsViewController.swift
//  VerrazzanoCapstoneProject
//
//  Created by Joseph  DeMario on 2/28/22.
//

import UIKit

class FilterResultsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.identifier, for: indexPath) as? TitleCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let title = titles[indexPath.row]
        cell.configure(with: title.poster_path ?? "")
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let title = titles[indexPath.row]
        let titleName = title.original_title ?? ""
        MovieAPICaller.shared.getMovie(with: titleName) { [weak self] result in
            switch result {
            case .success(let vidEl):
                self?.delegate?.filterResultsViewControllerTapItem(TrailerViewModel(title: title.original_title ?? title.original_name ?? "", YouTubeView: vidEl, synopsis: title.overview ?? "", releaseDate: title.release_date ?? ""))
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    public var titles: [Title] = [Title]()
    public weak var delegate: FilterResultsViewControllerDelegate?
    
    public let filterResultsCollectionView: UICollectionView = {
        let layout =  UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 3 - 10, height: 200)
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: TitleCollectionViewCell.identifier)
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        view.addSubview(filterResultsCollectionView)
        
        filterResultsCollectionView.delegate = self
        filterResultsCollectionView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        filterResultsCollectionView.frame = view.bounds
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

protocol FilterResultsViewControllerDelegate: AnyObject {
    func filterResultsViewControllerTapItem(_ viewModel: TrailerViewModel)
}
