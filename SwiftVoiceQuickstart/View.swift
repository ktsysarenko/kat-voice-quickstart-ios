//
//  SwiftUIView.swift
//  SwiftVoiceQuickstart
//
//  Created by Kat Tsysarenko on 21/10/2024.
//  Copyright © 2024 Twilio, Inc. All rights reserved.
//

import SwiftUI

struct SwiftUIView: View {

    @ObservedObject var viewModel: ViewModel

    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()

    var body: some View {
        VStack(spacing: 20) {
            Image("TwilioLogo", bundle: nil)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200)

            phoneNumberField

            if viewModel.isLoading {
                ProgressView()
            } else {
                PrimaryButton(
                    action: viewModel.mainButtonPressed,
                    title: viewModel.callButtonTitle
                )
            }

            if viewModel.activeCall != nil {
                HStack(spacing: 40) {
                    CircularButton(
                        action: viewModel.toggleMicrophone,
                        configuration: viewModel.micButtonConfiguration
                    )

                    CircularButton(
                        action: viewModel.toggleAudioOutput,
                        configuration: viewModel.speakerButtonConfiguration
                    )

                    Menu {
                        ForEach(viewModel.availableAudioRoutes) { audioRoute in
                            Button(action: { viewModel.chooseAudio(route: audioRoute) }) {
                                Label(audioRoute.id, systemImage: audioRoute.icon)
                            }
                        }
                    } label: {
                        VStack {
                            Image(systemName: viewModel.speakerButtonConfiguration.imageSystemName)
                                .resizable()
                                .scaledToFit()
                                .padding(12)
                                .frame(width: 50, height: 50)
                                .foregroundColor(.white)
                                .background(Circle().fill(viewModel.speakerButtonConfiguration.isOn ? Color.red : Color.secondary))

                            Text(viewModel.speakerButtonConfiguration.title)
                                .fontWeight(.semibold)
                        }
                    }
                }
            }
        }
        .alert(isPresented: $viewModel.showingAlert) {
            Alert(
                title: Text("Voice Quick Start"),
                message: Text("Microphone permission not granted"),
                primaryButton: Alert.Button.default(
                    Text("Settings"),
                    action: openSettings
                ),
                secondaryButton: Alert.Button.cancel(Text("Dismiss"))
            )
        }
    }

}

private extension SwiftUIView {

    func openSettings() {
        UIApplication.shared.open(
            URL(string: UIApplicationOpenSettingsURLString)!,
            options: [UIApplicationOpenURLOptionUniversalLinksOnly: false],
            completionHandler: nil
        )
    }

   // @ViewBuilder
    var phoneNumberField: some View {
        VStack(spacing: 10) {
            TextField("Enter phone number to call", value: $viewModel.phoneNumber, formatter: formatter)
                .textFieldStyle(.roundedBorder)
            Text("Dial a client name or phone number. Leaving the field empty results in an automated response.")
                .font(.footnote)
                .foregroundColor(.secondary)
        }
        .padding(40)
    }

}

#Preview {
    SwiftUIView(viewModel: ViewModel())
}
