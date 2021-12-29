import UIKit
import WebKit

class ViewController: UIViewController {

    var webView: WKWebView!
    var progressView: UIProgressView!
    var websites = ["apple.com", "hackingwithswift.com"]

    override func viewDidLoad() {
        super.viewDidLoad()
        urlStringConfiguration()
        barButtonItems()
        webviewObserver()
    }

    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }

    private func urlStringConfiguration()
    {
        let url = URL(string: "https://www.hackingwithswift.com")

        guard let url = url else {
            return
        }

        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }

    private func barButtonItems()
    {
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                     target: nil, action: nil)
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh,
                                      target: webView,
                                      action: #selector(webView.reload))

        toolbarItems = [spacer, refresh]
        navigationController?.isToolbarHidden = false

        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        let progressButton = UIBarButtonItem(customView: progressView)

        toolbarItems = [progressButton, spacer, refresh]

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(openTapped))
    }

    @objc func openTapped()
    {
        let ac = UIAlertController(title: "Open page…",
                                   message: nil,
                                   preferredStyle: .actionSheet)
        for website in websites {
            ac.addAction(UIAlertAction(title: website,
                                       style: .default,
                                       handler: openPage))
        }
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        ac.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
        present(ac, animated: true)
    }

    private func webviewObserver()
    {
        webView.addObserver(self,
                            forKeyPath: #keyPath(WKWebView.estimatedProgress),
                            options: .new, context: nil)
    }

    func openPage(action: UIAlertAction) {
        let url = URL(string: "https://" + websites[0])

        guard let url = url else {
            return
        }

        webView.load(URLRequest(url: url))
    }

    override func observeValue(forKeyPath keyPath: String?,
                               of object: Any?,
                               change: [NSKeyValueChangeKey : Any]?,
                               context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
        }
    }
}

extension ViewController: WKNavigationDelegate {
    public func webView(_ webView: WKWebView,
                        didFinish navigation: WKNavigation!)
    {
        title = webView.title
    }

    public func webView(_ webView: WKWebView,
                        decidePolicyFor navigationAction: WKNavigationAction,
                        decisionHandler: @escaping (WKNavigationActionPolicy) -> Void)
    {
        let url = navigationAction.request.url

        if let host = url?.host {
            for website in websites {
                if host.contains(website) {
                    decisionHandler(.allow)
                    return
                }
            }
        }
        decisionHandler(.cancel)
    }
}
