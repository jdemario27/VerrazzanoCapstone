//
//  CollectionTableViewCell.swift
//  VerrazzanoCapstoneProject
//
//  Created by Joseph  DeMario on 2/25/22.
//

import UIKit

@available(iOS 15.0, *)
class CollectionTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.identifier, for: indexPath) as? TitleCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        guard let model = titles[indexPath.row].poster_path else {
            return UICollectionViewCell()
        }
        cell.configure(with: model)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let title = titles[indexPath.row]
        guard let titleName = title.original_title ?? title.original_name else { return }
        MovieAPICaller.shared.getMovie(with: titleName + "trailer") { [weak self] result in
            switch result {
            case .success(let vidEl):
                let title = self?.titles[indexPath.row]
                guard let synopsis = title?.overview else { return }
                guard let releaseDate = title?.release_date else { return }
                guard let strongSelf = self else { return }
                //let viewModel = TrailerViewModel(title: titleName, YouTubeView: vidEl, synopsis: synopsis)
                let viewModel = TrailerViewModel(title: titleName, YouTubeView: vidEl, synopsis: synopsis, releaseDate: releaseDate)
                self?.delegate?.CollectionViewTableViewCellDidTapCell(strongSelf, viewModel: viewModel)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let config = UIContextMenuConfiguration(
                    identifier: nil,
                    previewProvider: nil) { [weak self] _ in
                        let favoriteAction = UIAction(title: "Add to Favorites", subtitle: nil, image: nil, identifier: nil, discoverabilityTitle: nil, state: .off) { _ in
                            self?.favoriteTitleAt(indexPath: indexPath)
                        }
                        return UIMenu(title: "", image: nil, identifier: nil, options: .displayInline, children: [favoriteAction])
                    }
                
                return config
    }

    static let identifier = "CollectionTableViewCell"
    
    weak var delegate: CollectionViewTableViewCellDelegate?
    
    private var titles: [Title] = [Title]()
    
    private let collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 140, height: 200)
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: TitleCollectionViewCell.identifier)
        return collectionView
        
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemPink
        contentView.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = contentView.bounds
    }
    
    public func configure(with titles: [Title]) {
        self.titles = titles
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
    
    private func favoriteTitleAt(indexPath: IndexPath) {
        DataPersistenceManager.shared.favoriteTitleWith(model: titles[indexPath.row]) { result in
            switch result {
            case .success():
                NotificationCenter.default.post(name: NSNotification.Name("Favorited"), object: nil)
                print("favorited to database")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

@available(iOS 15.0, *)
protocol CollectionViewTableViewCellDelegate: AnyObject {
    func CollectionViewTableViewCellDidTapCell(_ cell: CollectionTableViewCell, viewModel: TrailerViewModel)
}
