// DELETE ME!

import Foundation

extension Data {
    var prettyJSON: String {
        guard let anyJSON = try? JSONSerialization.jsonObject(with: self, options: []) else { return "<<not-json-data>>" }
        guard let prettyData = try? JSONSerialization.data(withJSONObject: anyJSON, options: [.prettyPrinted]) else { return "<<ugly-json>>" }
        guard let prettyString = String(data: prettyData, encoding: String.Encoding.utf8) else { return "<<not-utf8>>" }

        return prettyString
    }
}
