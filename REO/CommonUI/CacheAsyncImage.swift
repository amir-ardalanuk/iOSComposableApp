//
//  CacheAsyncImage.swift
//  REO
//
//  Created by Amir on 11/27/21.
//

import Foundation
import SwiftUI

struct CacheAsyncImage<Content> : View where Content: View {
    @State private var phase: AsyncImagePhase = .empty
    
    let url: URL?
    let urlSession: URLSession
    let scale: CGFloat
    let transaction: Transaction
    let content: (AsyncImagePhase) -> Content
    
    public init(url: URL?, urlCache: URLCache = .imageCache, scale: CGFloat = 1, transaction: Transaction = .init(), @ViewBuilder content: @escaping (AsyncImagePhase) -> Content) {
        let configuration = URLSessionConfiguration.default
        configuration.urlCache = urlCache
        configuration.requestCachePolicy = .returnCacheDataElseLoad
        self.url = url
        self.urlSession = URLSession(configuration: configuration)
        self.scale = scale
        self.transaction = transaction
        self.content = content
    }
    
    public init(url: URL?, urlCache: URLCache = .imageCache, scale: CGFloat = 1 ) where Content == Image {
        self.init(url: url, urlCache: urlCache, scale: scale) { phase in
            #if os(macOS)
            phase.image ?? Image(nsImage: .init())
            #else
            phase.image ?? Image(uiImage: .init())
            #endif
        }
    }
    
    public init<I, P>(url: URL?, urlCache: URLCache = .imageCache,  scale: CGFloat = 1, @ViewBuilder content: @escaping (Image) -> I, @ViewBuilder placeholder: @escaping () -> P) where Content == _ConditionalContent<I, P>, I : View, P : View {
            self.init(url: url, urlCache: urlCache, scale: scale) { phase in
                if let image = phase.image {
                    content(image)
                } else {
                    placeholder()
                }
            }
        }
    
    
    var body: some View {
        content(phase)
            .task(priority: .background) {
                await load(url: url)
            }
    }
    
    private func load(url: URL?) async {
        do {
            guard let url = url else {
                return
            }
            let request = URLRequest(url: url)
            let (data, _) = try await urlSession.data(for: request)
            #if os(macOS)
            if let nsImage = NSImage(data: data) {
                let image = Image(nsImage: nsImage)
                phase = .success(image)
            } else {
                throw AsyncImage<Content>.LoadingError()
            }
            #else
            if let uiImage = UIImage(data: data) {
                let image = Image(uiImage: uiImage)
                phase = .success(image)
            } else {
                throw AsyncImage<Content>.LoadingError()
            }
            #endif
        } catch {
            phase = .failure(error)
        }
    }
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
private extension AsyncImage {
    struct LoadingError: Error {}
}

extension URLCache {
    static let imageCache = URLCache(memoryCapacity: 512*1000*1000, diskCapacity: 10*1000*1000*1000)
}
