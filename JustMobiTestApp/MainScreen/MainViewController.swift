//
//  MainViewController.swift
//  JustMobiTestApp
//
//  Created by Alexander on 11.07.2025.
//

import UIKit

protocol MainViewProtocol: AnyObject {
    func showData(tagsTitle: String)
    func showImages()
}

final class MainViewController: UIViewController, MainViewProtocol {

    private var presenter: MainPresenterProtocol!
    private var tagsCollectionView: UICollectionView!
    private var imagesCollectionView: UICollectionView!
    private let promoView = BannerView()
    private let giftView = GiftView(timerFontSize: 12)
    
    private lazy var tagsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .black
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = MainPresenter(view: self)
        
        setupUI()
        presenter?.loadData()
        
        giftView.startTimer(seconds: 14)
        giftView.startShaking()
        observeWillEnterForeground()
    }
    
    func showData(tagsTitle: String) {
        tagsLabel.text = tagsTitle
        updateTags()
    }

    func showImages() {
        imagesCollectionView.reloadData()
    }

    private func setupUI() {
        navigationController?.navigationBar.isHidden = true
        
        configureViews()
        configureConstraints()
    }
    
    private func configureViews() {
        view.backgroundColor = .white
        
        setupTagsCollectionView()
        setupImagesCollectionView()
        
        view.addSubview(promoView)
        view.addSubview(tagsLabel)
        view.addSubview(tagsCollectionView)
        view.addSubview(imagesCollectionView)
        view.addSubview(giftView)
    }
    
    private func configureConstraints() {
        promoView.translatesAutoresizingMaskIntoConstraints = false
        tagsLabel.translatesAutoresizingMaskIntoConstraints = false
        tagsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        imagesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        giftView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            promoView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            promoView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            promoView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            tagsLabel.topAnchor.constraint(equalTo: promoView.bottomAnchor, constant: 15),
            tagsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tagsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            tagsCollectionView.topAnchor.constraint(equalTo: tagsLabel.bottomAnchor, constant: 8),
            tagsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tagsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tagsCollectionView.heightAnchor.constraint(equalToConstant: 25),
            
            imagesCollectionView.topAnchor.constraint(equalTo: tagsCollectionView.bottomAnchor, constant: 8),
            imagesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            imagesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            imagesCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            giftView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            giftView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            giftView.widthAnchor.constraint(equalToConstant: 88),
            giftView.heightAnchor.constraint(equalToConstant: 88)
        ])
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
        tagsCollectionView.clipsToBounds = false
    }

    private func setupImagesCollectionView() {
        imagesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: CustomLayout())
        imagesCollectionView.backgroundColor = .clear
        imagesCollectionView.showsVerticalScrollIndicator = false
        imagesCollectionView.dataSource = self
        imagesCollectionView.delegate = self
        imagesCollectionView.register(ImageCell.self, forCellWithReuseIdentifier: ImageCell.reuseIdentifier)
        if let customLayout = imagesCollectionView.collectionViewLayout as? CustomLayout {
            customLayout.invalidateLayout()
        }
    }

    private func updateTags() {
        tagsCollectionView.reloadData()
    }
    
    private func observeWillEnterForeground() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(appWillEnterForeground),
            name: UIApplication.willEnterForegroundNotification,
            object: nil
        )
    }
    
    @objc private func appWillEnterForeground() {
        giftView.startShaking()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == tagsCollectionView {
            return presenter.tagsCount
        } else {
            return presenter.imagesCount
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == tagsCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagCell.reuseIdentifier, for: indexPath) as? TagCell else {
                return UICollectionViewCell()
            }
            let tag = presenter.tag(at: indexPath.item)
            cell.configure(with: tag)
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCell.reuseIdentifier, for: indexPath) as? ImageCell else {
                return UICollectionViewCell()
            }
            let photo = presenter.getImage(at: indexPath.item)
            
            cell.configure(with: photo)
            return cell
        }
    }
}

extension MainViewController: CustomLayoutDelegate {
    
    func collectionView(_ collectionView: UICollectionView, heightForItemAt indexPath: IndexPath, with width: CGFloat) -> CGFloat {
        let image = presenter.getImage(at: indexPath.item)
        let ratio = image.size.height / image.size.width
        let minRatio: CGFloat = 1.3
        let height = width * max(ratio, minRatio)
        return height
    }
}
