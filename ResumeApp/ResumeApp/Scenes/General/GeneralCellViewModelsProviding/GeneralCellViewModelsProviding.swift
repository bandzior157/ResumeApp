//
//  GeneralCellViewModelsProviding.swift
//  ResumeApp
//
//  Created by Łukasz Bazior on 26/06/2020.
//  Copyright © 2020 Łukasz Bazior. All rights reserved.
//

protocol GeneralCellViewModelsProviding {
    func get(for cellTypes: [GeneralCellType]) -> [CellViewModel]
}
