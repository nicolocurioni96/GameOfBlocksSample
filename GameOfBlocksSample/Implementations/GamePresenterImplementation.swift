//
//  GamePresenterImplementation.swift
//  GameOfBlocksSample
//
//  Created by Nicolò Curioni on 24/11/22.
//

import Foundation

final class GamePresenterImplementation: GamePresenter {
    
    private var viewModel: GameViewModel
    
    init(viewModel: GameViewModel) {
        self.viewModel = viewModel
    }
    
    // MARK: GamePresenter protocol methods
    func updateSelectedBlock(_ rowIndex: Int, _ columnIndex: Int) {
        self.viewModel.isUserInteractionDisabled = true
        
        var cellIndex: [String : Int] = ["rowIndex" : rowIndex, "columnIndex" : columnIndex]
        
        if !self.viewModel.selectedBlocks.contains(cellIndex) && self.viewModel.selectedBlocks.count < self.viewModel.resultLength {
            self.viewModel.selectedBlocks.append(cellIndex)
        } else {
            return
        }
        
        if rowIndex < self.viewModel.numberOfRows - 1 {
            let rowDifference = (self.viewModel.numberOfRows - rowIndex - 2)
            
            var currentRowIndex = rowIndex
            var hasNeighbor = false
            var count = 0
            
            _ = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
                if count == rowDifference {
                    timer.invalidate()
                    self.viewModel.isUserInteractionDisabled = false
                }
                
                count += 1
                
                let bottomNeighborCheck = self.checkNeighbor(currentRowIndex + 1, columnIndex)
                let horizontalNeigborsCheck = self.checkHorizontalNeighbors(currentRowIndex, columnIndex)
                let activeNeighborsCheck = horizontalNeigborsCheck  || bottomNeighborCheck
                
                if !activeNeighborsCheck {
                    if let index = self.viewModel.selectedBlocks.firstIndex(of: cellIndex) {
                        self.viewModel.selectedBlocks.remove(at: index)
                    }
                    
                    currentRowIndex =  currentRowIndex + 1
                    cellIndex = ["rowIndex" : currentRowIndex, "columnIndex" : columnIndex]
                    
                    if !self.viewModel.selectedBlocks.contains(cellIndex) {
                        self.viewModel.selectedBlocks.append(cellIndex)
                    }
                    
                } else {
                    
                    if !self.viewModel.selectedBlocks.contains(cellIndex) && hasNeighbor == false {
                        if let index = self.viewModel.selectedBlocks.firstIndex(of: cellIndex) {
                            self.viewModel.selectedBlocks.remove(at: index)
                        }
                        
                        hasNeighbor = true
                        self.viewModel.selectedBlocks.append(cellIndex)
                    }
                }
                
                self.showUserScore(activeNeighborsCheck, currentRowIndex)
            }
        }
    }
    
    func checkNeighbor(_ rowIndex: Int, _ columnIndex: Int) -> Bool {
        let leftNeighborIndex: [String : Int] = ["rowIndex" : rowIndex, "columnIndex" : columnIndex]
        
        return self.viewModel.selectedBlocks.contains(leftNeighborIndex) ? true : false
    }
    
    func checkHorizontalNeighbors(_ rowIndex: Int, _ columnIndex: Int) -> Bool {
        let leftNeighborCheck = checkNeighbor(rowIndex, columnIndex - 1)
        let rightNeighborCheck = checkNeighbor(rowIndex, columnIndex + 1)
        
        return leftNeighborCheck && rightNeighborCheck
    }
    
    func showUserScore(_ areActiveNeighbors: Bool, _ currentRowIndex: Int) {
        if self.viewModel.selectedBlocks.count == self.viewModel.resultLength && (areActiveNeighbors || currentRowIndex == self.viewModel.numberOfRows - 1) {
            self.calculateScore()
            
            return
        }
    }
    
    func calculateScore() {
        for blockIndex in 0..<self.viewModel.selectedBlocks.count {
            var score = self.viewModel.initialBlockScore
            var rowIndexOfBlock: Int = self.viewModel.selectedBlocks[blockIndex]["rowIndex"] ?? 0
            var columnIndexOfBlock: Int = self.viewModel.selectedBlocks[blockIndex]["columnIndex"] ?? 0
            
            if rowIndexOfBlock < self.viewModel.numberOfRows {
                let rowDifference = (self.viewModel.numberOfRows - rowIndexOfBlock - 1)
                
                for numberDifference in 0..<rowDifference {
                    let localIndex = rowIndexOfBlock + numberDifference
                    let bottomNeighborCheck = checkNeighbor(localIndex + 1, columnIndexOfBlock)
                    
                    if !bottomNeighborCheck && localIndex + 1 < self.viewModel.numberOfRows {
                        let cellIndex = ["rowIndex" : localIndex + 1, "columnIndex" : columnIndexOfBlock, "score" : self.viewModel.emptyNeighborScore]
                        
                        if !self.viewModel.scoreArray.contains(cellIndex) {
                            self.viewModel.scoreArray.append(cellIndex)
                        }
                        
                    } else if bottomNeighborCheck && rowIndexOfBlock + 1 < self.viewModel.numberOfRows {
                        score += self.viewModel.filledNeighborScore
                    }
                }
                
                let cellIndex = ["rowIndex" : rowIndexOfBlock, "columnIndex" : columnIndexOfBlock, "score" : score]
                
                if !self.viewModel.scoreArray.contains(cellIndex) {
                    self.viewModel.scoreArray.append(cellIndex)
                }
                
                rowIndexOfBlock += 1
            }
            
            calculateScore()
        }
    }
    
    func calculateFinalScore() {
        var totalScore = 0
        
        for index in 0..<self.viewModel.scoreArray.count {
            let blockScore: Int = self.viewModel.scoreArray[index]["score"] ?? 0
            
            totalScore += blockScore
        }
        
        self.viewModel.finalScore = "\(totalScore)"
    }
}
