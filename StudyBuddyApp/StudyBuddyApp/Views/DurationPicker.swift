//
//  DurationPickerView.swift
//  StudyBuddyApp
//
//  Created by austin on 10/29/21.
//

import SwiftUI
import UIKit

//https://stackoverflow.com/questions/58574463/how-can-i-set-countdowntimer-mode-in-datepicker-on-swiftui
struct DurationPicker: UIViewRepresentable {
    @Binding var duration: TimeInterval

    func makeUIView(context: Context) -> GSTimeIntervalPicker {
//        let datePicker = UIDatePicker()
//        datePicker.datePickerMode = .countDownTimer
//        datePicker.addTarget(context.coordinator, action: #selector(Coordinator.updateDuration), for: .valueChanged)
      
      let timePicker = GSTimeIntervalPicker()
      timePicker.maxTimeInterval = 4 * 3600
      timePicker.minuteInterval = 1
      timePicker.allowZeroTimeInterval = false
      timePicker.timeInterval = 1 * 3600
      timePicker.onTimeIntervalChanged = timeIntervalChangedHandler
//        return datePicker
      return timePicker
    }

    func updateUIView(_ datePicker: GSTimeIntervalPicker, context: Context) {
      //print("called")
      datePicker.setTimeInterval(duration, animated: true)
      //print(datePicker.timeInterval)
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
  
  func timeIntervalChangedHandler(newInterval : TimeInterval){
    //print(newInterval)
    self.duration = newInterval
  }

    class Coordinator: NSObject {
        let parent: DurationPicker

        init(_ parent: DurationPicker) {
            self.parent = parent
        }

        @objc func updateDuration(datePicker: GSTimeIntervalPicker) {
            parent.duration = datePicker.timeInterval
        }
    }
}
