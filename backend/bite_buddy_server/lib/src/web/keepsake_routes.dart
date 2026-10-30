import 'dart:async';
import 'dart:convert';

import 'package:serverpod/serverpod.dart';

import '../services/services.dart';

// Public pages wallets and marketplaces read for each keepsake NFT:
//   GET /keepsakes/{tokenId}            the metadata (the contract's tokenURI)
//   GET /keepsakes/{tokenId}/image.svg  the card picture
// Only minted keepsakes are served.
class KeepsakeRoute extends Route {
  @override
  FutureOr<Result> handleCall(Session session, Request request) async {
    final segments = request.url.pathSegments;
    final i = segments.indexOf('keepsakes');
    final tokenId = i >= 0 && i + 1 < segments.length
        ? int.tryParse(segments[i + 1])
        : null;
    final keepsake = tokenId == null
        ? null
        : await keepsakeService.findMinted(session, tokenId);
    if (keepsake == null) {
      return Response.notFound(body: Body.fromString('Not found'));
    }

    final wantsImage =
        segments.length > i + 2 && segments[i + 2] == 'image.svg';
    // Cards can be redrawn later, so caches only keep them for an hour
    final headers = Headers.build(
      (h) =>
          h.cacheControl = CacheControlHeader(maxAge: 3600, publicCache: true),
    );
    if (wantsImage) {
      return Response.ok(
        headers: headers,
        body: Body.fromString(
          await keepsakeService.cardSvg(session, keepsake),
          mimeType: const MimeType('image', 'svg+xml'),
        ),
      );
    }
    return Response.ok(
      headers: headers,
      body: Body.fromString(
        jsonEncode(await keepsakeService.metadata(session, keepsake)),
        mimeType: MimeType.json,
      ),
    );
  }
}
