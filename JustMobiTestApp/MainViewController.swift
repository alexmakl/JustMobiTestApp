//
//  MainViewController.swift
//  JustMobiTestApp
//
//  Created by Alexander on 11.07.2025.
//

import UIKit

protocol MainViewProtocol: AnyObject {
    func showData(tagsTitle: String)
}

final class MainViewController: UIViewController, MainViewProtocol {

    var presenter: MainPresenterProtocol?
    
    private var tagsCollectionView: UICollectionView!
    private var tags: [Tag] = []
    
    private let promoView = BannerView()
    
    private lazy var tagsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .label
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = MainPresenter(view: self)
        
        setupUI()
        presenter?.loadData()
    }
    
    func showData(tagsTitle: String) {
        tagsLabel.text = tagsTitle
        updateTags()
    }

    private func setupUI() {
        navigationController?.navigationBar.isHidden = true
        
        configureViews()
        configureConstraints()
    }
    
    private func configureConstraints() {
        promoView.translatesAutoresizingMaskIntoConstraints = false
        tagsLabel.translatesAutoresizingMaskIntoConstraints = false
        tagsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            promoView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            promoView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            promoView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            tagsLabel.topAnchor.constraint(equalTo: promoView.bottomAnchor, constant: 15),
            tagsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tagsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            tagsCollectionView.topAnchor.constraint(equalTo: tagsLabel.bottomAnchor, constant: 8),
            tagsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tagsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tagsCollectionView.heightAnchor.constraint(equalToConstant: 25)
        ])
    }
    
    private func configureViews() {
        view.backgroundColor = .systemBackground
        
        setupTagsCollectionView()
        
        view.addSubview(promoView)
        view.addSubview(tagsLabel)
        view.addSubview(tagsCollectionView)
    }
    
    private func setupTagsCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 4
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        tagsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        tagsCollectionView.backgroundColor = .clear
        tagsCollectionView.showsHorizontalScrollIndicator = false
        tagsCollectionView.dataSource = self
        tagsCollectionView.delegate = self
        tagsCollectionView.register(TagCell.self, forCellWithReuseIdentifier: TagCell.reuseIdentifier)
    }

    private func updateTags() {
        tagsCollectionView.reloadData()
    }
}

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.tagsCount ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagCell.reuseIdentifier, for: indexPath) as? TagCell else {
            return UICollectionViewCell()
        }
        let tag = presenter?.tag(at: indexPath.item)
        cell.configure(with: tag)
        return cell
    }
}

