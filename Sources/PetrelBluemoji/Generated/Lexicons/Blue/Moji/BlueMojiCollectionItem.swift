import Foundation
import Petrel

// lexicon: 1, id: blue.moji.collection.item

public struct BlueMojiCollectionItem: ATProtocolCodable, ATProtocolValue {
    public static let typeIdentifier = "blue.moji.collection.item"
    public let name: String
    public let alt: String?
    public let createdAt: ATProtocolDate
    public let formats: BlueMojiCollectionItemFormatsUnion
    public let stickerFormats: BlueMojiCollectionItemStickerFormatsUnion?
    public let adultOnly: Bool?
    public let labels: BlueMojiCollectionItemLabelsUnion?
    public let copyOf: ATProtocolURI?
    public let fallbackText: String?

    public init(name: String, alt: String?, createdAt: ATProtocolDate, formats: BlueMojiCollectionItemFormatsUnion, stickerFormats: BlueMojiCollectionItemStickerFormatsUnion?, adultOnly: Bool?, labels: BlueMojiCollectionItemLabelsUnion?, copyOf: ATProtocolURI?, fallbackText: String?) {
        self.name = name
        self.alt = alt
        self.createdAt = createdAt
        self.formats = formats
        self.stickerFormats = stickerFormats
        self.adultOnly = adultOnly
        self.labels = labels
        self.copyOf = copyOf
        self.fallbackText = fallbackText
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        do {
            alt = try container.decodeIfPresent(String.self, forKey: .alt)
        } catch {
            // Forward compatibility: a malformed optional field must not fail the whole record.
            LogManager.logWarning("Decoding error for optional property 'alt' — degrading to nil: \(error)")
            alt = nil
        }
        createdAt = try container.decode(ATProtocolDate.self, forKey: .createdAt)
        formats = try container.decode(BlueMojiCollectionItemFormatsUnion.self, forKey: .formats)
        do {
            stickerFormats = try container.decodeIfPresent(BlueMojiCollectionItemStickerFormatsUnion.self, forKey: .stickerFormats)
        } catch {
            // Forward compatibility: a malformed optional field must not fail the whole record.
            LogManager.logWarning("Decoding error for optional property 'stickerFormats' — degrading to nil: \(error)")
            stickerFormats = nil
        }
        do {
            adultOnly = try container.decodeIfPresent(Bool.self, forKey: .adultOnly)
        } catch {
            // Forward compatibility: a malformed optional field must not fail the whole record.
            LogManager.logWarning("Decoding error for optional property 'adultOnly' — degrading to nil: \(error)")
            adultOnly = nil
        }
        do {
            labels = try container.decodeIfPresent(BlueMojiCollectionItemLabelsUnion.self, forKey: .labels)
        } catch {
            // Forward compatibility: a malformed optional field must not fail the whole record.
            LogManager.logWarning("Decoding error for optional property 'labels' — degrading to nil: \(error)")
            labels = nil
        }
        do {
            copyOf = try container.decodeIfPresent(ATProtocolURI.self, forKey: .copyOf)
        } catch {
            // Forward compatibility: a malformed optional field must not fail the whole record.
            LogManager.logWarning("Decoding error for optional property 'copyOf' — degrading to nil: \(error)")
            copyOf = nil
        }
        do {
            fallbackText = try container.decodeIfPresent(String.self, forKey: .fallbackText)
        } catch {
            // Forward compatibility: a malformed optional field must not fail the whole record.
            LogManager.logWarning("Decoding error for optional property 'fallbackText' — degrading to nil: \(error)")
            fallbackText = nil
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(Self.typeIdentifier, forKey: .typeIdentifier)
        try container.encode(name, forKey: .name)
        try container.encodeIfPresent(alt, forKey: .alt)
        try container.encode(createdAt, forKey: .createdAt)
        try container.encode(formats, forKey: .formats)
        try container.encodeIfPresent(stickerFormats, forKey: .stickerFormats)
        try container.encodeIfPresent(adultOnly, forKey: .adultOnly)
        try container.encodeIfPresent(labels, forKey: .labels)
        try container.encodeIfPresent(copyOf, forKey: .copyOf)
        try container.encodeIfPresent(fallbackText, forKey: .fallbackText)
    }

    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.isEqual(to: rhs)
    }

    public func isEqual(to other: any ATProtocolValue) -> Bool {
        guard let other = other as? Self else { return false }
        if name != other.name {
            return false
        }
        if alt != other.alt {
            return false
        }
        if createdAt != other.createdAt {
            return false
        }
        if formats != other.formats {
            return false
        }
        if stickerFormats != other.stickerFormats {
            return false
        }
        if adultOnly != other.adultOnly {
            return false
        }
        if labels != other.labels {
            return false
        }
        if copyOf != other.copyOf {
            return false
        }
        if fallbackText != other.fallbackText {
            return false
        }
        return true
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        if let value = alt {
            hasher.combine(value)
        } else {
            hasher.combine(nil as Int?)
        }
        hasher.combine(createdAt)
        hasher.combine(formats)
        if let value = stickerFormats {
            hasher.combine(value)
        } else {
            hasher.combine(nil as Int?)
        }
        if let value = adultOnly {
            hasher.combine(value)
        } else {
            hasher.combine(nil as Int?)
        }
        if let value = labels {
            hasher.combine(value)
        } else {
            hasher.combine(nil as Int?)
        }
        if let value = copyOf {
            hasher.combine(value)
        } else {
            hasher.combine(nil as Int?)
        }
        if let value = fallbackText {
            hasher.combine(value)
        } else {
            hasher.combine(nil as Int?)
        }
    }

