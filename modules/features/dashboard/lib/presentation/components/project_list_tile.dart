import 'package:core/styles/dimen.dart';
import 'package:core/utils/extensions/string_extensions.dart';
import 'package:flutter/material.dart';

class CollapsingListTile extends StatefulWidget {
  final String title;
  final AnimationController animationController;
  final bool isSelected;
  final Function()? onTap;

  const CollapsingListTile({
    super.key,
    required this.title,
    required this.animationController,
    this.isSelected = false,
    this.onTap,
  });

  @override
  State<CollapsingListTile> createState() => _CollapsingListTileState();
}

class _CollapsingListTileState extends State<CollapsingListTile> {
  late Animation<double> widthAnimation, sizedBoxAnimation;

  @override
  void initState() {
    super.initState();
    widthAnimation = Tween<double>(begin: dimen.width * .6, end: 64)
        .animate(widget.animationController);
    sizedBoxAnimation =
        Tween<double>(begin: 10, end: 0).animate(widget.animationController);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: widget.onTap,
      radius: 8,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          color:
              widget.isSelected ? theme.colorScheme.onPrimaryContainer : null,
        ),
        width: widthAnimation.value,
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        child: Row(
          children: <Widget>[
            Container(
              width: 32,
              height: 32,
              alignment: Alignment.center,
              child: Text(
                widget.title.firstLetter,
                style: theme.textTheme.titleLarge
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(width: sizedBoxAnimation.value),
            (widthAnimation.value >= dimen.width * .5)
                ? Text(widget.title)
                : Container()
          ],
        ),
      ),
    );
  }
}
