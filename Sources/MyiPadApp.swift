import SwiftUI
import WebKit

@main
struct MyiPadApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

struct ContentView: View {
    var body: some View {
        LocalHTMLView().ignoresSafeArea()
    }
}

struct LocalHTMLView: UIViewRepresentable {
    func makeUIView(context: Context) -> WKWebView {
        let configuration = WKWebViewConfiguration()
        let webView = WKWebView(frame: .zero, configuration: configuration)
        webView.isOpaque = false
        webView.backgroundColor = .systemBackground
        webView.scrollView.contentInsetAdjustmentBehavior = .never

        if let htmlURL = Bundle.main.url(forResource: "index", withExtension: "html"),
           let resourceURL = Bundle.main.resourceURL {
            webView.loadFileURL(htmlURL, allowingReadAccessTo: resourceURL)
        } else {
            let fallback = """
            <!doctype html><html lang="ja"><meta charset="utf-8">
            <meta name="viewport" content="width=device-width,initial-scale=1">
            <body style="font-family:-apple-system;padding:24px">
            <h2>HTMLファイルが見つかりません</h2>
            <p>Resources/index.html を確認してください。</p></body></html>
            """
            webView.loadHTMLString(fallback, baseURL: nil)
        }
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {}
}
