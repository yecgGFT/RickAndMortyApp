//
//  CachedAsyncImageView.swift
//  rickandmorty-ios
//
//  Created by Chang Chen, Ya-We on 19/1/26.
//

import SwiftUI

struct DefaultPlaceholder: View {
    let isLoading: Bool
    
    init(isLoading: Bool = true) {
        self.isLoading = isLoading
    }
    
    var body: some View {
        VStack(spacing: Tokens.Spacing.spacing0) {
            if isLoading {
                ProgressView()
            } else {
                Tokens.Icons.errorExclamation.foregroundStyle(.orange)
            }
        }
        .frame(width: 60, height: 60)
        .clipShape(Circle())
    }
}


struct CachedAsyncImageView<Placeholder: View, ErrorPlaceholder: View>: View {

    // Estado para reintentos
    @State private var attempt: Int = 0
    @State private var reloadToken = UUID()
    @State private var schedulingRetry = false
    @State private var isLoaded = false

    private let placeholder: Placeholder
    private let errorPlaceholder: ErrorPlaceholder
    private let maxRetries: Int = 2
    private let retryDelay: TimeInterval = 1.0

    private var cache: ImageCache = DefaultImageCache.shared

    let url: URL

    @Environment(\.displayScale) private var displayScale

    init(
        url: URL,
        @ViewBuilder placeholder: @escaping () -> Placeholder,
        @ViewBuilder errorPlaceholder: @escaping () -> ErrorPlaceholder
    ) {
        self.url = url
        self.placeholder = placeholder()
        self.errorPlaceholder = errorPlaceholder()
    }

    var body: some View {
        VStack(spacing: Tokens.Spacing.spacing0) {
            if let cached = cache[url] {
                Image(uiImage: cached)
                    .resizable()
                    .transition(.opacity)
                    .onAppear {
                        isLoaded = true
                    }
            } else {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .clipped()
                            .transition(.opacity.combined(with: .scale))
                            .onAppear {
                                isLoaded = true
                                attempt = 0
                                if let ui = image.toUIImage(scale: displayScale)
                                {
                                    cache[url] = ui
                                }
                            }
                    case .failure, .empty:
                        handleFailureAsyncImageView()
                    @unknown default:
                        errorPlaceholder
                            .task {
                                Log.log(.error, .ui, "ERROR >>> LOADED FAILED UNKNOWN")
                            }
                    }
                }
            }
        }
        .frame(width: 60, height: 60)
        .animation(.default, value: UUID())
        .clipShape(Circle())

    }

    @ViewBuilder
    func handleFailureAsyncImageView() -> some View {
        if attempt < maxRetries {
            placeholder
                .task {
                    guard !schedulingRetry else { return }
                    schedulingRetry = true
                    await scheduleRetry()
                    schedulingRetry = false
                }
        } else {
            errorPlaceholder
                .task {
                    Log.log(.error, .ui, "ERROR >> LOADED FAILED - NO MORE RETRY")
                }
        }
    }

    private func scheduleRetry() async {
        let ns = UInt64(retryDelay * 1_000_000_000)
        try? await Task.sleep(nanoseconds: ns)

        await MainActor.run {
            attempt += 1
            reloadToken = UUID()
        }
    }
}
