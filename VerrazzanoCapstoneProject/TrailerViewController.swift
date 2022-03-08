//
//  TrailerViewController.swift
//  VerrazzanoCapstoneProject
//
//  Created by Joseph  DeMario on 3/2/22.
//

import UIKit
import WebKit

class TrailerViewController: UIViewController {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Avengers"
        label.font = .systemFont(ofSize: 22, weight: .bold)
        return label
    }()
    
//    private let posterImageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.contentMode = .scaleAspectFill
//        imageView.clipsToBounds = true
//        imageView.backgroundColor = .red
//        imageView.image = UIImage(named: "moviePoster")
//        return imageView
//    }()
    
    private let synopsisLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "My favorite movie!"
        label.numberOfLines = 0
        return label
    }()
    
    private let releaseDateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Release Date: "
        label.numberOfLines = 0
        return label
    }()
    
    private let favoriteButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .red
        button.setTitle("Favorite", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        return button
    }()
    
    
    private let webView: WKWebView = {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        view.addSubview(webView)
        view.addSubview(titleLabel)
        view.addSubview(synopsisLabel)
        view.addSubview(favoriteButton)
        view.addSubview(releaseDateLabel)
        //view.addSubview(posterImageView)
        
        applyConstraints()
    }
    
    func applyConstraints() {
        let webViewConstraints = [
            webView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.heightAnchor.constraint(equalToConstant: 300)
        ]
//        let posterConstraints = [
//            posterImageView.topAnchor.constraint(equalTo: webView.bottomAnchor, constant: 20),
//            posterImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
//        ]
        let titleLabelConstraints = [
            titleLabel.topAnchor.constraint(equalTo: webView.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ]
        let synopsisLabelConstraints = [
            synopsisLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40),
            synopsisLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            synopsisLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        let releaseDateConstraints = [
            releaseDateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            releaseDateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ]
        let favoriteButtonConstraints = [
            favoriteButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            favoriteButton.topAnchor.constraint(equalTo: synopsisLabel.bottomAnchor, constant: 25),
            favoriteButton.widthAnchor.constraint(equalToConstant: 120),
            favoriteButton.heightAnchor.constraint(equalToConstant: 40)
        ]
        NSLayoutConstraint.activate(webViewConstraints)
        NSLayoutConstraint.activate(titleLabelConstraints)
        NSLayoutConstraint.activate(synopsisLabelConstraints)
        NSLayoutConstraint.activate(favoriteButtonConstraints)
        NSLayoutConstraint.activate(releaseDateConstraints)
        //NSLayoutConstraint.activate(posterConstraints)
    }
    
    func configure(with model: TrailerViewModel) {
        titleLabel.text = model.title
        synopsisLabel.text = model.synopsis
        releaseDateLabel.text = model.releaseDate
        
        guard let url = URL(string: "https://www.youtube.com/embed/\(model.YouTubeView.id.videoId)") else { return }
        webView.load(URLRequest(url: url))
        
//        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(model.poster)") else {
//            return
//        }
//        posterImageView.sd_setImage(with: url, completed: nil)
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
