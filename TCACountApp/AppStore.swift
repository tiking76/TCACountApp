//
//  AppStore.swift
//  TCACountApp
//
//  Created by 舘佳紀 on 2021/02/21.
//

import ComposableArchitecture

//State
struct AppState: Equatable {
    var count = 0
    var numberFactAlert: String?
}

//Action
enum AppAction: Equatable {
    case factAlertDismissed
    case decrementButtonTapped
    case incrementButtonTapped
    case numberFactButtonTapped
    case numberFactResponse(Result<String, NumberApiError>)
}

//Enviroment
struct AppEnvironment {
    var mainQueue: AnySchedulerOf<DispatchQueue>
    var numberFact: (Int) -> Effect<String, NumberApiError>
}

//Reducer
/*
@Memo
 各Actionに対応する
「Stateへの処理」と「実行するべきEffect」について記述している
*/
//イベントを返しているのかな？？？
let appReducer = Reducer<AppState, AppAction, AppEnvironment> { state, action, environment in
    switch action {
    //よく理解していない
    case .factAlertDismissed:
        state.numberFactAlert = nil
        return .none
        
    case .decrementButtonTapped:
        state.count -= 1
        return .none
        
    case .incrementButtonTapped:
        state.count += 1
        return .none
        
    case .numberFactButtonTapped:
        return environment.numberFact(state.count)
            .receive(on: environment.mainQueue)
            .catchToEffect()
            .map(AppAction.numberFactResponse)
            
    case let .numberFactResponse(.success(fact)):
        state.numberFactAlert = fact
        return .none
        
    case .numberFactResponse(.failure):
        state.numberFactAlert = "Could not load a number facr : "
        return .none
    }
}
