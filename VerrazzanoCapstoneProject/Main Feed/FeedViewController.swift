//
//  FeedViewController.swift
//  VerrazzanoCapstoneProject
//
//  Created by Joseph  DeMario on 2/9/22.
//

import UIKit
import Parse
import FirebaseAuth

@available(iOS 15.0, *)
class FeedViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        print("This is the FeedViewController")
        
        view.backgroundColor = .systemBackground
        
        let mainVC = UINavigationController(rootViewController: MainViewController())
        //let comingsoonVC = UINavigationController(rootViewController: ComingSoonViewController())
        let filterVC = UINavigationController(rootViewController: FilterViewController())
        let favoritesVC = UINavigationController(rootViewController: FavoritesViewController())
        let messagesVC = UINavigationController(rootViewController: ConversationsViewController())
        let profileVC = UINavigationController(rootViewController: ProfileViewController())
        
        mainVC.tabBarItem.image = UIImage(systemName: "house")
        //comingsoonVC.tabBarItem.image = UIImage(systemName: "calendar.badge.exclamationmark")
        filterVC.tabBarItem.image = UIImage(systemName: "magnifyingglass.circle")
        favoritesVC.tabBarItem.image = UIImage(systemName: "heart.fill")
        messagesVC.tabBarItem.image = UIImage(systemName: "message.fill")
        profileVC.tabBarItem.image = UIImage(systemName: "person.circle.fill")
        
        mainVC.title = "Home"
        //comingsoonVC.title = "Coming Soon"
        filterVC.title = "Search"
        favoritesVC.title = "Favorites"
        messagesVC.title = "Chats"
        profileVC.title = "Profile"
        
        tabBar.tintColor = .label
        
        setViewControllers([mainVC, filterVC, favoritesVC, messagesVC, profileVC], animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        validateAuth()
       
    }
    
    private func validateAuth() {
        if FirebaseAuth.Auth.auth().currentUser == nil {
            let vc = LoginViewController()
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: false)
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
