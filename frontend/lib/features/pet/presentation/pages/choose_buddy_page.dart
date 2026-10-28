import 'package:bite_buddy/features/global/components/app_toast.dart';
import 'package:bite_buddy/features/global/components/forest_background.dart';
import 'package:bite_buddy/features/global/components/game_art.dart';
import 'package:bite_buddy/features/global/components/game_button.dart';
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
      builder: (_) => _NameSheet(species: species),
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

class _NameSheet extends StatefulWidget {
  final PetSpeciesEntity species;

  const _NameSheet({required this.species});

  @override
  State<_NameSheet> createState() => _NameSheetState();
}

class _NameSheetState extends State<_NameSheet> {
  late final TextEditingController _controller = TextEditingController(
    text: widget.species.name,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.lg,
        AppSpacing.lg,
        MediaQuery.of(context).viewInsets.bottom + AppSpacing.lg,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          PetAvatar(speciesKey: widget.species.key, size: 90),
          Text('Name your buddy', style: AppTextStyles.h2),
          const SizedBox(height: AppSpacing.md),
          TextField(
            controller: _controller,
            maxLength: 20,
            textAlign: TextAlign.center,
            style: AppTextStyles.h3,
            cursorColor: AppColors.primary,
            decoration: InputDecoration(
              counterStyle: AppTextStyles.caption,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: AppColors.glassBorder),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: AppColors.primary),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          GameButton(
            label: 'Adopt',
            onPressed: () {
              final name = _controller.text.trim();
              if (name.isNotEmpty) Navigator.pop(context, name);
            },
          ),
        ],
      ),
    );
  }
}
