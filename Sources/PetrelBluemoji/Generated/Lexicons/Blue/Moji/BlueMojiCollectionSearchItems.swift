import Foundation
import Petrel

// lexicon: 1, id: blue.moji.collection.searchItems

public enum BlueMojiCollectionSearchItems {
    public static let typeIdentifier = "blue.moji.collection.searchItems"
    public struct Parameters: Parametrizable {
        public let q: String
        public let repo: ATIdentifier?
        public let limit: Int?
        public let cursor: String?

        public init(
            q: String,
            repo: ATIdentifier? = nil,
            limit: Int? = nil,
            cursor: String? = nil
        ) {
            self.q = q
            self.repo = repo
            self.limit = limit
            self.cursor = cursor
        }
    }

    public struct Output: ATProtocolCodable {
        public let cursor: String?

        public let items: [BlueMojiCollectionItem.ItemView]

        /// Standard public initializer
        public init(
            cursor: String? = nil,

            items: [BlueMojiCollectionItem.ItemView]

        ) {
            self.cursor = cursor

            self.items = items
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)

            do {
                cursor = try container.decodeIfPresent(String.self, forKey: .cursor)
            } catch {
                // Forward compatibility: a malformed optional field must not fail the whole response.
                LogManager.logWarning("Decoding error for optional property 'cursor' — degrading to nil: \(error)")
                cursor = nil
            }

            items = try container.decode([BlueMojiCollectionItem.ItemView].self, forKey: .items)
        }

        public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)

            // Encode optional property even if it's an empty array
            try container.encodeIfPresent(cursor, forKey: .cursor)

            try container.encode(items, forKey: .items)
        }

        public func toCBORValue() throws -> Any {
            var map = OrderedCBORMap()

            if let value = cursor {
                // Encode optional property even if it's an empty array for CBOR
                let cursorValue = try value.toCBORValue()
                map = map.adding(key: "cursor", value: cursorValue)
            }

            let itemsValue = try items.toCBORValue()
            map = map.adding(key: "items", value: itemsValue)

            return map
        }

        private enum CodingKeys: String, CodingKey {
            case cursor
            case items
        }
    }
}

public extension ATProtoClient.Blue.Moji.Collection {
    // MARK: - searchItems

    /// Search Bluemoji by alias or alt text. Intended as shared infrastructure so clients don't need to maintain their own emoji search index. Two distinct matching modes depending on 'repo': pass it for substring matching within one repo's own collection (suited to live-typing :-autocomplete in a composer — every keystroke narrows correctly, including partial prefixes); omit it for network-wide full-text search (subject to takedown filtering), which matches whole words/tokens rather than arbitrary substrings — e.g. 'cat' can match ':blobcat:' but 'blob' alone may not, since the underlying index is word-oriented. Network-wide mode suits a 'discover emoji' browse/search surface better than character-by-character autocomplete.
    ///
    /// - Parameter input: The input parameters for the request
    ///
    /// - Returns: A tuple containing the HTTP response code and the decoded response data
    /// - Throws: NetworkError if the request fails or the response cannot be processed
    func searchItems(input: BlueMojiCollectionSearchItems.Parameters) async throws -> (responseCode: Int, data: BlueMojiCollectionSearchItems.Output?) {
        let endpoint = "blue.moji.collection.searchItems"

        let queryItems = input.asQueryItems()

        let urlRequest = try await networkService.createURLRequest(
            endpoint: endpoint,
            method: "GET",
            headers: ["Accept": "application/json"],
            body: nil,
            queryItems: queryItems
        )

        // Determine service DID for this endpoint
        let serviceDID = await networkService.getServiceDID(for: "blue.moji.collection.searchItems")
        let proxyHeaders = serviceDID.map { ["atproto-proxy": $0] }
        let (responseData, response) = try await networkService.performRequest(urlRequest, skipTokenRefresh: false, additionalHeaders: proxyHeaders)
        let responseCode = response.statusCode

        // Only validate Content-Type and decode on success. Error responses
        // (4xx/5xx) may have missing or different Content-Type headers and
        // are handled via the status code / structured error parser below.
        if (200 ... 299).contains(responseCode) {
            guard let contentType = response.allHeaderFields["Content-Type"] as? String else {
                throw NetworkError.invalidContentType(expected: "application/json", actual: "nil")
            }

            if !contentType.lowercased().contains("application/json") {
                throw NetworkError.invalidContentType(expected: "application/json", actual: contentType)
            }

            do {
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode(BlueMojiCollectionSearchItems.Output.self, from: responseData)

                return (responseCode, decodedData)
            } catch {
                // Log the decoding error for debugging but still return the response code
                LogManager.logError("Failed to decode successful response for blue.moji.collection.searchItems: \(error)")
                return (responseCode, nil)
            }
        } else {
            // If we can't parse a structured error, return the response code
            // (maintains backward compatibility for endpoints without defined errors)
            return (responseCode, nil)
        }
    }
}
