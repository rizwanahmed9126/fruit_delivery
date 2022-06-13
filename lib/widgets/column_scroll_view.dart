library column_scroll_view;

import 'package:flutter/widgets.dart';

/// ColumnScrollView possibility that you create and insert
/// Column and Flex itens inside [SingleChildScrollView].
/// {@tool snippet}
///
/// ```dart
/// ColumnScrollView(
///   child: Column(
///     children: <Widget>[],
///   ),
/// );
/// ```
/// {@end-tool}
class ColumnScrollView extends StatelessWidget {
  /// Create the a SingleChildScrollView that receive Column as child.
  ColumnScrollView({
    Key? key,
    required this.child,
    this.flex = false,
    // ignore: unnecessary_null_comparison
  })  : assert(flex != null),
        // ignore: unnecessary_null_comparison
        assert(child != null),
        super(key: key);

  /// Widget child with the type [Column]
  final Column child;

  /// The flex factor to use IntrinsicHeight or not. This Widget make possible
  /// to insert Flex widget inside another flex itens.
  final bool flex;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: viewportConstraints.maxHeight,
            ),
            child: SafeArea(
              child: flex
                  ? IntrinsicHeight(
                      child: child,
                    )
                  : child,
            ),
          ),
        );
      },
    );
  }
}
