import 'dart:typed_data';

import 'package:equatable/equatable.dart';

// A buddy picture made from a photo of the user's pet, waiting to be used
class PortraitDraftEntity extends Equatable {
  final int id;
  final Uint8List image;
  // What the AI saw, e.g. "dog"
  final String animal;
  final int triesLeftToday;

  const PortraitDraftEntity({
    required this.id,
    required this.image,
    required this.animal,
    required this.triesLeftToday,
  });

  @override
  List<Object?> get props => [id, triesLeftToday];
}
