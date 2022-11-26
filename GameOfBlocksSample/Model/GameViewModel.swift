//
//  GameViewModel.swift
//  GameOfBlocksSample
//
//  Created by Nicolò Curioni on 24/11/22.
//

import Foundation
import SwiftUI

struct GameViewModel {
    let emptyNeighborScore = 1
    let filledNeighborScore = 5
    let initialBlockScore = 5
    let numberOfColumns = 5
    let numberOfRows = 5
    
    var selectedBlocks = [[String : Int]]()
    var scoreArray = [[String : Int]]()
    var finalScore = "0"
    var isUserInteractionDisabled = false
    var resultLength = 10
    var columns: [GridItem] {
        Array(repeating: .init(.adaptive(minimum: 60)), count: numberOfColumns)
    }
}
