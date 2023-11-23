//
//  CamiWidgetEvent.swift
//  CamiWidget
//
//  Created by Guillaume Coquard on 14/11/23.
//

import SwiftUI
import EventKit

struct CamiWidgetEvent: View {

    @EnvironmentObject private var entry: CamiWidgetEntry

    var event: (EKEvent,Events)

    private var _event: EKEvent {
        return event.0
    }

    private var _other: Events {
        return event.1
    }

    var body: some View {

        HStack(alignment:.center) {

            VStack(alignment: .leading) {
                Text(_event.title)
                    .font(.caption)
                    .fontDesign(.rounded)
                    .fontWeight(.medium)
                    .lineLimit(1)
                    .foregroundStyle(Color(cgColor: _event.calendar.cgColor))
                    .accessibilityLabel("You have an event titled: \(_event.title).")
            }

            Spacer(minLength: 8)

            if !_event.isAllDay || entry.config.displayOngoingEvents && _event.spansMore(than: entry.date) {
                VStack(alignment: .trailing,spacing: 1) {
                    Group {
                        ForEach(_other, id: \.self) { __event in
                            RemainingTimeComponent(
                                from: __event.startDate,
                                to: __event.endDate,
                                accuracy: __event.spansMore(than: entry.date) ? [.day,.hour] : [.day,.hour,.minute]
                            )
                                .font(.caption)
                                .foregroundStyle(Color(cgColor: __event.calendar.cgColor))
                        }
                    }
                    .accessibilityLabel(
                        _other.count > 1
                        ? "This event happens \(_other.count) times in your day." : "")
                }
            }

        }
        .roundedBorder( _event.calendar.cgColor, bordered: entry.config.allDayStyle == .bordered && _event.isAllDay )
    }
}
