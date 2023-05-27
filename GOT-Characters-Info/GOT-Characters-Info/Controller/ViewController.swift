//
//  ViewController.swift
//  GOT-Characters-Info
//
//  Created by Sameer Karoshi on 24/05/23.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Private Property
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
        imageView.image = UIImage(named: "GOTAppIcon")
        return imageView
    }()
    
    // MARK: - Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(imageView)
        ThronesCharacterViewModel.fetchThronesCharacterUsingJSON() { result in
            print(result)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageView.center = view.center
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: { [weak self] in
            self?.animate()
        })
    }
    
    // MARK: - Private Helpers
    
    private func animate() {
        UIView.animate(withDuration: 1, animations: { [weak self] in
            guard let strongSelf = self else {
                return
            }
            let size = strongSelf.view.frame.size.width * 4
            let diffX = size - strongSelf.view.frame.size.width
            let diffY = strongSelf.view.frame.size.height - size
            strongSelf.imageView.frame = CGRect(
                x: -(diffX/2),
                y: diffY/2,
                width: size,
                height: size
            )
        })
        UIView.animate(withDuration: 1.5, animations: { [weak self] in
            self?.imageView.alpha = 0
        }, completion: { done in
            if done {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: { [weak self] in
                    self?.presentGOTApp()
                })
            }
        })
    }
    
    private func presentGOTApp() {
        let tabBarViewController = UITabBarController()
        let homeViewController = UINavigationController(rootViewController: HomeViewController())
        let addThronesCharacterViewController = UINavigationController(rootViewController: AddThronesCharacterViewController())
        
        homeViewController.title = "Home"
        addThronesCharacterViewController.title = "Add"
        
        tabBarViewController.setViewControllers([homeViewController, addThronesCharacterViewController], animated: false)
        guard let items = tabBarViewController.tabBar.items else {
            return
        }

        let images = ["house.fill", "plus.circle.fill"]
        for item in 0..<items.count {
            items[item].image = UIImage(systemName: images[item])
        }
        tabBarViewController.modalPresentationStyle = .fullScreen
        present(tabBarViewController, animated: true)
    }
}

