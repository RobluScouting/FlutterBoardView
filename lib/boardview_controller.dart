import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';

import 'boardview.dart';

class BoardViewController {
  BoardViewController();

  BoardViewState state;

  BoardViewMode get mode => state == null ? BoardViewMode.single : state.boardViewMode;

  int get page {
    if (state.boardViewController != null && state.boardViewController.hasClients) {
      return state.boardViewController.page.toInt();
    } else {
      return 0;
    }
  }

  void animateToBottom(int page, {int durationMs = 350, curve: Curves.linear}) {
    state.animateToBottom(page, Duration(milliseconds: durationMs), curve);
  }

  void animateToPage(int index,
      {int durationMs = 300, curve: Curves.ease, allowAnimationInterception = false}) {
    if (state.boardViewController != null && state.boardViewController.hasClients) {
      state.animateTo(false, index, Duration(milliseconds: durationMs), curve);
    }
  }

  Future<void> animateToPageRespectingLocks(int index,
      {int durationMs = 300, curve: Curves.ease}) async {
    if (state.boardViewController != null && state.boardViewController.hasClients) {
      await state.boardViewController
          .animateToPage(index, duration: Duration(milliseconds: durationMs), curve: curve);
    }
  }

  void animateToNextPage(
      {int durationMs = 300, curve: Curves.ease, allowAnimationInterception = false}) {
    animateToPage(page + 1,
        durationMs: durationMs,
        curve: curve,
        allowAnimationInterception: allowAnimationInterception);
  }

  void animateToPreviousPage(
      {int durationMs = 300, curve: Curves.ease, allowAnimationInterception = false}) {
    animateToPage(page - 1,
        durationMs: durationMs,
        curve: curve,
        allowAnimationInterception: allowAnimationInterception);
  }

  Future<void> toggleMode() async {
    if (state.boardViewController != null && state.boardViewController.hasClients) {
      await state.toggleMode();
    }
  }
}
