import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:paytrybe_test/domain/core/exceptions.dart';
import 'package:paytrybe_test/shared/router/routes.dart';

enum ViewState { idle, loading, success, error }

abstract class TrybeViewModel extends Equatable {
  const TrybeViewModel();

  ViewState get viewState;

  TrybeException get error;

  @override
  bool? get stringify => true;
}

Future<void> launch<E extends TrybeViewModel>(
    List<E> model, Future<void> Function(List<E> model) launch) async {
  await Future.sync(() => launch(model));

  if (model.isEmpty) return;
  model.state.displayError();
}

extension TrybeViewModelListX<T extends TrybeViewModel> on List<T> {
  List<T> assign(T value) {
    this[0] = value;
    return this;
  }

  T get state => this[0];
}

extension TrybeViewModelX on TrybeViewModel {
  void displayError() async {
    if (viewState != ViewState.error) return;

    final context = AppRouter.rootNavigator.currentContext!;
    final snackbar = SnackBar(
      backgroundColor: Theme.of(context).colorScheme.error,
      content: Text(
        error.toString(),
        style: Theme.of(context)
            .textTheme
            .bodyMedium
            ?.copyWith(color: Theme.of(context).colorScheme.onSurface),
      ),
    );

    ScaffoldMessenger.maybeOf(context)?.showSnackBar(snackbar);
  }
}
