//
//  ViewController.swift
//  PokemonApp
//
//  Created by IVAN KHRAMOV on 10.03.2021.
//

import UIKit

class PokemonViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        presenter?.viewDidLoad()
    }
    
    @objc func refresh() {
        presenter?.refresh()
    }
    
    var presenter: ViewToPresenterPokemonsProtocol?
    
    let reuseIdentifier = "cell"
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewLayout.init())
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()

    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Refreshing")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return refreshControl
    }()
    
}

extension PokemonViewController: PresenterToViewPokemonsProtocol {
    
    func onFetchPokemonsSuccess() {
        self.collectionView.reloadData()
        self.refreshControl.endRefreshing()
    }
    
    func onFetchPokemonsFailure(error: String) {
        print("View receives the response from Presenter with error: \(error)")
        self.refreshControl.endRefreshing()
    }
}

extension PokemonViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.presenter?.pokemons?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! PokemonViewCell
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("I'm tapped \(indexPath.item)")
    }
}

extension PokemonViewController {
    func setupUI() {
        overrideUserInterfaceStyle = .light
        self.view.addSubview(collectionView)
        collectionView.addSubview(refreshControl)
        
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalTo: self.view.heightAnchor).isActive = true

        self.navigationItem.title = "Pokemons"
    }
}
