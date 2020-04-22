part of easy_tips;

abstract class EasyLoading {
  factory EasyLoading.task(
    VoidCallback computation, {
    double raduis,
    Color color,
    Color boxColor,
    String text,
    TextStyle style,
  }) {
    final _EasyLoading easy = _EasyLoading(
      EasyWrapContext.context,
      raduis: raduis,
      color: color,
      boxColor: boxColor,
      text: ValueNotifier<String>(text),
      style: style,
    );
    easy.show();
    Future(computation).whenComplete(() {
      easy.close();
    });
    return easy;
  }

  factory EasyLoading({
    double raduis,
    Color color,
    Color boxColor,
    String text,
    TextStyle style,
  }) {
    return _EasyLoading(
      EasyWrapContext.context,
      raduis: raduis,
      color: color,
      boxColor: boxColor,
      text: ValueNotifier<String>(text),
      style: style,
    );
  }

  void show();

  void close();

  void setText(String text);
}

// ignore: must_be_immutable
class _EasyLoading extends StatelessWidget implements EasyLoading {
  final BuildContext context;
  final double raduis;
  final Color color;
  final Color boxColor;
  final ValueNotifier<String> text;
  final TextStyle style;

  _EasyLoading(
    this.context, {
    this.raduis,
    this.color,
    this.boxColor,
    this.text,
    this.style,
  });

  OverlayEntry _overlayEntry;

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

  Widget build(BuildContext context) {
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
              width: (raduis ?? 20) * 2 + 60,
              height: (raduis ?? 20) * 2 + 60,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: boxColor ?? theme.dividerColor.withOpacity(0.7),
                borderRadius: BorderRadius.circular(6),
              ),
              alignment: Alignment.center,
              child: ValueListenableBuilder<String>(
                valueListenable: text,
                builder: (context, text, _) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: _buildIndicator(theme, text),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  List<Widget> _buildIndicator(ThemeData theme, String text) {
    List<Widget> widgets = <Widget>[
      ColorFiltered(
        colorFilter: ColorFilter.mode(
          color ?? theme.dialogBackgroundColor,
          BlendMode.srcIn,
        ),
        child: CupertinoActivityIndicator(
          radius: raduis ?? 20,
        ),
      )
    ];
    if (text != null && text.isNotEmpty) {
      widgets.addAll([
        SizedBox(height: 8),
        Text(
          text ?? "",
          overflow: TextOverflow.ellipsis,
          style: style ??
              TextStyle(
                color: color ?? theme.dialogBackgroundColor,
              ),
        )
      ]);
    }
    return widgets;
  }

  @override
  void setText(String text) {
    this.text.value = text;
  }
}
