// DELETE ME!

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet var window: NSWindow!

    private let session = URLSession(configuration: .default)

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }

    @IBAction func sendRequest(_ sender: Any) {
        guard let url = URL(string: "https://www.google.com") else { return }
        let request = URLRequest(url: url)
        request.log()
        let task = session.dataTask(with: request) { data, response, error in
            response?.log(data: data, request: request)
        }
        task.resume()
    }
}
