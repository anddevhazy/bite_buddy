import 'dart:async';
import 'dart:io';

import 'package:bite_buddy/features/global/core/error/error_messages.dart';
import 'package:bite_buddy/features/global/core/error/failures.dart';
import 'package:bite_buddy_client/bite_buddy_client.dart';
import 'package:flutter/foundation.dart';

class FailureMapper {
  const FailureMapper._();

  static Failure fromException(Object e) {
    // Errors the server meant for the user, with a readable message
    if (e is BiteBuddyException) {
      return switch (e.code) {
        'MEAL_REJECTED' || 'DUPLICATE_PHOTO' => MealRejectedFailure(e.message),
        'NOT_FOUND' => NotFoundFailure(e.message),
        'INVALID_INPUT' => ValidationFailure(e.message),
        'AI_UNAVAILABLE' => ServerFailure(e.message),
        _ => ValidationFailure(e.message),
      };
    }
    if (e is ServerpodClientNetworkException) {
      return const NetworkFailure(ErrorMessages.network);
    }
    if (e is ServerpodClientUnauthorized) {
      return const UnauthorizedFailure(ErrorMessages.unauthorized);
    }
    if (e is ServerpodClientNotFound) {
      return const NotFoundFailure(ErrorMessages.notFound);
    }
    if (e is ServerpodClientException) {
      return const ServerFailure(ErrorMessages.server);
    }
    if (e is SocketException ||
        e is TimeoutException ||
        e is HandshakeException) {
      return const NetworkFailure(ErrorMessages.network);
    }
    debugPrint('[Unexpected error] ${e.runtimeType}: $e');
    return const UnexpectedFailure(ErrorMessages.unexpected);
  }
}
