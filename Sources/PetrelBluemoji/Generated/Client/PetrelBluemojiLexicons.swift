import Foundation
import Petrel

/// Registers all PetrelBluemoji lexicon types with Petrel's ATProtocolValueContainer
/// decoder registry so they decode as .knownType when embedded in core responses.
/// Call once at app startup, before decoding any responses containing these types.
public enum PetrelBluemojiLexicons {
    public static func register() {
        ATProtocolValueContainer.registerDecoder(forType: "blue.moji.collection.defs#collectionView", as: BlueMojiCollectionDefs.CollectionView.self)
        ATProtocolValueContainer.registerDecoder(forType: "blue.moji.collection.item", as: BlueMojiCollectionItem.self)
        ATProtocolValueContainer.registerDecoder(forType: "blue.moji.collection.item#formats_v0", as: BlueMojiCollectionItem.Formats_v0.self)
        ATProtocolValueContainer.registerDecoder(forType: "blue.moji.collection.item#formats_v1", as: BlueMojiCollectionItem.Formats_v1.self)
        ATProtocolValueContainer.registerDecoder(forType: "blue.moji.collection.item#stickerFormats_v0", as: BlueMojiCollectionItem.StickerFormats_v0.self)
        ATProtocolValueContainer.registerDecoder(forType: "blue.moji.collection.item#itemView", as: BlueMojiCollectionItem.ItemView.self)
        ATProtocolValueContainer.registerDecoder(forType: "blue.moji.collection.item#originalCreator", as: BlueMojiCollectionItem.OriginalCreator.self)
        ATProtocolValueContainer.registerDecoder(forType: "blue.moji.embed.sticker", as: BlueMojiEmbedSticker.self)
        ATProtocolValueContainer.registerDecoder(forType: "blue.moji.embed.sticker#sticker", as: BlueMojiEmbedSticker.Sticker.self)
        ATProtocolValueContainer.registerDecoder(forType: "blue.moji.embed.sticker#formats_v0", as: BlueMojiEmbedSticker.Formats_v0.self)
        ATProtocolValueContainer.registerDecoder(forType: "blue.moji.embed.sticker#view", as: BlueMojiEmbedSticker.View.self)
        ATProtocolValueContainer.registerDecoder(forType: "blue.moji.embed.sticker#viewSticker", as: BlueMojiEmbedSticker.ViewSticker.self)
        ATProtocolValueContainer.registerDecoder(forType: "blue.moji.feed.defs#reactionView", as: BlueMojiFeedDefs.ReactionView.self)
        ATProtocolValueContainer.registerDecoder(forType: "blue.moji.feed.defs#reactionGroup", as: BlueMojiFeedDefs.ReactionGroup.self)
        ATProtocolValueContainer.registerDecoder(forType: "blue.moji.feed.getReactionCounts#subjectReactionCounts", as: BlueMojiFeedGetReactionCounts.SubjectReactionCounts.self)
        ATProtocolValueContainer.registerDecoder(forType: "blue.moji.feed.reaction", as: BlueMojiFeedReaction.self)
        ATProtocolValueContainer.registerDecoder(forType: "blue.moji.feed.reaction#emojiRef", as: BlueMojiFeedReaction.EmojiRef.self)
        ATProtocolValueContainer.registerDecoder(forType: "blue.moji.packs.defs#packViewBasic", as: BlueMojiPacksDefs.PackViewBasic.self)
        ATProtocolValueContainer.registerDecoder(forType: "blue.moji.packs.defs#packView", as: BlueMojiPacksDefs.PackView.self)
        ATProtocolValueContainer.registerDecoder(forType: "blue.moji.packs.defs#packItemView", as: BlueMojiPacksDefs.PackItemView.self)
        ATProtocolValueContainer.registerDecoder(forType: "blue.moji.packs.defs#packViewerState", as: BlueMojiPacksDefs.PackViewerState.self)
        ATProtocolValueContainer.registerDecoder(forType: "blue.moji.packs.pack", as: BlueMojiPacksPack.self)
        ATProtocolValueContainer.registerDecoder(forType: "blue.moji.packs.packitem", as: BlueMojiPacksPackitem.self)
        ATProtocolValueContainer.registerDecoder(forType: "blue.moji.richtext.facet", as: BlueMojiRichtextFacet.self)
        ATProtocolValueContainer.registerDecoder(forType: "blue.moji.richtext.facet#formats_v1", as: BlueMojiRichtextFacet.Formats_v1.self)
        ATProtocolValueContainer.registerDecoder(forType: "blue.moji.richtext.facet#formats_v0", as: BlueMojiRichtextFacet.Formats_v0.self)
    }
}
