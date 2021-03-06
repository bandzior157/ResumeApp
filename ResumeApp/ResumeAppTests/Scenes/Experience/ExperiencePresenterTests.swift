//
//  ExperiencePresenterTests.swift
//  ResumeAppTests
//
//  Created by Łukasz Bazior on 27/06/2020.
//  Copyright © 2020 Łukasz Bazior. All rights reserved.
//

import XCTest
@testable import ResumeApp

class ExperiencePresenterTests: XCTestCase {
    
    func test_updatePresentableModel_afterSettingResume() {
        let sut = makeSUT()
        let view = MockExperienceView()
        sut.view = view
        
        let january2000 = Date(timeIntervalSince1970: 949093397)
        let december2010 = Date(timeIntervalSince1970: 1293570197)
        
        let details = [
            CompanyExperienceDetails(title: "ED1", elements: ["ED1.1", "ED1.2"]),
            CompanyExperienceDetails(title: "ED2", elements: ["ED2.1"])
        ]
        
        let resume = Resume(experience: [
            CompanyExperience(
                companyName: "company",
                companyLogoUrlString: "logo",
                role: "role",
                dateFrom: january2000,
                dateTo: december2010,
                details: details)])
        sut.setResume(resume)
        
        let expected = [ExperiencePresentableModel(cellPresentableModels: [
            CellPresentableModel(
                title: "company\nrole",
                subtitle: "01.2000 - 12.2010",
                image: .init(type: .url(string: "logo"), size: Size(width: 80, height: 80)),
                selectable: true)])]
        XCTAssertEqual(view.updatePresentableModels, expected)
    }
    
    func test_routerPresent_getCalled_onPresenterDidSelect() {
        let sut = makeSUT()
        let router = MockRouter()
        sut.router = router
        
        let companyExperience = CompanyExperience(companyName: "", companyLogoUrlString: "", role: "", dateFrom: Date(), dateTo: Date(), details: [CompanyExperienceDetails(title: "A", elements: ["A1", "A2"]), CompanyExperienceDetails(title: "B", elements: ["B1"])])
        let resume = Resume(experience: [companyExperience])
        sut.setResume(resume)
        sut.didSelect(row: 0)
        
        XCTAssertEqual(router.showedCompanyExperiences, [companyExperience])
    }
    
    
    // MARK: - Helpers
    
    private func makeSUT() -> ExperiencePresenter {
        ExperiencePresenter()
    }
    
}
