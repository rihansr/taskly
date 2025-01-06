import 'package:core/styles/dimen.dart';
import 'package:core/styles/strings.dart';
import 'package:core/utils/extensions/string_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared/presentation/widgets/widgets.dart';

class CollapsingListTile extends StatefulWidget {
  final String title;
  final AnimationController animationController;
  final bool isSelected;
  final Function()? onTap;
  final Function()? onEdit;
  final Function()? onDelete;

  const CollapsingListTile({
    super.key,
    required this.title,
    required this.animationController,
    this.isSelected = false,
    this.onTap,
    this.onEdit,
    this.onDelete,
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
                ? Expanded(
                    child: Text(
                      widget.title,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                : Container(),
            if (widthAnimation.value >= dimen.width * .5)
              PopupMenuButton(
                itemBuilder: (context) {
                  return [
                    string.of(context).edit,
                    string.of(context).delete,
                  ].mapIndexed((i, e) {
                    return PopupMenuItem(
                      value: i,
                      child: Text(e),
                    );
                  }).toList();
                },
                child: const Icon(CupertinoIcons.ellipsis_vertical),
                onSelected: (i) {
                  switch (i) {
                    case 0:
                      widget.onEdit?.call();
                      break;
                    case 1:
                      widget.onDelete?.call();
                      break;
                  }
                },
              ),
          ],
        ),
      ),
    );
  }
}
