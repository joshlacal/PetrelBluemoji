import Foundation
import Petrel

// lexicon: 1, id: blue.moji.collection.transcodeAnimation

public enum BlueMojiCollectionTranscodeAnimation {
    public static let typeIdentifier = "blue.moji.collection.transcodeAnimation"
    public struct Input: ATProtocolCodable {
        public let data: String

        /// Standard public initializer
        public init(data: String) {
            self.data = data
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            data = try container.decode(String.self, forKey: .data)
        }

        public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(data, forKey: .data)
        }

        public func toCBORValue() throws -> Any {
            var map = OrderedCBORMap()
            let dataValue = try data.toCBORValue()
            map = map.adding(key: "data", value: dataValue)
            return map
        }

        private enum CodingKeys: String, CodingKey {
            case data
        }
    }

    public struct Output: ATProtocolCodable {
        public let webp128: String?

        public let webp512: String?

        /// Standard public initializer
        public init(
            webp128: String? = nil,

            webp512: String? = nil

        ) {
            self.webp128 = webp128

            self.webp512 = webp512
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)

            do {
                webp128 = try container.decodeIfPresent(String.self, forKey: .webp128)
            } catch {
                // Forward compatibility: a malformed optional field must not fail the whole response.
                LogManager.logWarning("Decoding error for optional property 'webp128' — degrading to nil: \(error)")
                webp128 = nil
            }

            do {
                webp512 = try container.decodeIfPresent(String.self, forKey: .webp512)
            } catch {
                // Forward compatibility: a malformed optional field must not fail the whole response.
                LogManager.logWarning("Decoding error for optional property 'webp512' — degrading to nil: \(error)")
                webp512 = nil
            }
        }

        public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)

            // Encode optional property even if it's an empty array
            try container.encodeIfPresent(webp128, forKey: .webp128)

            // Encode optional property even if it's an empty array
            try container.encodeIfPresent(webp512, forKey: .webp512)
        }

        public func toCBORValue() throws -> Any {
            var map = OrderedCBORMap()

            if let value = webp128 {
                // Encode optional property even if it's an empty array for CBOR
                let webp128Value = try value.toCBORValue()
                map = map.adding(key: "webp128", value: webp128Value)
            }

            if let value = webp512 {
                // Encode optional property even if it's an empty array for CBOR
                let webp512Value = try value.toCBORValue()
                map = map.adding(key: "webp512", value: webp512Value)
            }

            return map
        }

        private enum CodingKeys: String, CodingKey {
            case webp128
            case webp512
        }
    }
}

public extension ATProtoClient.Blue.Moji.Collection {
    // MARK: - transcodeAnimation

    // Server-side utility: transcodes an uploaded APNG (or other ffmpeg-readable animated image) into properly-sized animated WebP renditions, sidestepping imgproxy's lack of APNG support (see RFC 0001 / imgproxy#1222) by never storing raw APNG in the first place. Pure transcode — does not touch the PDS or write any record; the caller uploads the returned bytes via dev.hatk.uploadBlob itself, same as any other format. Input/output are base64 JSON, not raw bytes, because this AppView's custom-procedure dispatch always JSON-parses the request body (only the built-in dev.hatk.uploadBlob gets raw-body handling).
    //
    // - Parameter input: The input parameters for the request

    ///
    /// - Returns: A tuple containing the HTTP response code and the decoded response data
    /// - Throws: NetworkError if the request fails or the response cannot be processed
    func transcodeAnimation(
        input: BlueMojiCollectionTranscodeAnimation.Input

    ) async throws -> (responseCode: Int, data: BlueMojiCollectionTranscodeAnimation.Output?) {
        let endpoint = "blue.moji.collection.transcodeAnimation"

        var headers: [String: String] = [:]

        headers["Content-Type"] = "application/json"

        headers["Accept"] = "application/json"

        let requestData: Data? = try JSONEncoder().encode(input)

        let queryItems: [URLQueryItem]? = nil

        let urlRequest = try await networkService.createURLRequest(
            endpoint: endpoint,
            method: "POST",
            headers: headers,
            body: requestData,
            queryItems: queryItems
        )

        // Determine service DID for this endpoint
        let serviceDID = await networkService.getServiceDID(for: "blue.moji.collection.transcodeAnimation")
        let proxyHeaders = serviceDID.map { ["atproto-proxy": $0] }
        let (responseData, response) = try await networkService.performRequest(urlRequest, skipTokenRefresh: false, additionalHeaders: proxyHeaders)
        let responseCode = response.statusCode

        // Only validate Content-Type and decode on success. Error responses
        // (4xx/5xx) may have missing or different Content-Type headers and
        // are handled by the caller via the status code.
        if (200 ... 299).contains(responseCode) {
            guard let contentType = response.allHeaderFields["Content-Type"] as? String else {
                throw NetworkError.invalidContentType(expected: "application/json", actual: "nil")
            }

            if !contentType.lowercased().contains("application/json") {
                throw NetworkError.invalidContentType(expected: "application/json", actual: contentType)
            }

            do {
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode(BlueMojiCollectionTranscodeAnimation.Output.self, from: responseData)

                return (responseCode, decodedData)
            } catch {
                // Log the decoding error for debugging but still return the response code
                LogManager.logError("Failed to decode successful response for blue.moji.collection.transcodeAnimation: \(error)")
                return (responseCode, nil)
            }
        } else {
            // Don't try to decode error responses as success types
            return (responseCode, nil)
        }
    }
}
