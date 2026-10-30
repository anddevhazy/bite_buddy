import 'package:bite_buddy/features/global/components/app_error_view.dart';
import 'package:bite_buddy/features/global/components/app_toast.dart';
import 'package:bite_buddy/features/global/components/forest_background.dart';
import 'package:bite_buddy/features/global/components/game_button.dart';
import 'package:bite_buddy/features/global/components/glass_card.dart';
import 'package:bite_buddy/features/global/constants/colors.dart';
import 'package:bite_buddy/features/global/constants/spacing.dart';
import 'package:bite_buddy/features/global/constants/text_styles.dart';
import 'package:bite_buddy/features/global/services/sound_service.dart';
import 'package:bite_buddy/features/guide/domain/entities/guide_topic.dart';
import 'package:bite_buddy/features/guide/presentation/widgets/info_button.dart';
import 'package:bite_buddy/features/keepsakes/domain/entities/keepsake_entities.dart';
import 'package:bite_buddy/features/keepsakes/presentation/bloc/keepsakes_cubit.dart';
import 'package:bite_buddy/features/keepsakes/presentation/widgets/keepsake_card.dart';
import 'package:bite_buddy/features/pet/presentation/bloc/pet_cubit.dart';
import 'package:bite_buddy/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

// "My collection": the player's wallet on Base and their keepsake NFTs
class KeepsakesPage extends StatelessWidget {
  const KeepsakesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<KeepsakesCubit>()..load(),
      child: Scaffold(
        body: ForestBackground(
          child: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Row(
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
                          'My collection',
                          textAlign: TextAlign.center,
                          style: AppTextStyles.h2,
                        ),
                      ),
                      const InfoButton(topics: [GuideTopicId.keepsakes]),
                    ],
                  ),
                ),
                Expanded(
                  child: BlocBuilder<KeepsakesCubit, KeepsakesState>(
                    builder: (context, state) => switch (state) {
                      KeepsakesLoaded() => RefreshIndicator(
                        color: AppColors.primary,
                        onRefresh: () => context.read<KeepsakesCubit>().load(),
                        child: _Collection(state: state),
                      ),
                      KeepsakesFailed(:final message) => AppErrorView(
                        message: message,
                        onRetry: () => context.read<KeepsakesCubit>().load(),
                      ),
                      _ => const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primary,
                        ),
                      ),
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Collection extends StatelessWidget {
  final KeepsakesLoaded state;

  const _Collection({required this.state});

  @override
  Widget build(BuildContext context) {
    final wallet = state.wallet;
    final minted = state.keepsakes.where((k) => k.minted).toList();
    final ready = state.keepsakes.where((k) => !k.minted).toList();
    return ListView(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        0,
        AppSpacing.lg,
        AppSpacing.xl,
      ),
      children: [
        if (wallet == null || wallet.isTest) ...[
          const _TestModeBanner(),
          const SizedBox(height: AppSpacing.md),
        ],
        if (wallet == null)
          _CreateWallet(creating: state.creatingWallet)
        else
          _WalletCard(wallet: wallet),
        if (wallet != null && ready.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.lg),
          Text('Ready to mint', style: AppTextStyles.h2),
          Text(
            'Milestones you\'ve earned. Minting is free.',
            style: AppTextStyles.caption,
          ),
          const SizedBox(height: AppSpacing.sm),
          _Grid(keepsakes: ready, mintingKey: state.mintingKey),
        ],
        const SizedBox(height: AppSpacing.lg),
        Text('In your wallet', style: AppTextStyles.h2),
        const SizedBox(height: AppSpacing.sm),
        if (minted.isEmpty)
          Text(
            wallet == null
                ? 'Create your wallet to start your collection.'
                : 'Nothing yet. Mint your buddy certificate above!',
            style: AppTextStyles.bodyMedium,
          )
        else
          _Grid(keepsakes: minted, mintingKey: null),
        const SizedBox(height: AppSpacing.lg),
        Text(
          'Coming up: 7, 30, 100 and 365-day streaks · levels 10, 25 and 50 · '
          '100 and 500 meals · weekly league trophies',
          style: AppTextStyles.caption.copyWith(color: AppColors.textMuted),
        ),
      ],
    );
  }
}

