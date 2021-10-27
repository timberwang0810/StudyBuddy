//
//  ViewModel.swift
//  StudyBuddyApp
//
//  Created by austin on 10/27/21.
//

import SwiftUI

// Contains model logic we want to access from views through published variables.
// Write functions in here to be called that change models (e.g. when a button is clicked)
class ViewModel: ObservableObject {
//  State we want to update view with when it changes
  @Published var testString: String = "view model string"
  
}

