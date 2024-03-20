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
    func changeCount(count: Int) {
        self.count = count
    }
}
class CollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    @IBOutlet weak var mineSweeperCollection: UICollectionView!
    var index = 0;
    var fieldindex = 0;
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
        return Int(size*size*size) + Int(size - 1)*5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if initialClear {
            createMines(gridSize: size)
            countMines(gridSize: size)
        } else {
            
        }
        if (indexPath.row)%(size*size + size) < size*size {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MineCell
            cell.backgroundColor = UIColor.red
            var spot = ArraySpot(gridSize: size, number: indexPath.row)
            cell.mineIcon.image = mineField[spot[0]][spot[1]][spot[2]].icon
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "spaceCell", for: indexPath)
            return cell
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (indexPath.row)%(size*size + size) < size*size {
            //print(ArraySpot(gridSize: size, number: indexPath.row))
            var spot = ArraySpot(gridSize: size, number: indexPath.row)
            mineField[spot[0]][spot[1]][spot[2]].icon = icons[mineField[spot[0]][spot[1]][spot[2]].count]!
            collectionView.reloadData()
        }
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
    
    func countMines(gridSize: Int) {
             for ex in 0..<mineField.count {
                 for y in 0..<mineField[0].count {
                     for z in 0..<mineField[0][0].count {
                         var mineCounter = 0
                         //check above
                         if !mineField[ex][y][z].mine {
                             if ex != gridSize-1 {
                                 if (mineField[ex+1][y][z].mine) {
                                     mineCounter = mineCounter + 1
                                 }
                                 if (y-1 > 0) {
                                     if (mineField[ex+1][y-1][z].mine) {
                                         mineCounter = mineCounter + 1
                                     }
                                 }
                                 if (z-1 > 0) {
                                     if (mineField[ex+1][y][z-1].mine) {
                                         mineCounter = mineCounter + 1
                                     }
                                 }
                                 if (y+1 < 5) {
                                     if (mineField[ex+1][y+1][z].mine) {
                                         mineCounter = mineCounter + 1
                                     }
                                 }
                                 if (z+1 < 5) {
                                     if (mineField[ex+1][y][z+1].mine) {
                                         mineCounter = mineCounter + 1
                                     }
                                 }
                             }
                             //same layer
                             if (y-1 > 0) && (z-1 > 0) {
                                 if (mineField[ex][y-1][z-1].mine) {
                                     mineCounter = mineCounter + 1
                                 }
                             }
                             if (y-1 > 0) {
                                 if (mineField[ex][y-1][z].mine) {
                                     mineCounter = mineCounter + 1
                                 }
                             }
                             if (y-1 > 0) && (z+1 < 5) {
                                 if (mineField[ex][y-1][z+1].mine) {
                                     mineCounter = mineCounter + 1
                                 }
                             }
                             if (z-1 > 0) {
                                 if (mineField[ex][y][z-1].mine) {
                                     mineCounter = mineCounter + 1
                                 }
                             }
                             if (z+1 < 5) {
                                 if (mineField[ex][y][z+1].mine) {
                                     mineCounter = mineCounter + 1
                                 }
                             }
                             if (y+1 < 5) && (z-1 > 0) {
                                 if (mineField[ex][y+1][z-1].mine) {
                                     mineCounter = mineCounter + 1
                                 }
                             }
                             if (y+1 < 5) {
                                 if (mineField[ex][y+1][z].mine) {
                                     mineCounter = mineCounter + 1
                                 }
                             }
                             if (y+5 < 5) && (z+1 < 5) {
                                 if (mineField[ex][y+1][z+1].mine) {
                                     mineCounter = mineCounter + 1
                                 }
                             }
                             //check below
                             if ex != 0 {
                                 if (mineField[ex-1][y][z].mine) {
                                     mineCounter = mineCounter + 1
                                 }
                                 if (y-1 > 0) {
                                     if (mineField[ex-1][y-1][z].mine) {
                                         mineCounter = mineCounter + 1
                                     }
                                 }
                                 if (z-1 > 0) {
                                     if (mineField[ex-1][y][z-1].mine) {
                                         mineCounter = mineCounter + 1
                                     }
                                 }
                                 if (y+1 < 5) {
                                     if (mineField[ex-1][y+1][z].mine) {
                                         mineCounter = mineCounter + 1
                                     }
                                 }
                                 if (z+1 < 5) {
                                     if (mineField[ex-1][y][z+1].mine) {
                                         mineCounter = mineCounter + 1
                                     }
                                 }
                             }
                         }
                         mineField[ex][y][z].changeCount(count: mineCounter)
                     }
                 }
             }
         }

    func ArraySpot(gridSize: Int, number: Int) -> [Int] {
            var xpos = number/(gridSize*gridSize + gridSize)
            let num = (xpos) * (gridSize)
            var ypos = (number - num)%(gridSize*gridSize)/(gridSize)
            var zpos = (number - num)%(gridSize)

            return [xpos,ypos,zpos]
       }
}