    public func toCBORValue() throws -> Any {
        var map = OrderedCBORMap()
        map = map.adding(key: "$type", value: Self.typeIdentifier)
        let nameValue = try name.toCBORValue()
        map = map.adding(key: "name", value: nameValue)
        if let value = alt {
            let altValue = try value.toCBORValue()
            map = map.adding(key: "alt", value: altValue)
        }
        let createdAtValue = try createdAt.toCBORValue()
        map = map.adding(key: "createdAt", value: createdAtValue)
        let formatsValue = try formats.toCBORValue()
        map = map.adding(key: "formats", value: formatsValue)
        if let value = stickerFormats {
            let stickerFormatsValue = try value.toCBORValue()
            map = map.adding(key: "stickerFormats", value: stickerFormatsValue)
        }
        if let value = adultOnly {
            let adultOnlyValue = try value.toCBORValue()
            map = map.adding(key: "adultOnly", value: adultOnlyValue)
        }
        if let value = labels {
            let labelsValue = try value.toCBORValue()
            map = map.adding(key: "labels", value: labelsValue)
        }
        if let value = copyOf {
            let copyOfValue = try value.toCBORValue()
            map = map.adding(key: "copyOf", value: copyOfValue)
        }
        if let value = fallbackText {
            let fallbackTextValue = try value.toCBORValue()
            map = map.adding(key: "fallbackText", value: fallbackTextValue)
        }
        return map
    }

    private enum CodingKeys: String, CodingKey {
        case typeIdentifier = "$type"
        case name
        case alt
        case createdAt
        case formats
        case stickerFormats
        case adultOnly
        case labels
        case copyOf
        case fallbackText
    }

    public struct Formats_v0: ATProtocolCodable, ATProtocolValue {
        public static let typeIdentifier = "blue.moji.collection.item#formatsV0"
        public let original: Blob?
        public let png_128: Blob?
        public let apng_128: Bytes?
        public let gif_128: Blob?
        public let webp_128: Blob?
        public let lottie: Bytes?

