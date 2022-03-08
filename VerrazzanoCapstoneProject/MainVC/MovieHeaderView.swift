//
//  MovieHeaderView.swift
//  VerrazzanoCapstoneProject
//
//  Created by Joseph  DeMario on 2/25/22.
//

import UIKit

class MovieHeaderView: UIView {
    
    private let favoriteButton: UIButton = {
        
        let button = UIButton()
        button.setTitle("Favorite", for: .normal)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
        
    }()
    
    private let playButton: UIButton = {
        
        let button = UIButton()
        button.setTitle("Play", for: .normal)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
        
    }()
    
    private let movieImageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "movieHeaderImage")
        return imageView
        
    }()

    private func addGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.systemBackground.cgColor
        ]
        gradientLayer.frame = bounds
        layer.addSublayer(gradientLayer)
    }
    
    private func applyConstraints() {
        
        let playButtonConstraints = [
            playButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 75),
            playButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            playButton.widthAnchor.constraint(equalToConstant: 120)
        ]
        
        let favoriteButtonConstraints = [
            favoriteButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -75),
            favoriteButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            favoriteButton.widthAnchor.constraint(equalToConstant: 120)
        ]
        
        NSLayoutConstraint.activate(playButtonConstraints)
        NSLayoutConstraint.activate(favoriteButtonConstraints)
    }
    
    public func configure(with model: TitleViewModel) {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(model.posterURL)") else {
            return
        }
        
        movieImageView.sd_setImage(with: url, completed: nil)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(movieImageView)
        addGradient()
        addSubview(playButton)
        addSubview(favoriteButton)
        applyConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        movieImageView.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