// Honest about test mode wherever keepsakes appear
class _TestModeBanner extends StatelessWidget {
  const _TestModeBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.accent.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.accent.withValues(alpha: 0.6)),
      ),
      child: Row(
        children: [
          const Icon(Icons.science_rounded, color: AppColors.accent),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              'Test mode: wallets and keepsakes aren\'t on the Base '
              'blockchain yet. Everything else works the same.',
              style: AppTextStyles.caption.copyWith(color: AppColors.white),
            ),
          ),
        ],
      ),
    );
  }
}

class _CreateWallet extends StatelessWidget {
  final bool creating;

  const _CreateWallet({required this.creating});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('🔐 Your wallet', style: AppTextStyles.h3),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'Get a crypto wallet on Base to collect keepsake NFTs: your '
            'buddy\'s certificate and cards for big milestones. They\'re '
            'soulbound, so they stay yours and can\'t be sold. No seed '
            'phrase, and minting is free.',
            style: AppTextStyles.bodyMedium,
          ),
          const SizedBox(height: AppSpacing.md),
          GameButton(
            label: 'Create my wallet',
            isLoading: creating,
            onPressed: () => _create(context),
          ),
        ],
      ),
    );
  }

  Future<void> _create(BuildContext context) async {
    final cubit = context.read<KeepsakesCubit>();
    // Only "My own pet" buddies have a real photo to ask about
    final hasPhoto = context.read<PetCubit>().pet?.portraitId != null;
    var showPhoto = false;
    if (hasPhoto) {
      final answer = await showDialog<bool>(
        context: context,
        builder: (dialogContext) => AlertDialog(
          backgroundColor: AppColors.card,
          title: Text('Show your pet\'s photo?', style: AppTextStyles.h3),
          content: Text(
            'NFTs are public: anyone can see them, for good. Put your pet\'s '
            'photo on your keepsakes, or a paw print instead? You can change '
            'this later for new keepsakes.',
            style: AppTextStyles.bodyMedium,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: const Text('Use a paw'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, true),
              child: const Text('Show the photo'),
            ),
          ],
        ),
      );
      if (answer == null) return;
      showPhoto = answer;
    }
    final result = await cubit.createWallet(showPetPhoto: showPhoto);
    if (!context.mounted) return;
    result.fold(
      (failure) => AppToast.show(
        context: context,
        message: failure.message,
        type: ToastType.error,
      ),
      (_) => AppToast.show(
        context: context,
        message: 'Wallet created! Mint your buddy certificate below.',
        type: ToastType.success,
      ),
    );
  }
}

class _WalletCard extends StatelessWidget {
  final WalletEntity wallet;

  const _WalletCard({required this.wallet});

  @override
  Widget build(BuildContext context) {
    final hasPhoto = context.read<PetCubit>().pet?.portraitId != null;
    return GlassCard(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('🔐 Wallet', style: AppTextStyles.h3),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color:
                      (wallet.isTest ? AppColors.accent : AppColors.nutrition)
                          .withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  wallet.networkName,
                  style: AppTextStyles.caption.copyWith(color: AppColors.white),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          Row(
            children: [
              Expanded(
                child: Text(
                  wallet.shortAddress,
                  style: AppTextStyles.bodyLarge.copyWith(
                    fontFeatures: const [FontFeature.tabularFigures()],
                  ),
                ),
              ),
              IconButton(
                tooltip: 'Copy address',
                icon: const Icon(Icons.copy_rounded, size: 20),
                onPressed: () async {
                  await Clipboard.setData(ClipboardData(text: wallet.address));
                  if (!context.mounted) return;
                  AppToast.show(
                    context: context,
                    message: 'Wallet address copied',
                    type: ToastType.success,
                  );
                },
              ),
              if (wallet.explorerUrl case final url?)
                IconButton(
                  tooltip: 'View on Basescan',
                  icon: const Icon(Icons.open_in_new_rounded, size: 20),
                  onPressed: () => _open(context, url),
                ),
            ],
          ),
          if (hasPhoto)
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              dense: true,
              activeThumbColor: AppColors.primary,
              title: Text(
                'Show my pet\'s photo on new keepsakes',
                style: AppTextStyles.bodyMedium,
              ),
              value: wallet.showPetPhoto,
              onChanged: (show) =>
                  context.read<KeepsakesCubit>().setShowPetPhoto(show),
            ),
        ],
      ),
    );
  }
}

