part of easy_tips;

abstract class EasyToast {
  factory EasyToast.long(
    String text, {
    double radius,
    TextStyle style,
    Color color,
    AlignmentGeometry align,
  }) {
    final _EasyToast easy = _EasyToast(
      EasyWrapContext.context,
      text: text,
      radius: radius,
      style: style,
      color: color,
      align: align,
    );
    easy.show();
    Future.delayed(Duration(milliseconds: 3500), easy.close);
    return easy;
  }

  factory EasyToast.short(
    String text, {
    double radius,
    TextStyle style,
    Color color,
    AlignmentGeometry align,
  }) {
    final _EasyToast easy = _EasyToast(
      EasyWrapContext.context,
      text: text,
      radius: radius,
      style: style,
      color: color,
      align: align,
    );
    easy.show();
    Future.delayed(Duration(milliseconds: 2000), easy.close);
    return easy;
  }

  factory EasyToast.delayed(
    Duration duration,
    String text, {
    double radius,
    TextStyle style,
    Color color,
    AlignmentGeometry align,
  }) {
    final _EasyToast easy = _EasyToast(
      EasyWrapContext.context,
      text: text,
      radius: radius,
      style: style,
      color: color,
      align: align,
    );
    easy.show();
    Future.delayed(duration, easy.close);
    return easy;
  }
}

// ignore: must_be_immutable
class _EasyToast extends StatelessWidget implements EasyToast {
  final BuildContext context;
  final double radius;
  final String text;
  final TextStyle style;
  final Color color;
  final AlignmentGeometry align;
  OverlayEntry _overlayEntry;

  _EasyToast(
    this.context, {
    this.text,
    this.radius,
    this.style,
    this.color,
    this.align,
  });

  void show() {
    if (_overlayEntry == null) {
      _overlayEntry = OverlayEntry(builder: (BuildContext context) => this);
    }
    Overlay.of(context).insert(_overlayEntry);
  }

  void close() {
    if (_overlayEntry != null) {
      _overlayEntry.remove();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Stack(
        children: <Widget>[
          GestureDetector(
            child: Container(
              color: Colors.transparent,
            ),
          ),
          SafeArea(
            child: Container(
              padding: EdgeInsets.all(30),
              alignment: align ?? Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.all(10),
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width,
                  minWidth: 100,
                ),
                decoration: BoxDecoration(
                  color:
                      color ?? Theme.of(context).dividerColor.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(radius ?? 8),
                ),
                child: Text(
                  text ?? '',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: style ??
                      TextStyle(
                        color: Theme.of(context).dialogBackgroundColor,
                      ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
