//
//  TabBarControllerViewController.swift
//  ViciadoEmFilmes
//
//  Created by João Júnior on 22/06/20.
//  Copyright © 2020 ViciadoEmFilmes. All rights reserved.
//

import UIKit

class TabBarControllerViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let popularVC = MovieListTableViewController()
        popularVC.entryPoint = EntryPointType.popular
        popularVC.title = "Mais populares"
        popularVC.tabBarItem = UITabBarItem(title: popularVC.title, image: nil, tag: 0)
        popularVC.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -16)
        
        let mostRecentVC = MovieListTableViewController()
        mostRecentVC.entryPoint = EntryPointType.mostRecent
        mostRecentVC.title = "Mais recentes"
        mostRecentVC.tabBarItem = UITabBarItem(title: mostRecentVC.title, image: nil, tag: 1)
        mostRecentVC.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -16)
        
        let topRatedVC = MovieListTableViewController()
        topRatedVC.entryPoint = EntryPointType.topRated
        topRatedVC.title = "Melhores avaliados"
        topRatedVC.tabBarItem = UITabBarItem(title: topRatedVC.title, image: nil, tag: 2)
        topRatedVC.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -16)
        
        viewControllers = [popularVC, mostRecentVC, topRatedVC]
        // Do any additional setup after loading the view.
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
