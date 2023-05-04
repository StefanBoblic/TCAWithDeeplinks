//
//  TCAWithDeeplinksTests.swift
//  TCAWithDeeplinksTests
//
//  Created by Stefan Boblic on 10.04.2023.
//

import XCTest
import ComposableArchitecture

@testable import Home

@MainActor
final class TCAWithDeeplinksTests: XCTestCase {

    func testDeeplinkNavigationSuccess() async {
        let deeplinkPath = URL(string: "tcaWithDeeplinks://detail")!

        let store = TestStore(initialState: Home.State(), reducer: Home())

        await store.send(.handleDeeplink(url: deeplinkPath)) {
            $0.isShowingDetail = true
        }
    }

    func testDeeplinkNavigationFailure() async {
        let deeplinkPath = URL(string: "tcaWithDeeplinks://detailsss")!

        let store = TestStore(initialState: Home.State(), reducer: Home())

        await store.send(.handleDeeplink(url: deeplinkPath))
    }
}
