import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purchase_manager/features/dashboard/home/bloc/bloc_home.dart';
import 'package:purchase_manager/utilities/widgets/pm_dialogs.dart';

/// {@template DialogDeleteImage}
/// Dialog to confirm the deletion of an image
/// {@endtemplate}
class DialogDeleteImage extends StatelessWidget {
  /// {@macro DialogDeleteImage}
  const DialogDeleteImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PMDialogs.actionRequest(
      content: const Text('¿Estás seguro que deseas eliminar la imagen?'),
      onTapConfirm: () {
        context.read<BlocHome>().add(
              const BlocHomeEventDeleteImageAt(
                index: 0,
              ),
            );
        Navigator.pop(context);
      },
      title: 'Eliminar imagen',
      isEnabled: true,
    );
  }
}
