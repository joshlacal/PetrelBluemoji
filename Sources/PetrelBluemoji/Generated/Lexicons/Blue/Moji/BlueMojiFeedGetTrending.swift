import Foundation
import Petrel

// lexicon: 1, id: blue.moji.feed.getTrending

public enum BlueMojiFeedGetTrending {
    public static let typeIdentifier = "blue.moji.feed.getTrending"
    public struct Parameters: Parametrizable {
        public let period: String?
        public let limit: Int?

        public init(
            period: String? = nil,
            limit: Int? = nil
        ) {
            self.period = period
            self.limit = limit
        }
    }

    public struct Output: ATProtocolCodable {
        public let period: String

        public let items: [BlueMojiFeedDefs.ReactionGroup]

        /// Standard public initializer
        public init(
            period: String,

            items: [BlueMojiFeedDefs.ReactionGroup]

        ) {
            self.period = period

            self.items = items
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)

            period = try container.decode(String.self, forKey: .period)

            items = try container.decode([BlueMojiFeedDefs.ReactionGroup].self, forKey: .items)
        }

        public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)

            try container.encode(period, forKey: .period)

            try container.encode(items, forKey: .items)
        }

        public func toCBORValue() throws -> Any {
            var map = OrderedCBORMap()

            let periodValue = try period.toCBORValue()
            map = map.adding(key: "period", value: periodValue)

            let itemsValue = try items.toCBORValue()
            map = map.adding(key: "items", value: itemsValue)

            return map
        }

        private enum CodingKeys: String, CodingKey {
            case period
            case items
        }
    }
}

public extension ATProtoClient.Blue.Moji.Feed {
    // MARK: - getTrending

    /// AppView-computed "Weekly Top Bluemoji": the custom emoji reacted with by the most distinct actors in a recent window. Purely a discovery/trending signal derived from indexed blue.moji.feed.reaction records verified against their source blue.moji.collection.item — not a network-wide count (only reflects reactions this AppView has indexed), and not the same per-post cap applied by getReactions/getReactionCounts.
    ///
    /// - Parameter input: The input parameters for the request
    ///
    /// - Returns: A tuple containing the HTTP response code and the decoded response data
    /// - Throws: NetworkError if the request fails or the response cannot be processed
    func getTrending(input: BlueMojiFeedGetTrending.Parameters) async throws -> (responseCode: Int, data: BlueMojiFeedGetTrending.Output?) {
        let endpoint = "blue.moji.feed.getTrending"

        let queryItems = input.asQueryItems()

        let urlRequest = try await networkService.createURLRequest(
            endpoint: endpoint,
            method: "GET",
            headers: ["Accept": "application/json"],
            body: nil,
            queryItems: queryItems
        )

        // Determine service DID for this endpoint
        let serviceDID = await networkService.getServiceDID(for: "blue.moji.feed.getTrending")
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
                let decodedData = try decoder.decode(BlueMojiFeedGetTrending.Output.self, from: responseData)

                return (responseCode, decodedData)
            } catch {
                // Log the decoding error for debugging but still return the response code
                LogManager.logError("Failed to decode successful response for blue.moji.feed.getTrending: \(error)")
                return (responseCode, nil)
            }
        } else {
            // If we can't parse a structured error, return the response code
            // (maintains backward compatibility for endpoints without defined errors)
            return (responseCode, nil)
        }
    }
}
