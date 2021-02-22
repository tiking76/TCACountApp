//
//  ContentView.swift
//  TCACountApp
//
//  Created by 舘佳紀 on 2021/02/21.
//

import SwiftUI
import ComposableArchitecture

struct ContentView: View {
    
    let store: Store<AppState, AppAction>
    
    var body: some View {
        WithViewStore(self.store) {
            viewStore in
            VStack {
                HStack {
                    Button("-") { viewStore.send(.decrementButtonTapped)}
                    Text("\(viewStore.count)")
                    Button("+") { viewStore.send(.incrementButtonTapped)}
                }
                Button("Number") { viewStore.send(.numberFactButtonTapped) }
            }.alert(item: viewStore.binding(
                        get: { $0.numberFactAlert.map(FactAlert.init(title:)) },
                        send: .factAlertDismissed),
                        content: {
                           Alert(title: Text($0.title))
                        }
            )
        }
    }
}

struct FactAlert: Identifiable {
  var title: String
  var id: String { self.title }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(store: Store(initialState: AppState(), reducer: appReducer, environment: AppEnvironment(mainQueue: DispatchQueue.main.eraseToAnyScheduler(), numberFact: {
            number in Effect(value: "\(number) is a good number Brent")
        })))
    }
}
