//
//  GeneralViewControllerTests.swift
//  ResumeAppTests
//
//  Created by Łukasz Bazior on 21/06/2020.
//  Copyright © 2020 Łukasz Bazior. All rights reserved.
//

import XCTest
@testable import ResumeApp

class GeneralViewControllerTests: XCTestCase {
    
    func test_personViewSubviews_areSet_onUpdateWithViewModel() {
        let sut = makeSUT()
        let personVM = PersonViewViewModel(fullName: "name", imageUrl: "https://docs-assets.developer.apple.com/published/06ba0eba91/63b0c95b-bf2f-4798-9cca-8a5e77631679.png", role: "role")
        let viewModel =
            GeneralViewModel(personViewViewModel: personVM, elements: [])
        
        sut.update(viewModel: viewModel)
        XCTAssertEqual(sut.personView.nameLabel.text, viewModel.personViewViewModel.fullName)
        XCTAssertEqual(sut.personView.roleLabel.text, viewModel.personViewViewModel.role)
        XCTAssertNotNil(sut.personView.imageView.image)
    }
    
    func test_tableViewElements_basedOnViewModelElements() {
        let sut = makeSUT()
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 0)
        
        sut.update(viewModel: makeViewModel(elements: []))
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 0)
        
        sut.update(viewModel: makeViewModel(elements: [dummyCellViewModel()]))
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 1)
        
        sut.update(viewModel: makeViewModel(elements: [dummyCellViewModel(), dummyCellViewModel(), dummyCellViewModel()]))
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 3)
    }
    
    func test_renderedCell_styleSubtitle() {
        let sut = makeSUT()
        sut.update(viewModel: makeViewModel(elements: [CellViewModel()]))
        let cell = sut.tableView(sut.tableView, cellForRowAt: IndexPath(row: 0, section: 0))
        XCTAssertNotNil(cell)
        XCTAssertEqual(cell.cellStyle, .subtitle)
    }
    
    func test_tableViewCell_text_isViewModelTitle() {
        let sut = makeSUT()
        let cellViewModel = CellViewModel(title: "First")
        sut.update(viewModel: makeViewModel(elements: [cellViewModel]))
                
        let cell = sut.tableView.cell(at: 0)
        XCTAssertEqual(cell?.textLabel?.text, "First")
    }
    
    func test_tableViewCell_image_renderedByViewModelImageName() {
        let sut = makeSUT()
        let cellViewModel = CellViewModel(imageName: "linkedIn")
        sut.update(viewModel: makeViewModel(elements: [cellViewModel]))
                
        let cell = sut.tableView.cell(at: 0)
        XCTAssertNotNil(cell?.imageView?.image)
    }
    
    func test_tableViewCell_noImage_renderedByViewModelWithoutImageName() {
        let sut = makeSUT()
        let cellViewModel = CellViewModel(imageName: nil)
        sut.update(viewModel: makeViewModel(elements: [cellViewModel]))
                
        let cell = sut.tableView.cell(at: 0)
        XCTAssertNil(cell?.imageView?.image)
    }
    
    func test_tableViewCell_defaultSelection_renderedByViewModelSelectable() {
        let sut = makeSUT()
        let cellViewModel = CellViewModel(selectable: true)
        sut.update(viewModel: makeViewModel(elements: [cellViewModel]))
                
        let cell = sut.tableView.cell(at: 0)
        XCTAssertEqual(cell?.selectionStyle, .default)
    }
    
    func test_tableViewCell_noneSelection_renderedByViewModelNotSelectable() {
        let sut = makeSUT()
        let cellViewModel = CellViewModel(selectable: false)
        sut.update(viewModel: makeViewModel(elements: [cellViewModel]))
                
        let cell = sut.tableView.cell(at: 0)
        XCTAssertEqual(cell?.selectionStyle, UITableViewCell.SelectionStyle.none)
    }
    
    func test_tableViewCell_subtitle_fromViewModel() {
        let sut = makeSUT()
        let cellViewModel = CellViewModel(subtitle: "text")
        sut.update(viewModel: makeViewModel(elements: [cellViewModel]))
                
        let cell = sut.tableView.cell(at: 0)
        XCTAssertEqual(cell?.detailTextLabel?.text, "text")
    }
    
    func test_tableViewCell_defaultNoSubtitle() {
        let sut = makeSUT()
        let cellViewModel = CellViewModel()
        sut.update(viewModel: makeViewModel(elements: [cellViewModel]))
                
        let cell = sut.tableView.cell(at: 0)
        XCTAssertNil(cell?.detailTextLabel?.text)
    }
    
    func test_tableViewCell_hasChevron_whenSelectable() {
        let sut = makeSUT()
        let cellViewModel = CellViewModel(selectable: true)
        sut.update(viewModel: makeViewModel(elements: [cellViewModel]))
                
        let cell = sut.tableView.cell(at: 0)
        XCTAssertEqual(cell?.accessoryType, UITableViewCell.AccessoryType.disclosureIndicator)
    }
    
    func test_tableViewCell_hasNoChevron_whenNotSelectable() {
        let sut = makeSUT()
        let cellViewModel = CellViewModel(selectable: false)
        sut.update(viewModel: makeViewModel(elements: [cellViewModel]))
                
        let cell = sut.tableView.cell(at: 0)
        XCTAssertEqual(cell?.accessoryType, UITableViewCell.AccessoryType.none)
    }
    
    func test_tableViewDidSelectCell_callsPresenterDidSelectRow() {
        let sut = makeSUT()
        let presenter = MockGeneralPresenter()
        sut.presenter = presenter
        
        sut.update(viewModel: makeViewModel(elements: [CellViewModel(), CellViewModel()]))
        
        sut.tableView(sut.tableView, didSelectRowAt: IndexPath(row: 1, section: 0))
        XCTAssertEqual(presenter.selectedRows, [1])
        
        sut.tableView(sut.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
        XCTAssertEqual(presenter.selectedRows, [1, 0])
        
        sut.tableView(sut.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
        XCTAssertEqual(presenter.selectedRows, [1, 0, 0])
    }
    
    
    // MARK: Helpers
    
    private func makeSUT() -> GeneralViewController {
        let sut = GeneralViewController()
        sut.loadViewIfNeeded()
        return sut
    }
    
    private func makeViewModel(elements: [CellViewModel] = []) -> GeneralViewModel {
        GeneralViewModel(personViewViewModel: PersonViewViewModel(fullName: "", imageUrl: "", role: ""), elements: elements)
    }
    
    private func dummyCellViewModel() -> CellViewModel {
        CellViewModel(title: "")
    }

}