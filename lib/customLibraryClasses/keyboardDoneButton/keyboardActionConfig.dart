import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

class KeyboardCustomActions {
  KeyboardActionsConfig buildConfig(
      BuildContext context, FocusNode _nodeText1) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.IOS,
      keyboardBarColor: Colors.grey[200],
      nextFocus: true,
      actions: [
        KeyboardActionsItem(
          toolbarButtons: [
            (node) {
              return GestureDetector(
                onTap: () => node.unfocus(),
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Done",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
              );
            }
          ],
          displayArrows: false,
          focusNode: _nodeText1,
          footerBuilder: (_) => PreferredSize(
              child: SizedBox(height: 2, child: Container()),
              preferredSize: Size.fromHeight(2)),
        ),
      ],
    );
  }
}
