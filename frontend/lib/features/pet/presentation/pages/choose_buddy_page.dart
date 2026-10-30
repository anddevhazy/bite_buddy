import 'package:bite_buddy/features/global/components/app_toast.dart';
import 'package:bite_buddy/features/global/components/forest_background.dart';
import 'package:bite_buddy/features/global/components/game_art.dart';
import 'package:bite_buddy/features/global/components/glass_card.dart';
import 'package:bite_buddy/features/global/components/page_header.dart';
import 'package:bite_buddy/features/global/constants/app_images.dart';
import 'package:bite_buddy/features/global/constants/colors.dart';
import 'package:bite_buddy/features/global/constants/spacing.dart';
import 'package:bite_buddy/features/global/constants/species.dart';
import 'package:bite_buddy/features/global/constants/text_styles.dart';
import 'package:bite_buddy/features/global/routes/routes.dart';
import 'package:bite_buddy/features/pet/domain/entities/pet_species_entity.dart';
import 'package:bite_buddy/features/pet/presentation/bloc/pet_cubit.dart';
import 'package:bite_buddy/features/pet/presentation/widgets/name_buddy_sheet.dart';
import 'package:bite_buddy/features/pet/presentation/widgets/pet_avatar.dart';
import 'package:bite_buddy/features/guide/presentation/widgets/info_button.dart';
import 'package:bite_buddy/features/guide/domain/entities/guide_topic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ChooseBuddyPage extends StatelessWidget {
  const ChooseBuddyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ForestBackground(
        child: SafeArea(
          child: BlocConsumer<PetCubit, PetState>(
            listener: (context, state) {
              if (state is PetLoaded) {
                context.goNamed(Routes.petHomeName);
                // A newly adopted buddy: explain the basics once it's on screen
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  final rootContext = Routes.rootNavigatorKey.currentContext;
                  if (rootContext == null) return;
                  showGuideSheet(rootContext, const [
                    GuideTopicId.basics,
                    GuideTopicId.health,
                    GuideTopicId.energy,
                    GuideTopicId.nutrition,
                  ]);
                });
              }
              if (state is PetFailed) {
                AppToast.show(
                  context: context,
                  message: state.message,
                  type: ToastType.error,
                );
              }
            },
            // A failed adopt shows a toast, then the cubit goes back to NoPet
            buildWhen: (_, state) => state is! PetFailed,
            builder: (context, state) {
              if (state is! NoPet) {
                return const Center(
                  child: CircularProgressIndicator(color: AppColors.primary),
                );
              }
              return ListView(
                padding: const EdgeInsets.all(AppSpacing.lg),
                children: [
                  const SizedBox(height: AppSpacing.lg),
                  const PageHeader(
                    title: 'Choose Your Buddy',
                    subtitle: 'Select your NFT pet companion',
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    mainAxisSpacing: AppSpacing.md,
                    crossAxisSpacing: AppSpacing.md,
                    childAspectRatio: 0.8,
                    children: [
                      for (final s in state.species)
                        _BuddyCard(
                          species: s,
                          onTap: state is Adopting
                              ? null
                              : () => _confirm(context, s),
                        ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.md),
                  _OwnPetCard(
                    onTap: state is Adopting
                        ? null
                        : () => context.pushNamed(Routes.myPetPhotoName),
                  ),
                  if (state is Adopting) ...[
                    const SizedBox(height: AppSpacing.lg),
                    const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> _confirm(BuildContext context, PetSpeciesEntity species) async {
    final name = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.card,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => NameBuddySheet(
        picture: PetAvatar(speciesKey: species.key, size: 90),
        initialName: species.name,
      ),
    );
    if (name != null && context.mounted) {
      context.read<PetCubit>().adopt(species.key, name);
    }
  }
}

class _BuddyCard extends StatelessWidget {
  final PetSpeciesEntity species;
  final VoidCallback? onTap;

  const _BuddyCard({required this.species, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      onTap: onTap,
      padding: const EdgeInsets.all(AppSpacing.sm),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: Species.rarityColor(species.rarity),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                species.rarity.toUpperCase(),
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.white,
                  fontSize: 10,
                ),
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GameArt(AppImages.pet(species.key), size: 96),
                const SizedBox(height: AppSpacing.sm),
                Text(species.name, style: AppTextStyles.h3),
                Text(species.title, style: AppTextStyles.caption),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// The fifth choice: a buddy made from a photo of the user's real pet
class _OwnPetCard extends StatelessWidget {
  final VoidCallback? onTap;

  const _OwnPetCard({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      onTap: onTap,
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Row(
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primary.withValues(alpha: 0.2),
              border: Border.all(color: AppColors.primary, width: 3),
            ),
            child: const Icon(
              Icons.photo_camera_rounded,
              color: AppColors.primary,
              size: 32,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('My own pet', style: AppTextStyles.h3),
                Text(
                  'Turn a photo of your real pet into your buddy',
                  style: AppTextStyles.caption,
                ),
              ],
            ),
          ),
          const InfoButton(topics: [GuideTopicId.ownPet]),
        ],
      ),
    );
  }
}