        public init(
            original: Blob?, png_128: Blob?, apng_128: Bytes?, gif_128: Blob?, webp_128: Blob?, lottie: Bytes?
        ) {
            self.original = original
            self.png_128 = png_128
            self.apng_128 = apng_128
            self.gif_128 = gif_128
            self.webp_128 = webp_128
            self.lottie = lottie
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            do {
                original = try container.decodeIfPresent(Blob.self, forKey: .original)
            } catch {
                // Forward compatibility: a malformed or unknown-shaped optional field
                // must not fail the whole response.
                LogManager.logWarning("Decoding error for optional property 'original' — degrading to nil: \(error)")
                original = nil
            }
            do {
                png_128 = try container.decodeIfPresent(Blob.self, forKey: .png_128)
            } catch {
                // Forward compatibility: a malformed or unknown-shaped optional field
                // must not fail the whole response.
                LogManager.logWarning("Decoding error for optional property 'png_128' — degrading to nil: \(error)")
                png_128 = nil
            }
            do {
                apng_128 = try container.decodeIfPresent(Bytes.self, forKey: .apng_128)
            } catch {
                // Forward compatibility: a malformed or unknown-shaped optional field
                // must not fail the whole response.
                LogManager.logWarning("Decoding error for optional property 'apng_128' — degrading to nil: \(error)")
                apng_128 = nil
            }
            do {
                gif_128 = try container.decodeIfPresent(Blob.self, forKey: .gif_128)
            } catch {
                // Forward compatibility: a malformed or unknown-shaped optional field
                // must not fail the whole response.
                LogManager.logWarning("Decoding error for optional property 'gif_128' — degrading to nil: \(error)")
                gif_128 = nil
            }
            do {
                webp_128 = try container.decodeIfPresent(Blob.self, forKey: .webp_128)
            } catch {
                // Forward compatibility: a malformed or unknown-shaped optional field
                // must not fail the whole response.
                LogManager.logWarning("Decoding error for optional property 'webp_128' — degrading to nil: \(error)")
                webp_128 = nil
            }
            do {
                lottie = try container.decodeIfPresent(Bytes.self, forKey: .lottie)
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
            try container.encodeIfPresent(original, forKey: .original)
            try container.encodeIfPresent(png_128, forKey: .png_128)
            try container.encodeIfPresent(apng_128, forKey: .apng_128)
            try container.encodeIfPresent(gif_128, forKey: .gif_128)
            try container.encodeIfPresent(webp_128, forKey: .webp_128)
            try container.encodeIfPresent(lottie, forKey: .lottie)
        }

        public func hash(into hasher: inout Hasher) {
            if let value = original {
                hasher.combine(value)
            } else {
                hasher.combine(nil as Int?)
            }
            if let value = png_128 {
                hasher.combine(value)
            } else {
                hasher.combine(nil as Int?)
            }
            if let value = apng_128 {
                hasher.combine(value)
            } else {
                hasher.combine(nil as Int?)
            }
            if let value = gif_128 {
                hasher.combine(value)
            } else {
                hasher.combine(nil as Int?)
            }
            if let value = webp_128 {
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
            if original != other.original {
                return false
            }
            if png_128 != other.png_128 {
                return false
            }
            if apng_128 != other.apng_128 {
                return false
            }
            if gif_128 != other.gif_128 {
                return false
            }
            if webp_128 != other.webp_128 {
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
            if let value = original {
                let originalValue = try value.toCBORValue()
                map = map.adding(key: "original", value: originalValue)
            }
            if let value = png_128 {
                let png_128Value = try value.toCBORValue()
                map = map.adding(key: "png_128", value: png_128Value)
            }
            if let value = apng_128 {
                let apng_128Value = try value.toCBORValue()
                map = map.adding(key: "apng_128", value: apng_128Value)
            }
            if let value = gif_128 {
                let gif_128Value = try value.toCBORValue()
                map = map.adding(key: "gif_128", value: gif_128Value)
            }
            if let value = webp_128 {
                let webp_128Value = try value.toCBORValue()
                map = map.adding(key: "webp_128", value: webp_128Value)
            }
            if let value = lottie {
                let lottieValue = try value.toCBORValue()
                map = map.adding(key: "lottie", value: lottieValue)
            }
            return map
        }

        private enum CodingKeys: String, CodingKey {
            case typeIdentifier = "$type"
            case original
            case png_128
            case apng_128
            case gif_128
            case webp_128
            case lottie
        }
    }

    public struct Formats_v1: ATProtocolCodable, ATProtocolValue {
        public static let typeIdentifier = "blue.moji.collection.item#formatsV1"
        public let original: Blob?
        public let png_128: Blob?
        public let apng_128: Blob?
        public let gif_128: Blob?
        public let webp_128: Blob?
        public let lottie: Blob?

        public init(
            original: Blob?, png_128: Blob?, apng_128: Blob?, gif_128: Blob?, webp_128: Blob?, lottie: Blob?
        ) {
            self.original = original
            self.png_128 = png_128
            self.apng_128 = apng_128
            self.gif_128 = gif_128
            self.webp_128 = webp_128
            self.lottie = lottie
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            do {
                original = try container.decodeIfPresent(Blob.self, forKey: .original)
            } catch {
                // Forward compatibility: a malformed or unknown-shaped optional field
                // must not fail the whole response.
                LogManager.logWarning("Decoding error for optional property 'original' — degrading to nil: \(error)")
                original = nil
            }
            do {
                png_128 = try container.decodeIfPresent(Blob.self, forKey: .png_128)
            } catch {
                // Forward compatibility: a malformed or unknown-shaped optional field
                // must not fail the whole response.
                LogManager.logWarning("Decoding error for optional property 'png_128' — degrading to nil: \(error)")
                png_128 = nil
            }
            do {
                apng_128 = try container.decodeIfPresent(Blob.self, forKey: .apng_128)
            } catch {
                // Forward compatibility: a malformed or unknown-shaped optional field
                // must not fail the whole response.
                LogManager.logWarning("Decoding error for optional property 'apng_128' — degrading to nil: \(error)")
                apng_128 = nil
            }
            do {
                gif_128 = try container.decodeIfPresent(Blob.self, forKey: .gif_128)
            } catch {
                // Forward compatibility: a malformed or unknown-shaped optional field
                // must not fail the whole response.
                LogManager.logWarning("Decoding error for optional property 'gif_128' — degrading to nil: \(error)")
                gif_128 = nil
            }
            do {
                webp_128 = try container.decodeIfPresent(Blob.self, forKey: .webp_128)
            } catch {
                // Forward compatibility: a malformed or unknown-shaped optional field
                // must not fail the whole response.
                LogManager.logWarning("Decoding error for optional property 'webp_128' — degrading to nil: \(error)")
                webp_128 = nil
            }
            do {
                lottie = try container.decodeIfPresent(Blob.self, forKey: .lottie)
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
            try container.encodeIfPresent(original, forKey: .original)
            try container.encodeIfPresent(png_128, forKey: .png_128)
            try container.encodeIfPresent(apng_128, forKey: .apng_128)
            try container.encodeIfPresent(gif_128, forKey: .gif_128)
            try container.encodeIfPresent(webp_128, forKey: .webp_128)
            try container.encodeIfPresent(lottie, forKey: .lottie)
        }

        public func hash(into hasher: inout Hasher) {
            if let value = original {
                hasher.combine(value)
            } else {
                hasher.combine(nil as Int?)
            }
            if let value = png_128 {
                hasher.combine(value)
            } else {
                hasher.combine(nil as Int?)
            }
            if let value = apng_128 {
                hasher.combine(value)
            } else {
                hasher.combine(nil as Int?)
            }
            if let value = gif_128 {
                hasher.combine(value)
            } else {
                hasher.combine(nil as Int?)
            }
            if let value = webp_128 {
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
            if original != other.original {
                return false
            }
            if png_128 != other.png_128 {
                return false
            }
            if apng_128 != other.apng_128 {
                return false
            }
            if gif_128 != other.gif_128 {
                return false
            }
            if webp_128 != other.webp_128 {
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
            if let value = original {
                let originalValue = try value.toCBORValue()
                map = map.adding(key: "original", value: originalValue)
            }
            if let value = png_128 {
                let png_128Value = try value.toCBORValue()
                map = map.adding(key: "png_128", value: png_128Value)
            }
            if let value = apng_128 {
                let apng_128Value = try value.toCBORValue()
                map = map.adding(key: "apng_128", value: apng_128Value)
            }
            if let value = gif_128 {
                let gif_128Value = try value.toCBORValue()
                map = map.adding(key: "gif_128", value: gif_128Value)
            }
            if let value = webp_128 {
                let webp_128Value = try value.toCBORValue()
                map = map.adding(key: "webp_128", value: webp_128Value)
            }
            if let value = lottie {
                let lottieValue = try value.toCBORValue()
                map = map.adding(key: "lottie", value: lottieValue)
            }
            return map
        }

        private enum CodingKeys: String, CodingKey {
            case typeIdentifier = "$type"
            case original
            case png_128
            case apng_128
            case gif_128
            case webp_128
            case lottie
        }
    }

    public struct StickerFormats_v0: ATProtocolCodable, ATProtocolValue {
        public static let typeIdentifier = "blue.moji.collection.item#stickerFormatsV0"
        public let png_512: Blob?
        public let webp_512: Blob?
        public let gif_512: Blob?
        public let apng_512: Blob?
        public let lottie: Blob?

        public init(
            png_512: Blob?, webp_512: Blob?, gif_512: Blob?, apng_512: Blob?, lottie: Blob?
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
                png_512 = try container.decodeIfPresent(Blob.self, forKey: .png_512)
            } catch {
                // Forward compatibility: a malformed or unknown-shaped optional field
                // must not fail the whole response.
                LogManager.logWarning("Decoding error for optional property 'png_512' — degrading to nil: \(error)")
                png_512 = nil
            }
            do {
                webp_512 = try container.decodeIfPresent(Blob.self, forKey: .webp_512)
            } catch {
                // Forward compatibility: a malformed or unknown-shaped optional field
                // must not fail the whole response.
                LogManager.logWarning("Decoding error for optional property 'webp_512' — degrading to nil: \(error)")
                webp_512 = nil
            }
            do {
                gif_512 = try container.decodeIfPresent(Blob.self, forKey: .gif_512)
            } catch {
                // Forward compatibility: a malformed or unknown-shaped optional field
                // must not fail the whole response.
                LogManager.logWarning("Decoding error for optional property 'gif_512' — degrading to nil: \(error)")
                gif_512 = nil
            }
            do {
                apng_512 = try container.decodeIfPresent(Blob.self, forKey: .apng_512)
            } catch {
                // Forward compatibility: a malformed or unknown-shaped optional field
                // must not fail the whole response.
                LogManager.logWarning("Decoding error for optional property 'apng_512' — degrading to nil: \(error)")
                apng_512 = nil
            }
            do {
                lottie = try container.decodeIfPresent(Blob.self, forKey: .lottie)
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

    public struct ItemView: ATProtocolCodable, ATProtocolValue {
        public static let typeIdentifier = "blue.moji.collection.item#itemView"
        public let uri: ATProtocolURI?
        public let cid: CID?
        public let did: DID?
        public let name: String
        public let alt: String?
        public let createdAt: ATProtocolDate?
        public let formats: ItemViewFormatsUnion
        public let stickerFormats: ItemViewStickerFormatsUnion?
        public let adultOnly: Bool?
        public let copyOf: ATProtocolURI?
        public let originalCreator: OriginalCreator?

        public init(
            uri: ATProtocolURI?, cid: CID?, did: DID?, name: String, alt: String?, createdAt: ATProtocolDate?, formats: ItemViewFormatsUnion, stickerFormats: ItemViewStickerFormatsUnion?, adultOnly: Bool?, copyOf: ATProtocolURI?, originalCreator: OriginalCreator?
        ) {
            self.uri = uri
            self.cid = cid
            self.did = did
            self.name = name
            self.alt = alt
            self.createdAt = createdAt
            self.formats = formats
            self.stickerFormats = stickerFormats
            self.adultOnly = adultOnly
            self.copyOf = copyOf
            self.originalCreator = originalCreator
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            do {
                uri = try container.decodeIfPresent(ATProtocolURI.self, forKey: .uri)
            } catch {
                // Forward compatibility: a malformed or unknown-shaped optional field
                // must not fail the whole response.
                LogManager.logWarning("Decoding error for optional property 'uri' — degrading to nil: \(error)")
                uri = nil
            }
            do {
                cid = try container.decodeIfPresent(CID.self, forKey: .cid)
            } catch {
                // Forward compatibility: a malformed or unknown-shaped optional field
                // must not fail the whole response.
                LogManager.logWarning("Decoding error for optional property 'cid' — degrading to nil: \(error)")
                cid = nil
            }
            do {
                did = try container.decodeIfPresent(DID.self, forKey: .did)
            } catch {
                // Forward compatibility: a malformed or unknown-shaped optional field
                // must not fail the whole response.
                LogManager.logWarning("Decoding error for optional property 'did' — degrading to nil: \(error)")
                did = nil
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
                createdAt = try container.decodeIfPresent(ATProtocolDate.self, forKey: .createdAt)
            } catch {
                // Forward compatibility: a malformed or unknown-shaped optional field
                // must not fail the whole response.
                LogManager.logWarning("Decoding error for optional property 'createdAt' — degrading to nil: \(error)")
                createdAt = nil
            }
            do {
                formats = try container.decode(ItemViewFormatsUnion.self, forKey: .formats)
            } catch {
                LogManager.logError("Decoding error for required property 'formats': \(error)")
                throw error
            }
            do {
                stickerFormats = try container.decodeIfPresent(ItemViewStickerFormatsUnion.self, forKey: .stickerFormats)
            } catch {
                // Forward compatibility: a malformed or unknown-shaped optional field
                // must not fail the whole response.
                LogManager.logWarning("Decoding error for optional property 'stickerFormats' — degrading to nil: \(error)")
                stickerFormats = nil
            }
            do {
                adultOnly = try container.decodeIfPresent(Bool.self, forKey: .adultOnly)
            } catch {
                // Forward compatibility: a malformed or unknown-shaped optional field
                // must not fail the whole response.
                LogManager.logWarning("Decoding error for optional property 'adultOnly' — degrading to nil: \(error)")
                adultOnly = nil
            }
            do {
                copyOf = try container.decodeIfPresent(ATProtocolURI.self, forKey: .copyOf)
            } catch {
                // Forward compatibility: a malformed or unknown-shaped optional field
                // must not fail the whole response.
                LogManager.logWarning("Decoding error for optional property 'copyOf' — degrading to nil: \(error)")
                copyOf = nil
            }
            do {
                originalCreator = try container.decodeIfPresent(OriginalCreator.self, forKey: .originalCreator)
            } catch {
                // Forward compatibility: a malformed or unknown-shaped optional field
                // must not fail the whole response.
                LogManager.logWarning("Decoding error for optional property 'originalCreator' — degrading to nil: \(error)")
                originalCreator = nil
            }
        }

        public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(Self.typeIdentifier, forKey: .typeIdentifier)
            try container.encodeIfPresent(uri, forKey: .uri)
            try container.encodeIfPresent(cid, forKey: .cid)
            try container.encodeIfPresent(did, forKey: .did)
            try container.encode(name, forKey: .name)
            try container.encodeIfPresent(alt, forKey: .alt)
            try container.encodeIfPresent(createdAt, forKey: .createdAt)
            try container.encode(formats, forKey: .formats)
            try container.encodeIfPresent(stickerFormats, forKey: .stickerFormats)
            try container.encodeIfPresent(adultOnly, forKey: .adultOnly)
            try container.encodeIfPresent(copyOf, forKey: .copyOf)
            try container.encodeIfPresent(originalCreator, forKey: .originalCreator)
        }

        public func hash(into hasher: inout Hasher) {
            if let value = uri {
                hasher.combine(value)
            } else {
                hasher.combine(nil as Int?)
            }
            if let value = cid {
                hasher.combine(value)
            } else {
                hasher.combine(nil as Int?)
            }
            if let value = did {
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
            if let value = createdAt {
                hasher.combine(value)
            } else {
                hasher.combine(nil as Int?)
            }
            hasher.combine(formats)
            if let value = stickerFormats {
                hasher.combine(value)
            } else {
                hasher.combine(nil as Int?)
            }
            if let value = adultOnly {
                hasher.combine(value)
            } else {
                hasher.combine(nil as Int?)
            }
            if let value = copyOf {
                hasher.combine(value)
            } else {
                hasher.combine(nil as Int?)
            }
            if let value = originalCreator {
                hasher.combine(value)
            } else {
                hasher.combine(nil as Int?)
            }
        }

        public func isEqual(to other: any ATProtocolValue) -> Bool {
            guard let other = other as? Self else { return false }
            if uri != other.uri {
                return false
            }
            if cid != other.cid {
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
            if createdAt != other.createdAt {
                return false
            }
            if formats != other.formats {
                return false
            }
            if stickerFormats != other.stickerFormats {
                return false
            }
            if adultOnly != other.adultOnly {
                return false
            }
            if copyOf != other.copyOf {
                return false
            }
            if originalCreator != other.originalCreator {
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
            if let value = uri {
                let uriValue = try value.toCBORValue()
                map = map.adding(key: "uri", value: uriValue)
            }
            if let value = cid {
                let cidValue = try value.toCBORValue()
                map = map.adding(key: "cid", value: cidValue)
            }
            if let value = did {
                let didValue = try value.toCBORValue()
                map = map.adding(key: "did", value: didValue)
            }
            let nameValue = try name.toCBORValue()
            map = map.adding(key: "name", value: nameValue)
            if let value = alt {
                let altValue = try value.toCBORValue()
                map = map.adding(key: "alt", value: altValue)
            }
            if let value = createdAt {
                let createdAtValue = try value.toCBORValue()
                map = map.adding(key: "createdAt", value: createdAtValue)
            }
            let formatsValue = try formats.toCBORValue()
            map = map.adding(key: "formats", value: formatsValue)
            if let value = stickerFormats {
                let stickerFormatsValue = try value.toCBORValue()
                map = map.adding(key: "stickerFormats", value: stickerFormatsValue)
            }
            if let value = adultOnly {
                let adultOnlyValue = try value.toCBORValue()
                map = map.adding(key: "adultOnly", value: adultOnlyValue)
            }
            if let value = copyOf {
                let copyOfValue = try value.toCBORValue()
                map = map.adding(key: "copyOf", value: copyOfValue)
            }
            if let value = originalCreator {
                let originalCreatorValue = try value.toCBORValue()
                map = map.adding(key: "originalCreator", value: originalCreatorValue)
            }
            return map
        }

        private enum CodingKeys: String, CodingKey {
            case typeIdentifier = "$type"
            case uri
            case cid
            case did
            case name
            case alt
            case createdAt
            case formats
            case stickerFormats
            case adultOnly
            case copyOf
            case originalCreator
        }
    }

    public struct OriginalCreator: ATProtocolCodable, ATProtocolValue {
        public static let typeIdentifier = "blue.moji.collection.item#originalCreator"
        public let did: DID
        public let handle: String

        public init(
            did: DID, handle: String
        ) {
            self.did = did
            self.handle = handle
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            do {
                did = try container.decode(DID.self, forKey: .did)
            } catch {
                LogManager.logError("Decoding error for required property 'did': \(error)")
                throw error
            }
            do {
                handle = try container.decode(String.self, forKey: .handle)
            } catch {
                LogManager.logError("Decoding error for required property 'handle': \(error)")
                throw error
            }
        }

        public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(Self.typeIdentifier, forKey: .typeIdentifier)
            try container.encode(did, forKey: .did)
            try container.encode(handle, forKey: .handle)
        }

        public func hash(into hasher: inout Hasher) {
            hasher.combine(did)
            hasher.combine(handle)
        }

        public func isEqual(to other: any ATProtocolValue) -> Bool {
            guard let other = other as? Self else { return false }
            if did != other.did {
                return false
            }
            if handle != other.handle {
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
            let didValue = try did.toCBORValue()
            map = map.adding(key: "did", value: didValue)
            let handleValue = try handle.toCBORValue()
            map = map.adding(key: "handle", value: handleValue)
            return map
        }

        private enum CodingKeys: String, CodingKey {
            case typeIdentifier = "$type"
            case did
            case handle
        }
    }

    public enum BlueMojiCollectionItemFormatsUnion: Codable, ATProtocolCodable, ATProtocolValue, Sendable, Equatable {
        case blueMojiCollectionItemFormatsV0(BlueMojiCollectionItem.Formats_v0)
        case blueMojiCollectionItemFormatsV1(BlueMojiCollectionItem.Formats_v1)
        case unexpected(ATProtocolValueContainer)
        public init(_ value: BlueMojiCollectionItem.Formats_v0) {
            self = .blueMojiCollectionItemFormatsV0(value)
        }

        public init(_ value: BlueMojiCollectionItem.Formats_v1) {
            self = .blueMojiCollectionItemFormatsV1(value)
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let typeValue = try container.decode(String.self, forKey: .type)

            switch typeValue {
            case "blue.moji.collection.item#formats_v0":
                let value = try BlueMojiCollectionItem.Formats_v0(from: decoder)
                self = .blueMojiCollectionItemFormatsV0(value)
            case "blue.moji.collection.item#formats_v1":
                let value = try BlueMojiCollectionItem.Formats_v1(from: decoder)
                self = .blueMojiCollectionItemFormatsV1(value)
            default:
                let unknownValue = try ATProtocolValueContainer(from: decoder)
                self = .unexpected(unknownValue)
            }
        }

        public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)

            switch self {
            case let .blueMojiCollectionItemFormatsV0(value):
                try container.encode("blue.moji.collection.item#formats_v0", forKey: .type)
                try value.encode(to: encoder)
            case let .blueMojiCollectionItemFormatsV1(value):
                try container.encode("blue.moji.collection.item#formats_v1", forKey: .type)
                try value.encode(to: encoder)
            case let .unexpected(container):
                try container.encode(to: encoder)
            }
        }

        public func hash(into hasher: inout Hasher) {
            switch self {
            case let .blueMojiCollectionItemFormatsV0(value):
                hasher.combine("blue.moji.collection.item#formats_v0")
                hasher.combine(value)
            case let .blueMojiCollectionItemFormatsV1(value):
                hasher.combine("blue.moji.collection.item#formats_v1")
                hasher.combine(value)
            case let .unexpected(container):
                hasher.combine("unexpected")
                hasher.combine(container)
            }
        }

        private enum CodingKeys: String, CodingKey {
            case type = "$type"
        }

        public static func == (lhs: BlueMojiCollectionItemFormatsUnion, rhs: BlueMojiCollectionItemFormatsUnion) -> Bool {
            switch (lhs, rhs) {
            case let (.blueMojiCollectionItemFormatsV0(lhsValue),
                      .blueMojiCollectionItemFormatsV0(rhsValue)):
                return lhsValue == rhsValue
            case let (.blueMojiCollectionItemFormatsV1(lhsValue),
                      .blueMojiCollectionItemFormatsV1(rhsValue)):
                return lhsValue == rhsValue
            case let (.unexpected(lhsValue), .unexpected(rhsValue)):
                return lhsValue.isEqual(to: rhsValue)
            default:
                return false
            }
        }

        public func isEqual(to other: any ATProtocolValue) -> Bool {
            guard let other = other as? BlueMojiCollectionItemFormatsUnion else { return false }
            return self == other
        }

        /// DAGCBOR encoding with field ordering
        public func toCBORValue() throws -> Any {
            // Create an ordered map to maintain field order
            var map = OrderedCBORMap()

            switch self {
            case let .blueMojiCollectionItemFormatsV0(value):
                map = map.adding(key: "$type", value: "blue.moji.collection.item#formats_v0")

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
            case let .blueMojiCollectionItemFormatsV1(value):
                map = map.adding(key: "$type", value: "blue.moji.collection.item#formats_v1")

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

    public enum BlueMojiCollectionItemStickerFormatsUnion: Codable, ATProtocolCodable, ATProtocolValue, Sendable, Equatable {
        case blueMojiCollectionItemStickerFormatsV0(BlueMojiCollectionItem.StickerFormats_v0)
        case unexpected(ATProtocolValueContainer)
        public init(_ value: BlueMojiCollectionItem.StickerFormats_v0) {
            self = .blueMojiCollectionItemStickerFormatsV0(value)
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let typeValue = try container.decode(String.self, forKey: .type)

            switch typeValue {
            case "blue.moji.collection.item#stickerFormats_v0":
                let value = try BlueMojiCollectionItem.StickerFormats_v0(from: decoder)
                self = .blueMojiCollectionItemStickerFormatsV0(value)
            default:
                let unknownValue = try ATProtocolValueContainer(from: decoder)
                self = .unexpected(unknownValue)
            }
        }

        public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)

            switch self {
            case let .blueMojiCollectionItemStickerFormatsV0(value):
                try container.encode("blue.moji.collection.item#stickerFormats_v0", forKey: .type)
                try value.encode(to: encoder)
            case let .unexpected(container):
                try container.encode(to: encoder)
            }
        }

        public func hash(into hasher: inout Hasher) {
            switch self {
            case let .blueMojiCollectionItemStickerFormatsV0(value):
                hasher.combine("blue.moji.collection.item#stickerFormats_v0")
                hasher.combine(value)
            case let .unexpected(container):
                hasher.combine("unexpected")
                hasher.combine(container)
            }
        }

        private enum CodingKeys: String, CodingKey {
            case type = "$type"
        }

        public static func == (lhs: BlueMojiCollectionItemStickerFormatsUnion, rhs: BlueMojiCollectionItemStickerFormatsUnion) -> Bool {
            switch (lhs, rhs) {
            case let (.blueMojiCollectionItemStickerFormatsV0(lhsValue),
                      .blueMojiCollectionItemStickerFormatsV0(rhsValue)):
                return lhsValue == rhsValue
            case let (.unexpected(lhsValue), .unexpected(rhsValue)):
                return lhsValue.isEqual(to: rhsValue)
            default:
                return false
            }
        }

        public func isEqual(to other: any ATProtocolValue) -> Bool {
            guard let other = other as? BlueMojiCollectionItemStickerFormatsUnion else { return false }
            return self == other
        }

        /// DAGCBOR encoding with field ordering
        public func toCBORValue() throws -> Any {
            // Create an ordered map to maintain field order
            var map = OrderedCBORMap()

            switch self {
            case let .blueMojiCollectionItemStickerFormatsV0(value):
                map = map.adding(key: "$type", value: "blue.moji.collection.item#stickerFormats_v0")

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

    public enum BlueMojiCollectionItemLabelsUnion: Codable, ATProtocolCodable, ATProtocolValue, Sendable, Equatable {
        case comAtprotoLabelDefsSelfLabels(ComAtprotoLabelDefs.SelfLabels)
        case unexpected(ATProtocolValueContainer)
        public init(_ value: ComAtprotoLabelDefs.SelfLabels) {
            self = .comAtprotoLabelDefsSelfLabels(value)
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let typeValue = try container.decode(String.self, forKey: .type)

            switch typeValue {
            case "com.atproto.label.defs#selfLabels":
                let value = try ComAtprotoLabelDefs.SelfLabels(from: decoder)
                self = .comAtprotoLabelDefsSelfLabels(value)
            default:
                let unknownValue = try ATProtocolValueContainer(from: decoder)
                self = .unexpected(unknownValue)
            }
        }

        public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)

            switch self {
            case let .comAtprotoLabelDefsSelfLabels(value):
                try container.encode("com.atproto.label.defs#selfLabels", forKey: .type)
                try value.encode(to: encoder)
            case let .unexpected(container):
                try container.encode(to: encoder)
            }
        }

        public func hash(into hasher: inout Hasher) {
            switch self {
            case let .comAtprotoLabelDefsSelfLabels(value):
                hasher.combine("com.atproto.label.defs#selfLabels")
                hasher.combine(value)
            case let .unexpected(container):
                hasher.combine("unexpected")
                hasher.combine(container)
            }
        }

        private enum CodingKeys: String, CodingKey {
            case type = "$type"
        }

        public static func == (lhs: BlueMojiCollectionItemLabelsUnion, rhs: BlueMojiCollectionItemLabelsUnion) -> Bool {
            switch (lhs, rhs) {
            case let (.comAtprotoLabelDefsSelfLabels(lhsValue),
                      .comAtprotoLabelDefsSelfLabels(rhsValue)):
                return lhsValue == rhsValue
            case let (.unexpected(lhsValue), .unexpected(rhsValue)):
                return lhsValue.isEqual(to: rhsValue)
            default:
                return false
            }
        }

        public func isEqual(to other: any ATProtocolValue) -> Bool {
            guard let other = other as? BlueMojiCollectionItemLabelsUnion else { return false }
            return self == other
        }

        /// DAGCBOR encoding with field ordering
        public func toCBORValue() throws -> Any {
            // Create an ordered map to maintain field order
            var map = OrderedCBORMap()

            switch self {
            case let .comAtprotoLabelDefsSelfLabels(value):
                map = map.adding(key: "$type", value: "com.atproto.label.defs#selfLabels")

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

    public enum ItemViewFormatsUnion: Codable, ATProtocolCodable, ATProtocolValue, Sendable, Equatable {
        case blueMojiCollectionItemFormatsV0(BlueMojiCollectionItem.Formats_v0)
        case blueMojiCollectionItemFormatsV1(BlueMojiCollectionItem.Formats_v1)
        case unexpected(ATProtocolValueContainer)
        public init(_ value: BlueMojiCollectionItem.Formats_v0) {
            self = .blueMojiCollectionItemFormatsV0(value)
        }

        public init(_ value: BlueMojiCollectionItem.Formats_v1) {
            self = .blueMojiCollectionItemFormatsV1(value)
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let typeValue = try container.decode(String.self, forKey: .type)

            switch typeValue {
            case "blue.moji.collection.item#formats_v0":
                let value = try BlueMojiCollectionItem.Formats_v0(from: decoder)
                self = .blueMojiCollectionItemFormatsV0(value)
            case "blue.moji.collection.item#formats_v1":
                let value = try BlueMojiCollectionItem.Formats_v1(from: decoder)
                self = .blueMojiCollectionItemFormatsV1(value)
            default:
                let unknownValue = try ATProtocolValueContainer(from: decoder)
                self = .unexpected(unknownValue)
            }
        }

        public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)

            switch self {
            case let .blueMojiCollectionItemFormatsV0(value):
                try container.encode("blue.moji.collection.item#formats_v0", forKey: .type)
                try value.encode(to: encoder)
            case let .blueMojiCollectionItemFormatsV1(value):
                try container.encode("blue.moji.collection.item#formats_v1", forKey: .type)
                try value.encode(to: encoder)
            case let .unexpected(container):
                try container.encode(to: encoder)
            }
        }

        public func hash(into hasher: inout Hasher) {
            switch self {
            case let .blueMojiCollectionItemFormatsV0(value):
                hasher.combine("blue.moji.collection.item#formats_v0")
                hasher.combine(value)
            case let .blueMojiCollectionItemFormatsV1(value):
                hasher.combine("blue.moji.collection.item#formats_v1")
                hasher.combine(value)
            case let .unexpected(container):
                hasher.combine("unexpected")
                hasher.combine(container)
            }
        }

        private enum CodingKeys: String, CodingKey {
            case type = "$type"
        }

        public static func == (lhs: ItemViewFormatsUnion, rhs: ItemViewFormatsUnion) -> Bool {
            switch (lhs, rhs) {
            case let (.blueMojiCollectionItemFormatsV0(lhsValue),
                      .blueMojiCollectionItemFormatsV0(rhsValue)):
                return lhsValue == rhsValue
            case let (.blueMojiCollectionItemFormatsV1(lhsValue),
                      .blueMojiCollectionItemFormatsV1(rhsValue)):
                return lhsValue == rhsValue
            case let (.unexpected(lhsValue), .unexpected(rhsValue)):
                return lhsValue.isEqual(to: rhsValue)
            default:
                return false
            }
        }

        public func isEqual(to other: any ATProtocolValue) -> Bool {
            guard let other = other as? ItemViewFormatsUnion else { return false }
            return self == other
        }

        /// DAGCBOR encoding with field ordering
        public func toCBORValue() throws -> Any {
            // Create an ordered map to maintain field order
            var map = OrderedCBORMap()

            switch self {
            case let .blueMojiCollectionItemFormatsV0(value):
                map = map.adding(key: "$type", value: "blue.moji.collection.item#formats_v0")

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
            case let .blueMojiCollectionItemFormatsV1(value):
                map = map.adding(key: "$type", value: "blue.moji.collection.item#formats_v1")

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

    public enum ItemViewStickerFormatsUnion: Codable, ATProtocolCodable, ATProtocolValue, Sendable, Equatable {
        case blueMojiCollectionItemStickerFormatsV0(BlueMojiCollectionItem.StickerFormats_v0)
        case unexpected(ATProtocolValueContainer)
        public init(_ value: BlueMojiCollectionItem.StickerFormats_v0) {
            self = .blueMojiCollectionItemStickerFormatsV0(value)
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let typeValue = try container.decode(String.self, forKey: .type)

            switch typeValue {
            case "blue.moji.collection.item#stickerFormats_v0":
                let value = try BlueMojiCollectionItem.StickerFormats_v0(from: decoder)
                self = .blueMojiCollectionItemStickerFormatsV0(value)
            default:
                let unknownValue = try ATProtocolValueContainer(from: decoder)
                self = .unexpected(unknownValue)
            }
        }

        public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)

            switch self {
            case let .blueMojiCollectionItemStickerFormatsV0(value):
                try container.encode("blue.moji.collection.item#stickerFormats_v0", forKey: .type)
                try value.encode(to: encoder)
            case let .unexpected(container):
                try container.encode(to: encoder)
            }
        }

        public func hash(into hasher: inout Hasher) {
            switch self {
            case let .blueMojiCollectionItemStickerFormatsV0(value):
                hasher.combine("blue.moji.collection.item#stickerFormats_v0")
                hasher.combine(value)
            case let .unexpected(container):
                hasher.combine("unexpected")
                hasher.combine(container)
            }
        }

        private enum CodingKeys: String, CodingKey {
            case type = "$type"
        }

        public static func == (lhs: ItemViewStickerFormatsUnion, rhs: ItemViewStickerFormatsUnion) -> Bool {
            switch (lhs, rhs) {
            case let (.blueMojiCollectionItemStickerFormatsV0(lhsValue),
                      .blueMojiCollectionItemStickerFormatsV0(rhsValue)):
                return lhsValue == rhsValue
            case let (.unexpected(lhsValue), .unexpected(rhsValue)):
                return lhsValue.isEqual(to: rhsValue)
            default:
                return false
            }
        }

        public func isEqual(to other: any ATProtocolValue) -> Bool {
            guard let other = other as? ItemViewStickerFormatsUnion else { return false }
            return self == other
        }

        /// DAGCBOR encoding with field ordering
        public func toCBORValue() throws -> Any {
            // Create an ordered map to maintain field order
            var map = OrderedCBORMap()

            switch self {
            case let .blueMojiCollectionItemStickerFormatsV0(value):
                map = map.adding(key: "$type", value: "blue.moji.collection.item#stickerFormats_v0")

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
