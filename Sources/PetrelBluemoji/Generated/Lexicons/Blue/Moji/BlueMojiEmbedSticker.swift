import Foundation
import Petrel

// lexicon: 1, id: blue.moji.embed.sticker

public struct BlueMojiEmbedSticker: ATProtocolCodable, ATProtocolValue {
    public static let typeIdentifier = "blue.moji.embed.sticker"
    public let sticker: Sticker

    public init(sticker: Sticker) {
        self.sticker = sticker
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        sticker = try container.decode(Sticker.self, forKey: .sticker)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(sticker, forKey: .sticker)
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(sticker)
    }

    public func isEqual(to other: any ATProtocolValue) -> Bool {
        guard let other = other as? Self else { return false }
        if sticker != other.sticker {
            return false
        }
        return true
    }

    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.isEqual(to: rhs)
    }

    public func toCBORValue() throws -> Any {
        var map = OrderedCBORMap()
        let stickerValue = try sticker.toCBORValue()
        map = map.adding(key: "sticker", value: stickerValue)
        return map
    }

    private enum CodingKeys: String, CodingKey {
        case sticker
    }

    public struct Sticker: ATProtocolCodable, ATProtocolValue {
        public static let typeIdentifier = "blue.moji.embed.sticker#sticker"
        public let record: ComAtprotoRepoStrongRef?
        public let did: DID
        public let name: String
        public let alt: String?
        public let aspectRatio: AppBskyEmbedDefs.AspectRatio?
        public let formats: StickerFormatsUnion

        public init(
            record: ComAtprotoRepoStrongRef?, did: DID, name: String, alt: String?, aspectRatio: AppBskyEmbedDefs.AspectRatio?, formats: StickerFormatsUnion
        ) {
            self.record = record
            self.did = did
            self.name = name
            self.alt = alt
            self.aspectRatio = aspectRatio
            self.formats = formats
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            do {
                record = try container.decodeIfPresent(ComAtprotoRepoStrongRef.self, forKey: .record)
            } catch {
                // Forward compatibility: a malformed or unknown-shaped optional field
                // must not fail the whole response.
                LogManager.logWarning("Decoding error for optional property 'record' — degrading to nil: \(error)")
                record = nil
            }
            do {
                did = try container.decode(DID.self, forKey: .did)
            } catch {
                LogManager.logError("Decoding error for required property 'did': \(error)")
                throw error
            }
            do {
                name = try container.decode(String.self, forKey: .name)
            } catch {
                LogManager.logError("Decoding error for required property 'name': \(error)")
                throw error
            }
            do {
                alt = try container.decodeIfPresent(String.self, forKey: .alt)
            } catch {
                // Forward compatibility: a malformed or unknown-shaped optional field
                // must not fail the whole response.
                LogManager.logWarning("Decoding error for optional property 'alt' — degrading to nil: \(error)")
                alt = nil
            }
            do {
                aspectRatio = try container.decodeIfPresent(AppBskyEmbedDefs.AspectRatio.self, forKey: .aspectRatio)
            } catch {
                // Forward compatibility: a malformed or unknown-shaped optional field
                // must not fail the whole response.
                LogManager.logWarning("Decoding error for optional property 'aspectRatio' — degrading to nil: \(error)")
                aspectRatio = nil
            }
            do {
                formats = try container.decode(StickerFormatsUnion.self, forKey: .formats)
            } catch {
                LogManager.logError("Decoding error for required property 'formats': \(error)")
                throw error
            }
        }

        public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(Self.typeIdentifier, forKey: .typeIdentifier)
            try container.encodeIfPresent(record, forKey: .record)
            try container.encode(did, forKey: .did)
            try container.encode(name, forKey: .name)
            try container.encodeIfPresent(alt, forKey: .alt)
            try container.encodeIfPresent(aspectRatio, forKey: .aspectRatio)
            try container.encode(formats, forKey: .formats)
        }

        public func hash(into hasher: inout Hasher) {
            if let value = record {
                hasher.combine(value)
            } else {
                hasher.combine(nil as Int?)
            }
            hasher.combine(did)
            hasher.combine(name)
            if let value = alt {
                hasher.combine(value)
            } else {
                hasher.combine(nil as Int?)
            }
            if let value = aspectRatio {
                hasher.combine(value)
            } else {
                hasher.combine(nil as Int?)
            }
            hasher.combine(formats)
        }

        public func isEqual(to other: any ATProtocolValue) -> Bool {
            guard let other = other as? Self else { return false }
            if record != other.record {
                return false
            }
            if did != other.did {
                return false
            }
            if name != other.name {
                return false
            }
            if alt != other.alt {
                return false
            }
            if aspectRatio != other.aspectRatio {
                return false
            }
            if formats != other.formats {
                return false
            }
            return true
        }

        public static func == (lhs: Self, rhs: Self) -> Bool {
            return lhs.isEqual(to: rhs)
        }

        public func toCBORValue() throws -> Any {
            var map = OrderedCBORMap()
            map = map.adding(key: "$type", value: Self.typeIdentifier)
            if let value = record {
                let recordValue = try value.toCBORValue()
                map = map.adding(key: "record", value: recordValue)
            }
            let didValue = try did.toCBORValue()
            map = map.adding(key: "did", value: didValue)
            let nameValue = try name.toCBORValue()
            map = map.adding(key: "name", value: nameValue)
            if let value = alt {
                let altValue = try value.toCBORValue()
                map = map.adding(key: "alt", value: altValue)
            }
            if let value = aspectRatio {
                let aspectRatioValue = try value.toCBORValue()
                map = map.adding(key: "aspectRatio", value: aspectRatioValue)
            }
            let formatsValue = try formats.toCBORValue()
            map = map.adding(key: "formats", value: formatsValue)
            return map
        }

        private enum CodingKeys: String, CodingKey {
            case typeIdentifier = "$type"
            case record
            case did
            case name
            case alt
            case aspectRatio
            case formats
        }
    }

    public struct Formats_v0: ATProtocolCodable, ATProtocolValue {
        public static let typeIdentifier = "blue.moji.embed.sticker#formatsV0"
        public let png_512: CID?
        public let webp_512: CID?
        public let gif_512: CID?
        public let apng_512: CID?
        public let lottie: CID?

        public init(
            png_512: CID?, webp_512: CID?, gif_512: CID?, apng_512: CID?, lottie: CID?
        ) {
            self.png_512 = png_512
            self.webp_512 = webp_512
            self.gif_512 = gif_512
            self.apng_512 = apng_512
            self.lottie = lottie
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            do {
                png_512 = try container.decodeIfPresent(CID.self, forKey: .png_512)
            } catch {
                // Forward compatibility: a malformed or unknown-shaped optional field
                // must not fail the whole response.
                LogManager.logWarning("Decoding error for optional property 'png_512' — degrading to nil: \(error)")
                png_512 = nil
            }
            do {
                webp_512 = try container.decodeIfPresent(CID.self, forKey: .webp_512)
            } catch {
                // Forward compatibility: a malformed or unknown-shaped optional field
                // must not fail the whole response.
                LogManager.logWarning("Decoding error for optional property 'webp_512' — degrading to nil: \(error)")
                webp_512 = nil
            }
            do {
                gif_512 = try container.decodeIfPresent(CID.self, forKey: .gif_512)
            } catch {
                // Forward compatibility: a malformed or unknown-shaped optional field
                // must not fail the whole response.
                LogManager.logWarning("Decoding error for optional property 'gif_512' — degrading to nil: \(error)")
                gif_512 = nil
            }
            do {
                apng_512 = try container.decodeIfPresent(CID.self, forKey: .apng_512)
            } catch {
                // Forward compatibility: a malformed or unknown-shaped optional field
                // must not fail the whole response.
                LogManager.logWarning("Decoding error for optional property 'apng_512' — degrading to nil: \(error)")
                apng_512 = nil
            }
            do {
                lottie = try container.decodeIfPresent(CID.self, forKey: .lottie)
            } catch {
                // Forward compatibility: a malformed or unknown-shaped optional field
                // must not fail the whole response.
                LogManager.logWarning("Decoding error for optional property 'lottie' — degrading to nil: \(error)")
                lottie = nil
            }
        }

        public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(Self.typeIdentifier, forKey: .typeIdentifier)
            try container.encodeIfPresent(png_512, forKey: .png_512)
            try container.encodeIfPresent(webp_512, forKey: .webp_512)
            try container.encodeIfPresent(gif_512, forKey: .gif_512)
            try container.encodeIfPresent(apng_512, forKey: .apng_512)
            try container.encodeIfPresent(lottie, forKey: .lottie)
        }

        public func hash(into hasher: inout Hasher) {
            if let value = png_512 {
                hasher.combine(value)
            } else {
                hasher.combine(nil as Int?)
            }
            if let value = webp_512 {
                hasher.combine(value)
            } else {
                hasher.combine(nil as Int?)
            }
            if let value = gif_512 {
                hasher.combine(value)
            } else {
                hasher.combine(nil as Int?)
            }
            if let value = apng_512 {
                hasher.combine(value)
            } else {
                hasher.combine(nil as Int?)
            }
            if let value = lottie {
                hasher.combine(value)
            } else {
                hasher.combine(nil as Int?)
            }
        }

        public func isEqual(to other: any ATProtocolValue) -> Bool {
            guard let other = other as? Self else { return false }
            if png_512 != other.png_512 {
                return false
            }
            if webp_512 != other.webp_512 {
                return false
            }
            if gif_512 != other.gif_512 {
                return false
            }
            if apng_512 != other.apng_512 {
                return false
            }
            if lottie != other.lottie {
                return false
            }
            return true
        }

        public static func == (lhs: Self, rhs: Self) -> Bool {
            return lhs.isEqual(to: rhs)
        }

        public func toCBORValue() throws -> Any {
            var map = OrderedCBORMap()
            map = map.adding(key: "$type", value: Self.typeIdentifier)
            if let value = png_512 {
                let png_512Value = try value.toCBORValue()
                map = map.adding(key: "png_512", value: png_512Value)
            }
            if let value = webp_512 {
                let webp_512Value = try value.toCBORValue()
                map = map.adding(key: "webp_512", value: webp_512Value)
            }
            if let value = gif_512 {
                let gif_512Value = try value.toCBORValue()
                map = map.adding(key: "gif_512", value: gif_512Value)
            }
            if let value = apng_512 {
                let apng_512Value = try value.toCBORValue()
                map = map.adding(key: "apng_512", value: apng_512Value)
            }
            if let value = lottie {
                let lottieValue = try value.toCBORValue()
                map = map.adding(key: "lottie", value: lottieValue)
            }
            return map
        }

        private enum CodingKeys: String, CodingKey {
            case typeIdentifier = "$type"
            case png_512
            case webp_512
            case gif_512
            case apng_512
            case lottie
        }
    }

    public struct View: ATProtocolCodable, ATProtocolValue {
        public static let typeIdentifier = "blue.moji.embed.sticker#view"
        public let sticker: ViewSticker

        public init(
            sticker: ViewSticker
        ) {
            self.sticker = sticker
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            do {
                sticker = try container.decode(ViewSticker.self, forKey: .sticker)
            } catch {
                LogManager.logError("Decoding error for required property 'sticker': \(error)")
                throw error
            }
        }

        public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(Self.typeIdentifier, forKey: .typeIdentifier)
            try container.encode(sticker, forKey: .sticker)
        }

        public func hash(into hasher: inout Hasher) {
            hasher.combine(sticker)
        }

        public func isEqual(to other: any ATProtocolValue) -> Bool {
            guard let other = other as? Self else { return false }
            if sticker != other.sticker {
                return false
            }
            return true
        }

        public static func == (lhs: Self, rhs: Self) -> Bool {
            return lhs.isEqual(to: rhs)
        }

        public func toCBORValue() throws -> Any {
            var map = OrderedCBORMap()
            map = map.adding(key: "$type", value: Self.typeIdentifier)
            let stickerValue = try sticker.toCBORValue()
            map = map.adding(key: "sticker", value: stickerValue)
            return map
        }

        private enum CodingKeys: String, CodingKey {
            case typeIdentifier = "$type"
            case sticker
        }
    }

    public struct ViewSticker: ATProtocolCodable, ATProtocolValue {
        public static let typeIdentifier = "blue.moji.embed.sticker#viewSticker"
        public let fullsize: URI
        public let thumb: URI?
        public let name: String
        public let alt: String?
        public let aspectRatio: AppBskyEmbedDefs.AspectRatio?
        public let record: ComAtprotoRepoStrongRef?
        public let labels: [ComAtprotoLabelDefs.Label]?

        public init(
            fullsize: URI, thumb: URI?, name: String, alt: String?, aspectRatio: AppBskyEmbedDefs.AspectRatio?, record: ComAtprotoRepoStrongRef?, labels: [ComAtprotoLabelDefs.Label]?
        ) {
            self.fullsize = fullsize
            self.thumb = thumb
            self.name = name
            self.alt = alt
            self.aspectRatio = aspectRatio
            self.record = record
            self.labels = labels
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            do {
                fullsize = try container.decode(URI.self, forKey: .fullsize)
            } catch {
                LogManager.logError("Decoding error for required property 'fullsize': \(error)")
                throw error
            }
            do {
                thumb = try container.decodeIfPresent(URI.self, forKey: .thumb)
            } catch {
                // Forward compatibility: a malformed or unknown-shaped optional field
                // must not fail the whole response.
                LogManager.logWarning("Decoding error for optional property 'thumb' — degrading to nil: \(error)")
                thumb = nil
            }
            do {
                name = try container.decode(String.self, forKey: .name)
            } catch {
                LogManager.logError("Decoding error for required property 'name': \(error)")
                throw error
            }
            do {
                alt = try container.decodeIfPresent(String.self, forKey: .alt)
            } catch {
                // Forward compatibility: a malformed or unknown-shaped optional field
                // must not fail the whole response.
                LogManager.logWarning("Decoding error for optional property 'alt' — degrading to nil: \(error)")
                alt = nil
            }
            do {
                aspectRatio = try container.decodeIfPresent(AppBskyEmbedDefs.AspectRatio.self, forKey: .aspectRatio)
            } catch {
                // Forward compatibility: a malformed or unknown-shaped optional field
                // must not fail the whole response.
                LogManager.logWarning("Decoding error for optional property 'aspectRatio' — degrading to nil: \(error)")
                aspectRatio = nil
            }
            do {
                record = try container.decodeIfPresent(ComAtprotoRepoStrongRef.self, forKey: .record)
            } catch {
                // Forward compatibility: a malformed or unknown-shaped optional field
                // must not fail the whole response.
                LogManager.logWarning("Decoding error for optional property 'record' — degrading to nil: \(error)")
                record = nil
            }
            do {
                labels = try container.decodeIfPresent([ComAtprotoLabelDefs.Label].self, forKey: .labels)
            } catch {
                // Forward compatibility: a malformed or unknown-shaped optional field
                // must not fail the whole response.
                LogManager.logWarning("Decoding error for optional property 'labels' — degrading to nil: \(error)")
                labels = nil
            }
        }

        public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(Self.typeIdentifier, forKey: .typeIdentifier)
            try container.encode(fullsize, forKey: .fullsize)
            try container.encodeIfPresent(thumb, forKey: .thumb)
            try container.encode(name, forKey: .name)
            try container.encodeIfPresent(alt, forKey: .alt)
            try container.encodeIfPresent(aspectRatio, forKey: .aspectRatio)
            try container.encodeIfPresent(record, forKey: .record)
            try container.encodeIfPresent(labels, forKey: .labels)
        }

        public func hash(into hasher: inout Hasher) {
            hasher.combine(fullsize)
            if let value = thumb {
                hasher.combine(value)
            } else {
                hasher.combine(nil as Int?)
            }
            hasher.combine(name)
            if let value = alt {
                hasher.combine(value)
            } else {
                hasher.combine(nil as Int?)
            }
            if let value = aspectRatio {
                hasher.combine(value)
            } else {
                hasher.combine(nil as Int?)
            }
            if let value = record {
                hasher.combine(value)
            } else {
                hasher.combine(nil as Int?)
            }
            if let value = labels {
                hasher.combine(value)
            } else {
                hasher.combine(nil as Int?)
            }
        }

        public func isEqual(to other: any ATProtocolValue) -> Bool {
            guard let other = other as? Self else { return false }
            if fullsize != other.fullsize {
                return false
            }
            if thumb != other.thumb {
                return false
            }
            if name != other.name {
                return false
            }
            if alt != other.alt {
                return false
            }
            if aspectRatio != other.aspectRatio {
                return false
            }
            if record != other.record {
                return false
            }
            if labels != other.labels {
                return false
            }
            return true
        }

        public static func == (lhs: Self, rhs: Self) -> Bool {
            return lhs.isEqual(to: rhs)
        }

        public func toCBORValue() throws -> Any {
            var map = OrderedCBORMap()
            map = map.adding(key: "$type", value: Self.typeIdentifier)
            let fullsizeValue = try fullsize.toCBORValue()
            map = map.adding(key: "fullsize", value: fullsizeValue)
            if let value = thumb {
                let thumbValue = try value.toCBORValue()
                map = map.adding(key: "thumb", value: thumbValue)
            }
            let nameValue = try name.toCBORValue()
            map = map.adding(key: "name", value: nameValue)
            if let value = alt {
                let altValue = try value.toCBORValue()
                map = map.adding(key: "alt", value: altValue)
            }
            if let value = aspectRatio {
                let aspectRatioValue = try value.toCBORValue()
                map = map.adding(key: "aspectRatio", value: aspectRatioValue)
            }
            if let value = record {
                let recordValue = try value.toCBORValue()
                map = map.adding(key: "record", value: recordValue)
            }
            if let value = labels {
                let labelsValue = try value.toCBORValue()
                map = map.adding(key: "labels", value: labelsValue)
            }
            return map
        }

        private enum CodingKeys: String, CodingKey {
            case typeIdentifier = "$type"
            case fullsize
            case thumb
            case name
            case alt
            case aspectRatio
            case record
            case labels
        }
    }

    public enum StickerFormatsUnion: Codable, ATProtocolCodable, ATProtocolValue, Sendable, Equatable {
        case blueMojiEmbedStickerFormatsV0(BlueMojiEmbedSticker.Formats_v0)
        case unexpected(ATProtocolValueContainer)
        public init(_ value: BlueMojiEmbedSticker.Formats_v0) {
            self = .blueMojiEmbedStickerFormatsV0(value)
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let typeValue = try container.decode(String.self, forKey: .type)

            switch typeValue {
            case "blue.moji.embed.sticker#formats_v0":
                let value = try BlueMojiEmbedSticker.Formats_v0(from: decoder)
                self = .blueMojiEmbedStickerFormatsV0(value)
            default:
                let unknownValue = try ATProtocolValueContainer(from: decoder)
                self = .unexpected(unknownValue)
            }
        }

        public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)

            switch self {
            case let .blueMojiEmbedStickerFormatsV0(value):
                try container.encode("blue.moji.embed.sticker#formats_v0", forKey: .type)
                try value.encode(to: encoder)
            case let .unexpected(container):
                try container.encode(to: encoder)
            }
        }

        public func hash(into hasher: inout Hasher) {
            switch self {
            case let .blueMojiEmbedStickerFormatsV0(value):
                hasher.combine("blue.moji.embed.sticker#formats_v0")
                hasher.combine(value)
            case let .unexpected(container):
                hasher.combine("unexpected")
                hasher.combine(container)
            }
        }

        private enum CodingKeys: String, CodingKey {
            case type = "$type"
        }

        public static func == (lhs: StickerFormatsUnion, rhs: StickerFormatsUnion) -> Bool {
            switch (lhs, rhs) {
            case let (.blueMojiEmbedStickerFormatsV0(lhsValue),
                      .blueMojiEmbedStickerFormatsV0(rhsValue)):
                return lhsValue == rhsValue
            case let (.unexpected(lhsValue), .unexpected(rhsValue)):
                return lhsValue.isEqual(to: rhsValue)
            default:
                return false
            }
        }

        public func isEqual(to other: any ATProtocolValue) -> Bool {
            guard let other = other as? StickerFormatsUnion else { return false }
            return self == other
        }

        /// DAGCBOR encoding with field ordering
        public func toCBORValue() throws -> Any {
            // Create an ordered map to maintain field order
            var map = OrderedCBORMap()

            switch self {
            case let .blueMojiEmbedStickerFormatsV0(value):
                map = map.adding(key: "$type", value: "blue.moji.embed.sticker#formats_v0")

                let valueDict = try value.toCBORValue()

                // If the value is already an OrderedCBORMap, merge its entries
                if let orderedMap = valueDict as? OrderedCBORMap {
                    for (key, value) in orderedMap.entries where key != "$type" {
                        map = map.adding(key: key, value: value)
                    }
                } else if let dict = valueDict as? [String: Any] {
                    // Otherwise add each key-value pair from the dictionary
                    for (key, value) in dict where key != "$type" {
                        map = map.adding(key: key, value: value)
                    }
                }
                return map
            case let .unexpected(container):
                return try container.toCBORValue()
            }
        }
    }
}
