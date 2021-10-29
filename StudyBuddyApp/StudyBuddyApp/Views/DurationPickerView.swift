//
//  DurationPickerView.swift
//  StudyBuddyApp
//
//  Created by austin on 10/29/21.
//

import SwiftUI
import UIKit

//https://stackoverflow.com/questions/58574463/how-can-i-set-countdowntimer-mode-in-datepicker-on-swiftui
struct DurationPickerView: UIViewRepresentable {
    @Binding var time: Time

    func makeCoordinator() -> DurationPickerView.Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> UIDatePicker {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .countDownTimer
        datePicker.addTarget(context.coordinator, action: #selector(Coordinator.onDateChanged), for: .valueChanged)
        return datePicker
    }

    func updateUIView(_ datePicker: UIDatePicker, context: Context) {
        let date = Calendar.current.date(bySettingHour: time.hour, minute: time.minute, second: time.second, of: datePicker.date)!
        datePicker.setDate(date, animated: true)
    }

    class Coordinator: NSObject {
        var durationPicker: DurationPickerView

        init(_ durationPicker: DurationPickerView) {
            self.durationPicker = durationPicker
        }

        @objc func onDateChanged(sender: UIDatePicker) {
            print(sender.date)
            let calendar = Calendar.current
            let date = sender.date
            durationPicker.time = Time(hour: calendar.component(.hour, from: date), minute: calendar.component(.minute, from: date), second: calendar.component(.second, from: date))
        }
    }
}

// May want to move to separate file shared by Models at some point
import Foundation

struct Time {
    var hour: Int
    var minute: Int
    var second: Int = 0
}
