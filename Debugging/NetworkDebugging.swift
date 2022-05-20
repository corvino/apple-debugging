// DELETE ME!

import Foundation

private func prettifyHeader(_ headers: [String : String]?) -> String {
    guard let headers = headers, 0 < headers.count else { return ""}
    let headerStrPairs = headers.map({ "\($0.key): \($0.value)" })
    let joinedHeaderStr = headerStrPairs.joined(separator: "\n")
    return "\n" + joinedHeaderStr + "\n"
}

extension URLRequest {
    var prettyParts: (url: String, method: String, headers: String) {
        let url = self.url?.absoluteString ?? ""
        let method = self.httpMethod?.uppercased() ?? ""
        let headers = prettifyHeader(self.allHTTPHeaderFields)

        return (url: url, method: method, headers: headers)
    }

    func log() {
        let (url, method, headers) = self.prettyParts
        print(">>> Starting request: \(method) \(url)\(headers)<<< Started")
    }
}

extension URLResponse {
    var prettyHeaders: String {
        guard let response = self as? HTTPURLResponse else { return "" }
        let extractedHeaders = response.allHeaderFields.compactMap { entry -> (String, String)? in
            guard let key = entry.key as? String else { return nil }
            guard let value = entry.value as? String else { return nil }
            return (key, value)
        }

        return prettifyHeader(Dictionary(uniqueKeysWithValues: extractedHeaders))
    }

    func log(data: Data?, request: URLRequest) {
        let (url, method, _) = request.prettyParts
        let headers = self.prettyHeaders
        let body = data?.prettyJSON ?? ""

        print(">>> Finished request: \(method) \(url)", terminator: "")

        if 0 < headers.count {
            print(headers)
        }
        if 0 < headers.count && 0 < body.count {
            print()
        }
        if 0 < body.count {
            print(body)
        }
        print("<<< Finished")
    }
}
