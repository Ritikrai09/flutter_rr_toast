import 'package:flutter/material.dart';

//NotifyToast Widget
class NotifyToast extends StatefulWidget {
  final Widget child;
  final Function? slideOffFunc;
  final List<DismissDirection>? dismissDirections;

  const NotifyToast({
       Key? key,
      required this.child,
      this.slideOffFunc,
      this.dismissDirections})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _NotifiyState createState() => _NotifiyState();
}

class _NotifiyState extends State<NotifyToast> {
  Future<bool> confirmDismiss(DismissDirection direction) async {
    widget.slideOffFunc?.call();
    return true;
  }
  Key key = UniqueKey();

  @override
  Widget build(BuildContext context) {
    Widget child = widget.child;

    if (widget.slideOffFunc != null &&
        widget.dismissDirections != null &&
        widget.dismissDirections!.isNotEmpty) {
      for (var direction in widget.dismissDirections!) {
        child = Dismissible(
          direction: direction,
          key: key,
          confirmDismiss: confirmDismiss,
          child: child,
        );
      }
    }

    return child;
  }
}
