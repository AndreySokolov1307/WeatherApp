//
//  WeatherViewController+Layout.swift
//  WeatherApp
//
//  Created by Андрей Соколов on 23.03.2024.
//

import UIKit

extension WeatherViewController {
    func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout {
            (sectionIndex, layoutEnviroment) -> NSCollectionLayoutSection? in
            
            let section = Section.allCases[sectionIndex]
        
            switch section {
            //MARK: - Detail Sections Layout
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
            case .hourly:
                let itemSize = Constants.layout.hourlySectionItemSize
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = Constants.layout.hourlySectionGroupSize
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                               subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.contentInsets = Constants.layout.hourlySectionContentInsets
                
                let background = NSCollectionLayoutDecorationItem.background(elementKind: SectionBackgroundView.kindIdenifier)
                background.contentInsets.bottom = Constants.layout.hourlySectionBackgroundBottomInset
                
                section.decorationItems = [background]
                
                return section
            //MARK: - Detail Sections Layout
            case .detail:
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
            //MARK: - SevenDays Section Layout
            case .sevenDays:
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
