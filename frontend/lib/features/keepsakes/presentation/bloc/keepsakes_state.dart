part of 'keepsakes_cubit.dart';

abstract class KeepsakesState extends Equatable {
  @override
  List<Object?> get props => [];
}

class KeepsakesLoading extends KeepsakesState {}

class KeepsakesLoaded extends KeepsakesState {
  final WalletEntity? wallet;
  final List<KeepsakeEntity> keepsakes;
  // Set while that keepsake is being minted
  final String? mintingKey;
  final bool creatingWallet;

  KeepsakesLoaded({
    required this.wallet,
    required this.keepsakes,
    this.mintingKey,
    this.creatingWallet = false,
  });

  KeepsakesLoaded copyWith({
    WalletEntity? wallet,
    List<KeepsakeEntity>? keepsakes,
    String? mintingKey,
    bool? creatingWallet,
  }) => KeepsakesLoaded(
    wallet: wallet ?? this.wallet,
    keepsakes: keepsakes ?? this.keepsakes,
    mintingKey: mintingKey,
    creatingWallet: creatingWallet ?? false,
  );

  @override
  List<Object?> get props => [wallet, keepsakes, mintingKey, creatingWallet];
}

class KeepsakesFailed extends KeepsakesState {
  final Failure failure;

  KeepsakesFailed({required this.failure});

  String get message => failure.message;

  @override
  List<Object?> get props => [failure.message];
}