class _Grid extends StatelessWidget {
  final List<KeepsakeEntity> keepsakes;
  final String? mintingKey;

  const _Grid({required this.keepsakes, required this.mintingKey});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = (constraints.maxWidth - AppSpacing.md) / 2;
        return Wrap(
          spacing: AppSpacing.md,
          runSpacing: AppSpacing.md,
          children: [
            for (final k in keepsakes)
              SizedBox(
                width: width,
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: k.minted ? () => _showDetails(context, k) : null,
                      child: Opacity(
                        opacity: k.minted ? 1 : 0.75,
                        child: KeepsakeCard(keepsake: k, width: width),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    if (!k.minted)
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton(
                          style: FilledButton.styleFrom(
                            backgroundColor: AppColors.primary,
                          ),
                          onPressed: mintingKey == null
                              ? () => _mint(context, k)
                              : null,
                          child: mintingKey == k.key
                              ? const SizedBox.square(
                                  dimension: 18,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: AppColors.white,
                                  ),
                                )
                              : const Text('Mint'),
                        ),
                      )
                    else
                      Text(
                        k.isTest ? 'Test mint ✓' : 'Minted on Base ✓',
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                  ],
                ),
              ),
          ],
        );
      },
    );
  }

  Future<void> _mint(BuildContext context, KeepsakeEntity k) async {
    final result = await context.read<KeepsakesCubit>().mint(k.key);
    if (!context.mounted) return;
    result.fold(
      (failure) => AppToast.show(
        context: context,
        message: failure.message,
        type: ToastType.error,
      ),
      (minted) {
        sl<SoundService>().play(Sfx.levelUp);
        _showDetails(context, minted, justMinted: true);
      },
    );
  }
}

// The card big, with its NFT details and links
void _showDetails(
  BuildContext context,
  KeepsakeEntity k, {
  bool justMinted = false,
}) {
  showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppColors.card,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (sheetContext) => SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          children: [
            if (justMinted) ...[
              Text('🎉 Minted to your wallet!', style: AppTextStyles.h2),
              const SizedBox(height: AppSpacing.md),
            ],
            KeepsakeCard(keepsake: k, width: 240),
            const SizedBox(height: AppSpacing.md),
            Text(
              [
                'Token #${k.tokenId}',
                'Edition #${k.edition}',
                'Soulbound',
                if (k.isTest) 'Test mode',
              ].join(' · '),
              style: AppTextStyles.caption,
            ),
            const SizedBox(height: AppSpacing.sm),
            if (k.txUrl case final url?)
              TextButton.icon(
                onPressed: () => _open(sheetContext, url),
                icon: const Icon(Icons.open_in_new_rounded),
                label: const Text('View the mint on Basescan'),
              ),
            if (k.metadataUrl case final url?)
              TextButton.icon(
                onPressed: () => _open(sheetContext, url),
                icon: const Icon(Icons.data_object_rounded),
                label: const Text('NFT details (what wallets see)'),
              ),
          ],
        ),
      ),
    ),
  );
}

Future<void> _open(BuildContext context, String url) async {
  final ok = await launchUrl(
    Uri.parse(url),
    mode: LaunchMode.externalApplication,
  );
  if (!ok && context.mounted) {
    AppToast.show(
      context: context,
      message: "Couldn't open the link.",
      type: ToastType.error,
    );
  }
}
