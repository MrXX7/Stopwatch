//
//  ContentView.swift
//  Stopwatch
//
//  Created by Oncu Can on 6.08.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var isRunning = false
    @State private var elapsedTicks = 0
    private let timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()

    var body: some View {
        ZStack {
            Color(red: 46/255, green: 49/255, blue: 57/255)
                .edgesIgnoringSafeArea(.all)

            VStack {
                Text("\(formatTime(elapsedTicks))")
                    .font(.system(size: UIScreen.main.bounds.width / 5.5, weight: .thin, design: .monospaced))
                    .foregroundColor(.white)
                    .padding(.top, 50)

                Spacer()

                HStack(spacing: 20) {
                    Button(action: startTimer) {
                        Image(systemName: "play.fill")
                            .foregroundColor(.white)
                            .font(.title)
                            .frame(width: 60, height: 60)
                            .background(Color.green)
                            .cornerRadius(30)
                    }

                    Button(action: stopTimer) {
                        Image(systemName: "stop.fill")
                            .foregroundColor(.white)
                            .font(.title)
                            .frame(width: 60, height: 60)
                            .background(Color.red)
                            .cornerRadius(30)
                    }

                    Button(action: resetTimer) {
                        Image(systemName: "gobackward")
                            .foregroundColor(.white)
                            .font(.title)
                            .frame(width: 60, height: 60)
                            .background(Color.blue)
                            .cornerRadius(30)
                    }
                }
                .padding(.bottom, 50)
            }
        }
        .onReceive(timer) { _ in
            if isRunning {
                elapsedTicks += 1
            }
        }
    }

    private func startTimer() {
        isRunning = true
    }

    private func stopTimer() {
        isRunning = false
    }

    private func resetTimer() {
        isRunning = false
        elapsedTicks = 0
    }

    private func formatTime(_ ticks: Int) -> String {
        let minutes = ticks / 6000
        let seconds = (ticks / 100) % 60
        let milliseconds = ticks % 100
        return String(format: "%02d:%02d.%02d", minutes, seconds, milliseconds)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
