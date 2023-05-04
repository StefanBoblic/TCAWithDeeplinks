//
//  DetailView.swift
//
//
//  Created by Stefan Boblic on 03.05.2023.
//

import SwiftUI
import ComposableArchitecture

fileprivate enum DetailViewConstants {
    static let title = "Detail"
    static let viewInfo = "This is the detail view!"
}

struct Detail: ReducerProtocol {
    struct State: Equatable {
        var isShown = false
    }

    enum Action {
        case setShown(isShown: Bool)
    }

    func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case let .setShown(isShown):
            state.isShown = isShown
            return .none
        }
    }
}

public struct DetailView: View {
    var store: StoreOf<Detail>

    public init() {
        self.store = Store(initialState: Detail.State(), reducer: Detail())
    }

    public var body: some View {
        WithViewStore(self.store) { viewStore in
            VStack {
                Text(DetailViewConstants.viewInfo)
                Spacer()
            }
            .navigationTitle(DetailViewConstants.title)
            .navigationBarTitleDisplayMode(.large)
            .onAppear {
                viewStore.send(.setShown(isShown: true))
            }
            .onDisappear {
                viewStore.send(.setShown(isShown: false))
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
    }
}

