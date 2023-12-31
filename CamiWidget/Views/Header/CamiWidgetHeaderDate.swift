//
//  CamiWidgetHeaderDate.swift
//  CamiWidget
//
//  Created by Guillaume Coquard on 15/11/23.
//

import Foundation
import SwiftUI
import WidgetKit

struct CamiWidgetHeaderDate: View {

    @Environment(\.widgetFamily)
    var widgetFamily: WidgetFamily

    @EnvironmentObject
    private var entry: CamiWidgetEntry

    private var datePrefix: Int {
        return switch widgetFamily {
        case .systemExtraLarge:
            Int.max
        case .systemSmall:
            1
        default:
            3
        }
    }

    var body: some View {
        HStack {
            let dateComponents: [String: String] = entry.date.literals

            Group {
                Group {
                    Text(
                        "\(dateComponents["day"]!)"
                            .uppercased()
                            .prefix(datePrefix)
                    )
                    .fontWeight(.heavy)
                    .foregroundStyle(.white)
                    +
                    Text("\(dateComponents["date"]!)")
                    .fontWeight(.heavy)
                    .foregroundStyle(.red)
                }
            }
        }
        .font(.title3)
        .lineSpacing(0)
    }
}
