import 'dart:typed_data';

import 'package:bite_buddy/features/global/services/portrait_cache.dart';
import 'package:bite_buddy/features/pet/data/models/pet_model.dart';
import 'package:bite_buddy/features/pet/domain/entities/pet_entity.dart';
import 'package:bite_buddy/features/portrait/data/data_sources/remote/portrait_remote_data_source.dart';
import 'package:bite_buddy/features/portrait/domain/entities/portrait_draft_entity.dart';
import 'package:bite_buddy_client/bite_buddy_client.dart';

class PortraitRemoteDataSourceImpl implements PortraitRemoteDataSource {
  final Client client;
  final PortraitCache cache;

  PortraitRemoteDataSourceImpl({required this.client, required this.cache});

  @override
  Future<PortraitDraftEntity> create(Uint8List photo) async {
    final draft = await client.portrait.create(ByteData.sublistView(photo));
    final image = draft.image.buffer.asUint8List(
      draft.image.offsetInBytes,
      draft.image.lengthInBytes,
    );
    // Already on the phone, so showing it later needs no download
    cache.put(draft.id, image);
    return PortraitDraftEntity(
      id: draft.id,
      image: image,
      animal: draft.animal,
      triesLeftToday: draft.triesLeftToday,
    );
  }

  @override
  Future<PetEntity> apply(int portraitId) async =>
      PetModel.fromProtocol(await client.portrait.apply(portraitId));

  @override
  Future<PetEntity> clear() async =>
      PetModel.fromProtocol(await client.portrait.clear());
}
