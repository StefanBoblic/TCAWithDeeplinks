//
//  HomeView.swift
//
//
//  Created by Stefan Boblic on 03.05.2023.
//

import SwiftUI
import ComposableArchitecture

fileprivate enum HomeViewConstants {
    static let title = "Home"
    static let goToDetailsButton = "Go to Details View"
    static let detailScheme = "tcaWithDeeplinks"
    static let detailHost = "detail"
}

struct Home: ReducerProtocol {
    struct State: Equatable {
        var isShowingDetail = false
    }

    enum Action: Equatable {
        case showDetail
        case hideDetail
        case handleDeeplink(url: URL)
    }

    func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .showDetail:
            state.isShowingDetail = true
            return .none
        case .hideDetail:
            state.isShowingDetail = false
            return .none
        case let .handleDeeplink(url):
            guard let scheme = url.scheme, scheme == HomeViewConstants.detailScheme else { return .none }
            guard let host = url.host, host == HomeViewConstants.detailHost else { return .none }
            state.isShowingDetail = true
            return .none
        }
    }
}

public struct HomeView<Destination: View>: View {
    let store: StoreOf<Home>
    public let destination: Destination

    public init(destination: Destination) {
        self.store = Store(initialState: Home.State(), reducer: Home())
        self.destination = destination
    }

    public var body: some View {
        WithViewStore(self.store) { viewStore in
            NavigationStack {
                NavigationLink(
                    destination: destination,
                    isActive: viewStore.binding(
                        get: { $0.isShowingDetail },
                        send: { $0 ? .showDetail : .hideDetail }
                    )
                ) {
                    EmptyView()
                }.hidden()

                Button(action: { viewStore.send(.showDetail) }) {
                    Text(HomeViewConstants.goToDetailsButton)
                }
                .navigationTitle(HomeViewConstants.title)
                .navigationBarTitleDisplayMode(.large)
                .onOpenURL { url in
                    viewStore.send(.handleDeeplink(url: url))
                }
            }
        }
    }
}

// MARK: - SwiftUI previews
struct DetailViewMock: View {
    var body: some View {
        Text("DetailView")
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(destination: DetailViewMock())
    }
}

