import 'package:flutter/material.dart';

class FavoriteLoadingWidget extends StatelessWidget {
  const FavoriteLoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: 6,
      separatorBuilder: (_, _) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        return const Card(
          child: ListTile(
            leading: CircleAvatar(),
            title: LinearProgressIndicator(minHeight: 10),
            subtitle: Padding(
              padding: EdgeInsets.only(top: 8),
              child: LinearProgressIndicator(minHeight: 8),
            ),
          ),
        );
      },
    );
  }
}