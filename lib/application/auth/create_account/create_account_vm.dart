import 'package:paytrybe_test/application/core/trybe_view_model.dart';
import 'package:paytrybe_test/domain/auth/entities/create_acocunt.dart';
import 'package:paytrybe_test/domain/core/exceptions.dart';

class CreateAccountViewModel extends TrybeViewModel {
  @override
  final TrybeException error;
  @override
  final ViewState viewState;
  final CreateAccountEntity createAccountEntity;
  final int page;
  final bool obscurePassword;
  final bool showFormErrors;

  const CreateAccountViewModel({
    required this.error,
    required this.viewState,
    required this.createAccountEntity,
    required this.page,
    required this.obscurePassword,
    required this.showFormErrors,
  });

  factory CreateAccountViewModel.initial() => CreateAccountViewModel(
        error: const MessageException(''),
        viewState: ViewState.idle,
        createAccountEntity: CreateAccountEntity.empty(),
        page: 0,
        obscurePassword: true,
        showFormErrors: false,
      );

  CreateAccountViewModel copyWith({
    TrybeException? error,
    ViewState? viewState,
    CreateAccountEntity? createAccountEntity,
    int? page,
    bool? obscurePassword,
    bool? showFormErrors,
  }) {
    return CreateAccountViewModel(
      error: error ?? this.error,
      viewState: viewState ?? this.viewState,
      createAccountEntity: createAccountEntity ?? this.createAccountEntity,
      page: page ?? this.page,
      obscurePassword: obscurePassword ?? this.obscurePassword,
      showFormErrors: showFormErrors ?? this.showFormErrors,
    );
  }

  @override
  String toString() {
    return 'CreateAccountViewModel(error: $error, viewState: $viewState, createAccountEntity: $createAccountEntity, page: $page, obscurePassword: $obscurePassword, showFormErrors: $showFormErrors)';
  }

  @override
  List<Object?> get props => [
        error,
        viewState,
        createAccountEntity,
        page,
        obscurePassword,
        showFormErrors,
      ];
}
