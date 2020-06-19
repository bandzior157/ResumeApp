//
//  MainViewControllerTests.swift
//  Mediaflex_CV_AppTests
//
//  Created by Łukasz Bazior on 19/06/2020.
//  Copyright © 2020 Łukasz Bazior. All rights reserved.
//

import XCTest
@testable import Mediaflex_CV_App

class MainViewControllerTests: XCTestCase {
    
    func test_childrenCount_equals_one() {
        XCTAssertEqual(makeSUT().children.count, 1)
    }
    
    func test_tabBarItems() {
        let sut = makeSUT()
        let tabBarItemsProperties = [TabBarItemProperties(title: "General", imageSystemName: "person.crop.circle")]
                
        for child in sut.children {
            test_tabBarItem(child.tabBarItem, properties: tabBarItemsProperties[0])
        }
    }
    
    private func test_tabBarItem(_ tabBarItem: UITabBarItem, properties: TabBarItemProperties) {
       XCTAssertEqual(tabBarItem.title, properties.title)
       XCTAssertEqual(tabBarItem.image, UIImage(systemName: properties.imageSystemName))
    }
    
    
    // MARK: - Helpers
    
    private func makeSUT() -> UITabBarController {
        MainTabBarController()
    }
    
}

struct TabBarItemProperties {
    let title: String
    let imageSystemName: String
}
