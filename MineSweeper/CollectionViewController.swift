//
//  CollectionViewController.swift
//  MineSweeper
//
//  Created by BRIAN WANG on 3/6/24.
//

import UIKit
//fdsfsdfd

class Mine{
    var cleared: Bool
    var mine: Bool
    var count: Int
    var icon: UIImage
    
    init(cleared: Bool, mine: Bool, count: Int, icon: UIImage) {
        self.cleared = cleared
        self.mine = mine
        self.count = count
        self.icon = icon
    }
    init(){
        self.cleared = false
        self.mine = false
        self.count = 0
        self.icon = UIImage(named: "Minesweeper_unopened_square")!
    }
}
class CollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    @IBOutlet weak var mineSweeperCollection: UICollectionView!
    var index = 0;
    var mineField: [[[Mine]]] = []
    var size = 0
    var initialClear = true
    var icons = [UIImage(named: "Minesweeper_unopened_square"),
                 UIImage(named: "Minesweeper_1.svg"),
                 UIImage(named: "Minesweeper_2.svg"),
                 UIImage(named: "Minesweeper_3.svg"),
                 UIImage(named: "Minesweeper_4.svg"),
                 UIImage(named: "Minesweeper_5.svg"),
                 UIImage(named: "Minesweeper_6.svg"),
                 UIImage(named: "Minesweeper_7.svg"),
                 UIImage(named: "Minesweeper_8.svg"),]
    override func viewDidLoad() {
        super.viewDidLoad()
        size = delegate.size
        mineSweeperCollection.dataSource = self
        mineSweeperCollection.delegate = self
        let layout = UICollectionViewFlowLayout()
                    layout.minimumLineSpacing = 0
                    layout.minimumInteritemSpacing = 0
                    layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: 393.0/Double(size), height: 393.0/Double(size))
        mineSweeperCollection.collectionViewLayout = layout
       
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Int(size*size*size) + Int(size)
    }
    //working on
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
////
////            if indexPath.item == 0 {
////                width = 100
////                height = 100
////            } else {
////                width = 50
////                height = 50
////            }
////            return CGSizeMake(width, height)
//
//    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MineCell
        cell.backgroundColor = UIColor.red
        cell.mineIcon.image = UIImage(named: "Minesweeper_unopened_square")
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        index = indexPath.row
        if initialClear {
            createMines(gridSize: 5)
        }
        collectionView.reloadData()
    }
    func createMines (gridSize: Int) {
            
            for z in 0..<gridSize {
                
                var grid: [[Mine]] = [[]]
                for row in 0..<gridSize {
                    var newRow: [Mine] = []
                    
                    for column in 0..<gridSize {
                        let randomInt = Int.random(in: 0...4)
                        if randomInt == 0 {
                            newRow.append(Mine(cleared: false, mine: true, count: 0, icon: icons[0]!))
                            newRow[column].count = -1
                        } else {
                            newRow.append(Mine(cleared: false, mine: false, count: 0, icon: icons[0]!))
                        }
                    }
                    if row == 0 {
                        grid[0] = newRow
                    } else {
                        grid.append(newRow)
                    }
                }
                mineField.append(grid)
            }
            
            initialClear = false
            print(mineField)
        }

}
