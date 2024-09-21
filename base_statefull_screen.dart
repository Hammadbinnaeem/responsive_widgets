import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constant/responsive_widget.dart';

/// This abstract class is a base class for stateful widgets that use Riverpod.
/// It provides common functionality and structure for its subclasses.
///
/// Example of how to extend [BaseConsumerStatefull]:
///
/// ```dart
/// class AppointmentScreen extends BaseConsumerStatefull {
///   const AppointmentScreen({super.key});
///
///   @override
///   AppointmentScreenState createState() => AppointmentScreenState();
/// }
///
/// class AppointmentScreenState extends BaseConsumerStatefullState<AppointmentScreen> {
///   @override
///   Widget buildBody(BuildContext context, WidgetRef ref) {
///     return Column(
///       children: [
///         Center(
///           child: Text("Appointment Screen"),
///         )
///       ],
///     );
///   }
/// }
/// ```
abstract class BaseConsumerStatefull extends ConsumerStatefulWidget {
  final Map<String, String>? params;

  /// Creates a [BaseConsumerStatefull] widget.
  ///
  /// The [params] parameter is optional and can be used to pass additional
  /// data to the widget.
  const BaseConsumerStatefull({super.key, this.params});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      BaseConsumerStatefullState();
}

/// This state class provides a base structure for [BaseConsumerStatefull] widgets.
/// Subclasses should override the methods to customize the behavior and UI.
class BaseConsumerStatefullState<T extends BaseConsumerStatefull>
    extends ConsumerState<T> {
  final ScrollController _scrollController = ScrollController();

  /// This method is called when the widget is initialized.
  ///
  /// Subclasses should override this method to perform initialization tasks.
  void onInit(BuildContext context, WidgetRef ref) {}

  /// This method is called when the widget is disposed.
  ///
  /// Subclasses should override this method to perform cleanup tasks.
  void onDispose() {}

  /// This method should be overridden to build the main body of the widget.
  ///
  /// By default, it returns an empty [SizedBox].
  Widget buildBody(BuildContext context, WidgetRef ref) {
    return const SizedBox();
  }

  /// This method returns the app bar widget.
  ///
  /// Subclasses can override this method to provide a custom app bar.
  Widget? appBar(BuildContext context) {
    return null;
  }

  /// This method returns the end drawer widget.
  ///
  /// Subclasses can override this method to provide a custom end drawer.
  Widget? endDrawer() => null;

  /// This method returns the bottom navigation bar widget.
  ///
  /// Subclasses can override this method to provide a custom bottom navigation bar.
  Widget? bottomBar() => null;

  /// This method returns the floating action button widget.
  ///
  /// Subclasses can override this method to provide a custom floating action button.
  Widget? floatingActionButton() => null;

  /// This widget will be displayed only on large screens.
  ///
  /// Subclasses can override this method to provide a custom side panel.
  Widget sidePanel() => const SizedBox();

  /// The alignment of the widget on large screens.
  AlignmentGeometry? _alignment;

  /// The key of the widget.
  Key? _key;

  /// Sets the key of the widget.
  void setKey({Key? value}) {
    _key = value;
  }

  /// Sets the alignment of the widget on large screens.
  ///
  /// Subclasses can override this method to change the alignment.
  void setAlignment({Alignment? value}) {
    _alignment = value;
  }

  /// Gets the alignment of the widget on large screens.
  AlignmentGeometry get alignment => _alignment ?? Alignment.topCenter;

  /// The constraints of the widget.
  BoxConstraints? _boxConstraints;

  /// The background color of the widget.
  Color? backgroundColor;

  /// Gets the constraints of the widget.
  BoxConstraints get constraints =>
      _boxConstraints ?? const BoxConstraints(maxWidth: 720);

  /// Sets the constraints of the widget.
  void setConstraints({BoxConstraints? value}) {
    _boxConstraints = value;
  }

  @override
  void dispose() {
    onDispose();
    super.dispose();
  }

  @override
  void initState() {
    setAlignment();
    setConstraints();
    setKey();
    onInit(context, ref);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Build the main scaffold of the widget
    return Scaffold(
      backgroundColor: backgroundColor,
      key: _key,
      bottomNavigationBar: bottomBar(),
      floatingActionButton: floatingActionButton(),
      endDrawer: endDrawer(),
      appBar: appBar(context) != null
          ? PreferredSize(
              preferredSize: const Size.fromHeight(70), child: appBar(context)!)
          : null,
      body: ResponsiveWidget.isSmallScreen(context)
          ? mobileBaseView()
          : largeBaseView(),
    );
  }

  /// Builds the base view for small screens.
  Widget mobileBaseView() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: buildBody(context, ref),
      ),
    );
  }

  /// Builds the base view for large screens.
  Widget largeBaseView() {
    return SelectionArea(
      child: Scrollbar(
        scrollbarOrientation: ScrollbarOrientation.right,
        controller: _scrollController,
        child: Align(
          alignment: alignment,
          child: ConstrainedBox(
            constraints: constraints,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  flex: 2,
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                      child: buildBody(context, ref),
                    ),
                  ),
                ),
                if (ResponsiveWidget.isLargeScreen(context))
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: ResponsiveWidget.isLargeScreen(context)
                          ? sidePanel()
                          : null,
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
