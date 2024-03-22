//
//  WeatherView.swift
//  WeatherApp
//
//  Created by Андрей Соколов on 20.03.2024.
//

import UIKit

enum CollectionViewSection: CaseIterable {
    case main
    case detail
    case sevenDays
}

class WeatherView: UIView {
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        backgroundColor = .systemBackground
        addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout {
            (sectionIndex, layoutEnviroment) -> NSCollectionLayoutSection? in
            
            let section = CollectionViewSection.allCases[sectionIndex]
        
            switch section {
            case .main:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 24, leading: 0, bottom: 24, trailing: 0)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.3))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize,
                                                             repeatingSubitem: item,
                                                             count: 1)
                
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 24, leading: 24, bottom: 24, trailing: 24)
                let background = NSCollectionLayoutDecorationItem.background(elementKind: SectionBackgroundView.kindIdenifier)
                background.contentInsets  = NSDirectionalEdgeInsets(top: 24, leading: 0, bottom: 24, trailing: 0)
                section.decorationItems = [background]
                
                return section
            case .detail:
                //MARK: - Main/Detail Sections Layout
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets.bottom = 24
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.3))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize,
                                                             repeatingSubitem: item,
                                                             count: 1)
                
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 24, bottom: 24, trailing: 24)
                
                let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0) ,
                                                        heightDimension: .absolute(40))
                let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
                section.boundarySupplementaryItems = [header]
                
                let background = NSCollectionLayoutDecorationItem.background(elementKind: SectionBackgroundView.kindIdenifier)
                background.contentInsets  = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 24, trailing: 0)
                
                section.decorationItems = [background]
                
                return section
            case .sevenDays:
                //MARK: - SevenDays Section Layout
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                      heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                       heightDimension: .absolute(60.0))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize,
                                                               repeatingSubitem: item,
                                                               count: 1)
        
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 24, bottom: 24, trailing: 24)
                
                let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0) ,
                                                        heightDimension: .absolute(40))
                let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
                section.boundarySupplementaryItems = [header]
                
                let background = NSCollectionLayoutDecorationItem.background(elementKind: SectionBackgroundView.kindIdenifier)
                section.decorationItems = [background]
                
                return section
            }
        }
        layout.register(SectionBackgroundView.self, forDecorationViewOfKind: SectionBackgroundView.kindIdenifier)
    
        return layout
    }
}

