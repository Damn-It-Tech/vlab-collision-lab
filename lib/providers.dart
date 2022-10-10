import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vlab1/actions_view.dart';

final actionsViewProvider = Provider<ActionsView>((ref) {
  return ActionsView();
});
