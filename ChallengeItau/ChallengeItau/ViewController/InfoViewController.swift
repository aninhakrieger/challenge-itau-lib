//
//  InfoViewController.swift
//  ChallengeItau
//
//  Created by Ana Krieger on 17/12/22.
//

import UIKit
import WebKit

class InfoViewController: UIViewController, WKNavigationDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        loadWebView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func loadWebView() {
        let webView = WKWebView()
        webView.navigationDelegate = self
        view = webView

        let url = URL(string: "https://github.com/aninhakrieger")!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
}
