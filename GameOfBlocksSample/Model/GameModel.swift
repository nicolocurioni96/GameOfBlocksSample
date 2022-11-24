//
//  GameModel.swift
//  GameOfBlocksSample
//
//  Created by Nicolò Curioni on 24/11/22.
//

import Foundation

struct GameData {
    var selectedBlocks = [[String : Int]]()
    var scoreArray = [[String : Int]]()
    var finalScore = ""
    var isUserInteractionDisabled = false
}
