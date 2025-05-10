import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String? imageUrl;
  final String? heroTag;
  final VoidCallback? onTap;
  final Widget? trailing;

  const ListItem({
    super.key,
    required this.title,
    this.subtitle,
    this.imageUrl,
    this.heroTag,
    this.onTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(10),
      leading: imageUrl != null
          ? Hero(
              tag: heroTag ?? 'list_item_hero_$title',
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  imageUrl!,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
            )
          : null,
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      subtitle: subtitle != null ? Text(subtitle!) : null,
      trailing: trailing,
      onTap: onTap,
    );
  }
}
