//
//  Buttons.swift
//  SwiftVoiceQuickstart
//
//  Created by Kat Tsysarenko on 21/10/2024.
//  Copyright © 2024 Twilio, Inc. All rights reserved.
//

import SwiftUI

struct ButtonConfiguration {
    var imageSystemName: String
    var title: String
    var isOn: Bool
}

struct CircularButton: View {
    var action: () -> Void
    var configuration: ButtonConfiguration

    var body: some View {
        VStack {
            Button(
                action: action,
                label: {
                    Image(systemName: configuration.imageSystemName ?? "")
                        .resizable()
                        .scaledToFit()
                        .padding(12)
                        .frame(width: 50, height: 50)
                        .foregroundColor(.white)
                        .background(Circle().fill(configuration.isOn ? Color.red : Color.secondary))
                }
            )
            Text(configuration.title)
                .fontWeight(.semibold)
        }
    }
}

struct PrimaryButton: View {
    var action: () -> Void
    var title: String

    var body: some View {
        Button(
            action: action,
            label: {
                Text(title)
                    .padding(.vertical, 12)
                    .padding(.horizontal, 24)
                    .foregroundColor(.white)
                    .font(.headline)
                    .background(Color.red)
                    .cornerRadius(10)
            }
        )
    }
}

#Preview {
    VStack(spacing: 20) {
        PrimaryButton(action: { }, title: "Title")
        CircularButton(
            action: { },
            configuration: .init(imageSystemName: "mic.fill", title: "Mic", isOn: false)
        )
    }
}
