part of easy_tips;

abstract class EasyLoading {
  factory EasyLoading.wait(
    VoidCallback computation, {
    double raduis,
    Color color,
    Color boxColor,
  }) {
    final _EasyLoading easy = _EasyLoading(
      EasyWrapContext.context,
      raduis: raduis,
      color: color,
      boxColor: boxColor,
    );
    easy.show();
    Future.microtask(computation).whenComplete(() {
      easy.close();
    });
    return easy;
  }

  void show();

  void close();
}

class _EasyLoading implements EasyLoading {
  final BuildContext context;
  final double raduis;
  final Color color;
  final Color boxColor;

  OverlayEntry _overlayEntry;

  _EasyLoading(
    this.context, {
    this.raduis,
    this.color,
    this.boxColor,
  });

  void show() {
    if (_overlayEntry == null) {
      _overlayEntry = OverlayEntry(builder: _build);
    }
    Overlay.of(context).insert(_overlayEntry);
  }

  void close() {
    if (_overlayEntry != null) {
      _overlayEntry.remove();
    }
  }

  Widget _build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Material(
      color: Colors.transparent,
      child: Stack(
        children: <Widget>[
          GestureDetector(
            child: Container(
              color: Colors.transparent,
            ),
          ),
          Center(
            child: Container(
              padding: EdgeInsets.only(
                left: 30,
                right: 30,
                top: 30,
                bottom: 15,
              ),
              decoration: BoxDecoration(
                color: boxColor ?? theme.dividerColor.withOpacity(0.7),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      color ?? theme.dialogBackgroundColor,
                      BlendMode.srcIn,
                    ),
                    child: CupertinoActivityIndicator(
                      radius: raduis ?? 20,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "11111111111",
                    style: TextStyle(
                      color: color ?? theme.dialogBackgroundColor,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
