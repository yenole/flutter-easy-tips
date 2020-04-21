part of easy_tips;


class EasyWrapContext extends StatelessWidget {
  final Widget child;
  static BuildContext context;

  EasyWrapContext({Key key, this.child});

  @override
  Widget build(BuildContext context) {
    EasyWrapContext.context = context;
    return child;
  }
}