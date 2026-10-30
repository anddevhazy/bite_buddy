import 'package:bite_buddy/features/global/components/app_toast.dart';
import 'package:bite_buddy/features/global/components/buddy_picture.dart';
import 'package:bite_buddy/features/global/components/forest_background.dart';
import 'package:bite_buddy/features/global/components/game_button.dart';
import 'package:bite_buddy/features/global/constants/colors.dart';
import 'package:bite_buddy/features/global/constants/spacing.dart';
import 'package:bite_buddy/features/global/constants/text_styles.dart';
import 'package:bite_buddy/features/guide/domain/entities/guide_topic.dart';
import 'package:bite_buddy/features/guide/presentation/widgets/info_button.dart';
import 'package:bite_buddy/features/pet/presentation/bloc/pet_cubit.dart';
import 'package:bite_buddy/features/portrait/presentation/bloc/portrait_cubit.dart';
import 'package:bite_buddy/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

// "Use my own pet": turn a photo of the user's real pet into their buddy
class MyPetPhotoPage extends StatelessWidget {
  const MyPetPhotoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<PortraitCubit>(),
      child: const _MyPetPhotoView(),
    );
  }
}

class _MyPetPhotoView extends StatelessWidget {
  const _MyPetPhotoView();

  @override
  Widget build(BuildContext context) {
    final pet = context.read<PetCubit>().pet;
    return Scaffold(
      body: ForestBackground(
        child: SafeArea(
          child: BlocConsumer<PortraitCubit, PortraitState>(
            listener: (context, state) {
              if (state is PortraitFailed) {
                AppToast.show(
                  context: context,
                  message: state.message,
                  type: ToastType.error,
                );
              } else if (state is PortraitApplied) {
                context.read<PetCubit>().updatePet(state.pet);
                AppToast.show(
                  context: context,
                  message: state.pet.portraitId == null
                      ? '${state.pet.name} is back to their buddy look'
                      : '${state.pet.name} has a new look!',
                  type: ToastType.success,
                );
                context.pop();
              }
            },
            builder: (context, state) {
              return ListView(
                padding: const EdgeInsets.all(AppSpacing.lg),
                children: [
                  Row(
                    children: [
                      IconButton.filled(
                        style: IconButton.styleFrom(
                          backgroundColor: AppColors.primary,
                        ),
                        onPressed: () => context.pop(),
                        icon: const Icon(
                          Icons.arrow_back_rounded,
                          color: AppColors.white,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'Use my own pet',
                          textAlign: TextAlign.center,
                          style: AppTextStyles.h2,
                        ),
                      ),
                      const InfoButton(topics: [GuideTopicId.ownPet]),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  ...switch (state) {
                    PortraitReady(:final draft, :final applying) => [
                      Center(
                        child: PortraitCircle(bytes: draft.image, size: 220),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      Text(
                        'Meet your ${draft.animal} buddy!',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.h3,
                      ),
                      const SizedBox(height: AppSpacing.xl),
                      GameButton(
                        label: 'Use this picture',
                        isLoading: applying,
                        onPressed: () => context.read<PortraitCubit>().apply(),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      if (draft.triesLeftToday > 0)
                        TextButton(
                          onPressed: applying
                              ? null
                              : () => context.read<PortraitCubit>().startOver(),
                          child: Text(
                            'Try another photo (${draft.triesLeftToday} left '
                            'today)',
                          ),
                        ),
                    ],
                    PortraitMaking() => [
                      const SizedBox(height: AppSpacing.xl),
                      const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      Text(
                        'Getting your buddy ready...',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.bodyMedium,
                      ),
                    ],
                    _ => [
                      Text(
                        'Take or choose a photo of your real pet and it '
                        'becomes how your buddy looks everywhere: on My Pet, '
                        'in battles, leagues and your home-screen widget.',
                        style: AppTextStyles.bodyMedium,
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Text(
                        'Best results: just your pet, close up, in good '
                        'light. Photos with people in them are refused.',
                        style: AppTextStyles.caption,
                      ),
                      const SizedBox(height: AppSpacing.xl),
                      GameButton(
                        label: 'Take a photo',
                        style: GameButtonStyle.accent,
                        onPressed: () => _pick(context, ImageSource.camera),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      GameButton(
                        label: 'Choose from gallery',
                        onPressed: () => _pick(context, ImageSource.gallery),
                      ),
                      if (pet?.portraitId != null) ...[
                        const SizedBox(height: AppSpacing.lg),
                        TextButton(
                          onPressed: () =>
                              context.read<PortraitCubit>().clear(),
                          child: const Text('Go back to my buddy picture'),
                        ),
                      ],
                    ],
                  },
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> _pick(BuildContext context, ImageSource source) async {
    final cubit = context.read<PortraitCubit>();
    final XFile? file;
    try {
      // Small enough to upload quickly and stay under the server's 4 MB cap
      file = await ImagePicker().pickImage(
        source: source,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );
    } catch (_) {
      if (!context.mounted) return;
      AppToast.show(
        context: context,
        message:
            "Couldn't open the ${source == ImageSource.camera ? 'camera' : 'gallery'}.",
        type: ToastType.error,
      );
      return;
    }
    if (file == null) return;
    await cubit.make(await file.readAsBytes());
  }
}
