import '../generated/protocol.dart';

// Shorthands for the errors endpoints throw. Each one reaches the app as a
// BiteBuddyException with the same code.

BiteBuddyException noPetError() => BiteBuddyException(
  code: 'NO_PET',
  message: "You don't have a pet yet. Adopt one first!",
);

BiteBuddyException notFoundError(String what) =>
    BiteBuddyException(code: 'NOT_FOUND', message: '$what not found.');

BiteBuddyException invalidInputError(String message) =>
    BiteBuddyException(code: 'INVALID_INPUT', message: message);

BiteBuddyException conflictError(String code, String message) =>
    BiteBuddyException(code: code, message: message);
