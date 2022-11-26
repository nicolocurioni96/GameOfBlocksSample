//
//  GamePresenter.swift
//  GameOfBlocksSample
//
//  Created by Nicolò Curioni on 24/11/22.
//

import SwiftUI

protocol GamePresenterProtocol: ObservableObject {
    var viewModel: GameViewModel { get set }
    
    func updateSelectedBlock(_ rowIndex: Int, _ columnIndex: Int)
    func checkNeighbor(_ rowIndex: Int, _ columnIndex: Int) -> Bool
    func checkHorizontalNeighbors(_ rowIndex: Int, _ columnIndex: Int) -> Bool
    func showUserScore(_ areActiveNeighbors: Bool, _ currentRowIndex: Int)
    func calculateScore()
    func calculateFinalScore()
}
