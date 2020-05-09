//
//  ViewController.swift
//  collectionViewCompos
//
//  Created by Sameh sayed on 5/6/20.
//  Copyright © 2020 Sameh sayed. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var collectionView:UICollectionView!
    lazy var dataSource =    makeDataSource()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.


        collectionView.register(UINib(nibName: "HomeHeroCell", bundle: nil), forCellWithReuseIdentifier: "heroCell")
        collectionView.register(UINib(nibName: "HomeSmallCell", bundle: nil), forCellWithReuseIdentifier: "smallCell")
        
        collectionView.dataSource = dataSource
        collectionView.delegate = self
        
        collectionView.collectionViewLayout = createLayout()
        update()


    }

    func makeDataSource() -> UICollectionViewDiffableDataSource<Sections,Letter>{
        return UICollectionViewDiffableDataSource(collectionView:collectionView) { (collectionView, index, object) -> UICollectionViewCell? in
            if index.section == 0 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "heroCell", for: index) as! HomeCell
                cell.title.text = object.name
                cell.imageView.image = object.image
                return cell
            }
            else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "smallCell", for: index) as! HomeCell
                cell.title.text = object.name
                cell.title.textColor = object.color
                cell.imageView.image = object.image
                return cell
            }

        }
    }

    func update(){
        var snapshot = NSDiffableDataSourceSnapshot<Sections,Letter>()

        snapshot.appendSections(Sections.allCases)


        snapshot.appendItems([
            Letter(name: "New Collection",color: .white,image: #imageLiteral(resourceName: "HomeHero"))
        ], toSection: .hero)
        snapshot.appendItems([
            Letter(name: "Summer Sale",color:UIColor.red,image:nil),
            Letter(name: "Black",color:.white,image: #imageLiteral(resourceName: "smallCell")),
            Letter(name: "",color: .white,image: #imageLiteral(resourceName: "sideCell"))]
            , toSection: .main)


        dataSource.apply(snapshot,animatingDifferences: true)

    }

    enum Sections:CaseIterable{
        case hero,main
    }

    struct Letter:Hashable{
        let id = UUID()
        let name:String
        let color:UIColor
        let image:UIImage?
    }


    private func createLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int,
            layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in


            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                  heightDimension: .fractionalHeight(1.0))

            let item = NSCollectionLayoutItem(layoutSize: itemSize)

            let itemEdges = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)

            item.contentInsets = itemEdges

            if sectionIndex == 0 {
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                       heightDimension: .fractionalWidth(1.0))

                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                               subitems: [item])

                let section = NSCollectionLayoutSection(group: group)
                return section

            }else  {

                let smallGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                heightDimension: .fractionalWidth(1.0))

                let smallGroup = NSCollectionLayoutGroup.vertical(layoutSize: smallGroupSize, subitem: item, count: 2)

                let leftItemSize =  NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                               heightDimension: .fractionalWidth(1.0))
                let leftItem = NSCollectionLayoutItem(layoutSize: leftItemSize)
                leftItem.contentInsets = itemEdges

                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                            heightDimension: .fractionalWidth(1.0))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                                    subitems: [smallGroup,leftItem])

                     let section = NSCollectionLayoutSection(group: group)
                     return section
            }



//
//            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.4),
//                                                  heightDimension: .fractionalHeight(1.0))
//            let item = NSCollectionLayoutItem(layoutSize: itemSize)
//            item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 10, bottom: 10, trailing: 5)
//
//            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
//                                                   heightDimension: .absolute(100))
//
//            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
//                                                           subitems: [item])
//
        }
        return layout
    }
}

extension ViewController:UICollectionViewDelegate
{
    //    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //        let item = dataSource.itemIdentifier(for: indexPath)
    //        print(item?.name)
    //    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = dataSource.itemIdentifier(for: indexPath)
//        present(UIViewController(), animated: true, completion: nil)
//        print(item?.name)
    }
}



class CollectionViewCell:UICollectionViewCell{
    @IBOutlet var label:UILabel!

}
