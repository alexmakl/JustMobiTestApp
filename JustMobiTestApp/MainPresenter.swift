//
//  MainPresenter.swift
//  JustMobiTestApp
//
//  Created by Alexander on 11.07.2025.
//

import Foundation

protocol MainPresenterProtocol {
    var tagsCount: Int { get }
    func tag(at index: Int) -> Tag
    func loadData()
}

final class MainPresenter: MainPresenterProtocol {
    
    weak var view: MainViewProtocol?
    
    var tagsCount: Int { tags.count }
    func tag(at index: Int) -> Tag { tags[index] }
    
    private var tags: [Tag] = []
    
    init(view: MainViewProtocol) {
        self.view = view
    }
    
    func loadData() {
        tags = loadTags()
        view?.showData(tagsTitle: "Подходит для:")
    }
    
    func loadTags() -> [Tag] {
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
}
