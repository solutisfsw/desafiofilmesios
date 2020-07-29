//
//  TabBarControllerViewController.swift
//  ViciadoEmFilmes
//
//  Created by João Júnior on 22/06/20.
//  Copyright © 2020 ViciadoEmFilmes. All rights reserved.
//

import UIKit

class TabBarControllerViewController: UITabBarController {
    
    // MARK: LiveCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.populateTabs()
        self.layout()
    }
    
    // MARK: TabItems

    func populateTabs(){
        let verticalAlign:CGFloat = -17
        
        let popularVC = MovieListTableViewController()
        popularVC.entryPoint = EntryPointType.popular
        popularVC.tabBarItem = UITabBarItem(title: "Mais populares", image: nil, tag: 0)
        popularVC.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: verticalAlign)
        
        let mostRecentVC = MovieListTableViewController()
        mostRecentVC.entryPoint = EntryPointType.mostRecent
        mostRecentVC.tabBarItem = UITabBarItem(title: "Mais recentes", image: nil, tag: 1)
        mostRecentVC.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: verticalAlign)
        
        let topRatedVC = MovieListTableViewController()
        topRatedVC.entryPoint = EntryPointType.topRated
        topRatedVC.tabBarItem = UITabBarItem(title: "Melhores avaliados", image: nil, tag: 2)
        topRatedVC.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: verticalAlign)
        
        viewControllers = [popularVC, mostRecentVC, topRatedVC]
    }
    
    // MARK: UI
    
    func layout(){
        self.navigationController?.navigationBar.topItem?.title = "Viciados em filmes"
        self.navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(title: "Favoritos", style: .plain, target: self, action: #selector(self.favoriteButtonTouch(_:)))
    }
    
    @objc func favoriteButtonTouch(_ sender: Any) {
        let favoritesVC = MovieListTableViewController()
        favoritesVC.entryPoint = EntryPointType.favorites
        favoritesVC.title = "Favoritos"
        self.navigationController?.pushViewController(favoritesVC, animated: true)
    }

}
