import 'dart:io';

// Finds files shipped with the server (web/...). Locally the server runs
// from its own folder; in the cloud it may start somewhere else, so this
// also looks next to the running program and in the folders above it.
String serverPath(String relative) {
  final starts = <Directory>{
    Directory.current,
    File(Platform.resolvedExecutable).parent,
    File.fromUri(Platform.script).parent,
  };
  for (final start in starts) {
    var dir = start;
    for (var i = 0; i < 5; i++) {
      for (final candidate in [
        '${dir.path}/$relative',
        '${dir.path}/backend/bite_buddy_server/$relative',
      ]) {
        if (FileSystemEntity.typeSync(candidate) !=
            FileSystemEntityType.notFound) {
          return candidate;
        }
      }
      if (dir.parent.path == dir.path) break;
      dir = dir.parent;
    }
  }
  return relative;
}
