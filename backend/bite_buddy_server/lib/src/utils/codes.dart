import 'dart:math';

// Short codes people read out or type: friend codes and challenge codes.
// Leaves out 0/O, 1/I/L so they can't be mixed up.
const _alphabet = 'ABCDEFGHJKMNPQRSTUVWXYZ23456789';
const int codeLength = 6;

final _rng = Random.secure();

String newCode() => [
  for (var i = 0; i < codeLength; i++) _alphabet[_rng.nextInt(_alphabet.length)],
].join();

// Codes are shown in capitals, but people type them however they like
String normalizeCode(String code) =>
    code.trim().toUpperCase().replaceAll(RegExp(r'\s|-'), '');
