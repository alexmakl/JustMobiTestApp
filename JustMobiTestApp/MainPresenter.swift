//
//  MainPresenter.swift
//  JustMobiTestApp
//
//  Created by Alexander on 11.07.2025.
//

import UIKit
import Foundation

protocol MainPresenterProtocol {
    var tagsCount: Int { get }
    var imagesCount: Int { get }
    func tag(at index: Int) -> Tag
    func getImage(at index: Int) -> UIImage
    func loadData()
}

final class MainPresenter: MainPresenterProtocol {
    
    private weak var view: MainViewProtocol?
    private var tags: [Tag] = []
    private var images: [UIImage] = []
    
    init(view: MainViewProtocol) {
        self.view = view
    }
    
    var tagsCount: Int {
        tags.count
    }
    
    var imagesCount: Int {
        images.count
    }
    
    func tag(at index: Int) -> Tag {
        tags[index]
    }
    
    func getImage(at index: Int) -> UIImage {
        images[index]
    }
    
    func loadData() {
        tags = loadTags()
        view?.showData(tagsTitle: "Подходит для:")
        loadImages()
    }
    
    private func loadTags() -> [Tag] {
        guard let url = Bundle.main.url(forResource: "tags", withExtension: "json")
        else {
            return []
        }
        
        do {
            let data = try Data(contentsOf: url)
            let tags = try JSONDecoder().decode([Tag].self, from: data)
            return tags
        } catch {
            print("Failed to load tags: \(error)")
            return []
        }
    }
    
    private func loadImages() {
        guard let imageUrls = Bundle.main.url(forResource: "images", withExtension: "json") else {
            view?.showImages()
            return
        }
        do {
            let data = try Data(contentsOf: imageUrls)
            let names = try JSONDecoder().decode([String].self, from: data)
            self.images = []
            for name in names {
                if let image = UIImage(named: name) {
                    images.append(image)
                }
            }
        } catch {
            print("Failed to load images: \(error)")
            self.images = []
        }
        view?.showImages()
    }
}
