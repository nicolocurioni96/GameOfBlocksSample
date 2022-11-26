//
//  GameView.swift
//  GameOfBlocksSample
//
//  Created by Nicolò Curioni on 24/11/22.
//

import SwiftUI
import Combine

struct GameView: View {
    
    @ObservedObject private var presenter = GamePresenterImplementation()
    
    var body: some View {
        HStack(spacing: 0) {
            Text("Score: \(presenter.viewModel.finalScore)")
        }
        .font(.subheadline)
        .frame(height: 100)
        
        ScrollView(.vertical, showsIndicators: false) {
            ForEach(0..<presenter.viewModel.numberOfRows) { rowIndex in
                LazyVGrid(columns: presenter.viewModel.columns, spacing: 20) {
                    ForEach(0..<presenter.viewModel.numberOfColumns) { columnIndex in
                        let cellIndex: [String : Int] = ["rowIndex" : rowIndex, "columnIndex" : columnIndex]
                        let results = presenter.viewModel.scoreArray.filter { $0["rowIndex"] == rowIndex && $0["columnIndex"] == columnIndex }
                        
                        Button(action: {
                            self.presenter.updateSelectedBlock(rowIndex, columnIndex)
                        }) {
                            
                            Text(results.count > 0 ? "\(results[0]["score"] ?? 0 )" : "     ")
                        }
                        .frame(width: 50, height: 50)
                        .border(Color.black, width: 2)
                        .background(presenter.viewModel.selectedBlocks.contains(cellIndex) ? Color.orange : Color.white)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
        }.disabled(presenter.viewModel.isUserInteractionDisabled)
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
