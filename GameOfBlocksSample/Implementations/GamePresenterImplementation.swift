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
        
    }
    
    func checkNeighbor(_ rowIndex: Int, _ columnIndex: Int) -> Bool {
        return false
    }
    
    func checkHorizontalNeighbors(_ rowIndex: Int, _ columnIndex: Int) -> Bool {
        return false
    }
    
    func showUserScore(_ areActiveNeighbors: Bool, _ currentRowIndex: Int) {
        
    }
    
    func calculateScore() {
        
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
