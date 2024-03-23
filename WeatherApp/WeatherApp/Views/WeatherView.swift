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
    
    static func getSections(isLoading: Bool) -> [CollectionViewSection] {
        var sections = allCases
        if isLoading {
            sections.removeLast()
            return sections
        } else {
            return sections
        }
    }
}

class WeatherView: UIView {
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    @UseAutolayout var errorView = ErrorView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = Constants.colors.lightGray
        backgroundColor = .systemBackground
        addSubview(collectionView)
        addSubview(errorView)
        errorView.isHidden = true
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            
            errorView.topAnchor.constraint(equalTo: topAnchor),
            errorView.leadingAnchor.constraint(equalTo: leadingAnchor),
            errorView.trailingAnchor.constraint(equalTo: trailingAnchor),
            errorView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout {
            (sectionIndex, layoutEnviroment) -> NSCollectionLayoutSection? in
            
            let section = CollectionViewSection.allCases[sectionIndex]
        
            switch section {
            case .main:
                let itemSize = Constants.layout.mainSectionItemSize
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = Constants.layout.mainSectionItemContentInsets
                
                let groupSize = Constants.layout.mainSectionGroupSize
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize,
                                                             repeatingSubitem: item,
                                                             count: Constants.layout.mainSectionGroupItemsCount)
                
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = Constants.layout.mainSectionContentInsets
                let background = NSCollectionLayoutDecorationItem.background(elementKind: SectionBackgroundView.kindIdenifier)
                background.contentInsets  = Constants.layout.mainSectionBackgroundContentInsets
                section.decorationItems = [background]
                
                return section
            case .detail:
                //MARK: - Main/Detail Sections Layout
                let itemSize = Constants.layout.detailSectionItemSize
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets.bottom = Constants.layout.detailSectionItemBottomContentInset
                
                let groupSize = Constants.layout.detailSectionGroupSize
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize,
                                                             repeatingSubitem: item,
                                                             count: Constants.layout.detailSectionGroupItemsCount)
                
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = Constants.layout.detailSectionContentInsets
                
                let headerSize = Constants.layout.detailSectionHeaderSize
                let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
                section.boundarySupplementaryItems = [header]
                
                let background = NSCollectionLayoutDecorationItem.background(elementKind: SectionBackgroundView.kindIdenifier)
                background.contentInsets  = Constants.layout.detailSectionBackgroundContentInsets
                
                section.decorationItems = [background]
                
                return section
            case .sevenDays:
                //MARK: - SevenDays Section Layout
                let itemSize = Constants.layout.sevenDaysSectionItemSize
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = Constants.layout.sevenDaysSectionGroupSize
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize,
                                                               repeatingSubitem: item,
                                                             count: Constants.layout.sevenDaysSectionGroupItemsCount)
        
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = Constants.layout.sevenDaysSectionContentInsets
                
                let headerSize = Constants.layout.sevenDaysSectionHeaderSize
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

