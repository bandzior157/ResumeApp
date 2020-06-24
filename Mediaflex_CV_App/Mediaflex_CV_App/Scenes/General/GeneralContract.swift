//
//  GeneralContract.swift
//  Mediaflex_CV_App
//
//  Created by Łukasz Bazior on 21/06/2020.
//  Copyright © 2020 Łukasz Bazior. All rights reserved.
//

protocol GeneralViewing {
    func update(viewModel: GeneralViewModel)
}

protocol GeneralPresenting {
    func setResume(_ resume: Resume)
}