// "My own pet": checking the photo before it's turned into a buddy.
// Plain values and functions, so they're easy to test.

const int maxPortraitsPerDay = 3; // redraws will cost money once they're real
const int maxPortraitPhotoBytes = 4 * 1024 * 1024;
const int minPortraitPhotoBytes = 10 * 1024;

const portraitCheckSystemPrompt = '''
You check photos in Bite Buddy, a game where people can turn a photo of their own pet into their game buddy. Decide whether the photo can be used. isAnimal is true only if the main subject is a real animal (a pet such as a dog, cat, rabbit, bird, fish, hamster or reptile, or any other real animal). hasPeople is true if any person, face or body part of a person is clearly visible; we never turn people into buddies. animal is the kind of animal in one or two lowercase words (e.g. "dog", "cat", "guinea pig"), or an empty string. If the photo can't be used, explain why in rejectionReason in one short friendly sentence; otherwise leave it empty.''';

const portraitCheckPrompt = 'Can this photo become a buddy?';

const portraitCheckSchema = <String, dynamic>{
  'type': 'object',
  'properties': {
    'isAnimal': {'type': 'boolean'},
    'hasPeople': {'type': 'boolean'},
    'animal': {'type': 'string'},
    'rejectionReason': {'type': 'string'},
  },
  'required': ['isAnimal', 'hasPeople', 'animal', 'rejectionReason'],
  'additionalProperties': false,
};

// The AI's verdict: null animal means the photo can't be used, with a reason
({String? animal, String reason}) readPortraitCheck(Map<String, dynamic> json) {
  final isAnimal = json['isAnimal'] == true;
  final hasPeople = json['hasPeople'] != false; // unsure counts as people
  final animal = (json['animal'] as String? ?? '').trim().toLowerCase();
  final reason = (json['rejectionReason'] as String? ?? '').trim();
  if (!isAnimal || animal.isEmpty) {
    return (
      animal: null,
      reason: reason.isNotEmpty
          ? reason
          : "We couldn't spot an animal. Try a clear photo of your pet.",
    );
  }
  if (hasPeople) {
    return (
      animal: null,
      reason:
          'Please use a photo with just your pet in it, with no people in '
          'the picture.',
    );
  }
  return (animal: animal, reason: '');
}

// 'image/jpeg' or 'image/png' from the file's first bytes, or null
String? photoMimeType(List<int> bytes) {
  if (bytes.length > 3 && bytes[0] == 0xFF && bytes[1] == 0xD8) {
    return 'image/jpeg';
  }
  if (bytes.length > 8 &&
      bytes[0] == 0x89 &&
      bytes[1] == 0x50 &&
      bytes[2] == 0x4E &&
      bytes[3] == 0x47) {
    return 'image/png';
  }
  return null;
}
