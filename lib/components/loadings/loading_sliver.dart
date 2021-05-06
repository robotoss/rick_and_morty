import 'package:flutter/material.dart';
import 'package:rick_and_morty/components/loadings/portal_loading.dart';

class LoadingSliver extends StatelessWidget {
  const LoadingSliver({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: PortalLoading(),
      ),
    );
  }
}
