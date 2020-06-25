//
//  GeneralViewModel.swift
//  Mediaflex_CV_App
//
//  Created by Damian Tabański on 24/06/2020.
//  Copyright © 2020 Łukasz Bazior. All rights reserved.
//

struct GeneralViewModel {
    let personViewViewModel: PersonViewViewModel
    let elements: [CellViewModel]
}

extension GeneralViewModel {
    init(resume: Resume) {
        self.personViewViewModel = PersonViewViewModel(fullName: resume.name, imageUrl: resume.imageUrl, role: resume.role)
        
        let summaryCellViewModel = CellViewModel(title: resume.summary, imageName: nil, selectable: false)
        let emailCellViewModel = CellViewModel(title: "Email", subtitle: resume.email, imageName: "email", selectable: true)
        let phoneCellViewModel = CellViewModel(title: "Phone", subtitle: resume.phone, imageName: "phone", selectable: true)
        let linkedInCellViewModel = CellViewModel(title: "LinkedIn", subtitle: resume.linkedInUrl, imageName: "linkedIn", selectable: true)
        let githubCellViewModel = CellViewModel(title: "GitHub", subtitle: resume.github, imageName: "github", selectable: true)

        self.elements = [summaryCellViewModel, emailCellViewModel, phoneCellViewModel, linkedInCellViewModel, githubCellViewModel]
    }
}
