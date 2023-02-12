import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/tvshows_provider.dart';
import '../utils/colors.dart';
import '../widgets/tvshow_line.dart';

class PopularShowsPage extends StatefulWidget {
  const PopularShowsPage({
    Key? key,
  }) : super(key: key);

  @override
  State<PopularShowsPage> createState() => _PopularShowsPageState();
}

class _PopularShowsPageState extends State<PopularShowsPage> {
  final controller = ScrollController();

  @override
  void initState() {
    final showsProvider = Provider.of<TVShowsProvider>(context, listen: false);
    showsProvider.init(context);

    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.offset) {
        showsProvider.loadNewPage(context);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final showsProvider = Provider.of<TVShowsProvider>(context);
    return Scaffold(
        body: showsProvider.popularTVShows.isNotEmpty
            ? Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Container(
                      padding: const EdgeInsets.all(16.0),
                      child: const Text(
                        "Popular TV Shows",
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: AppColors.azulFuerte,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      controller: controller,
                      itemCount: showsProvider.popularTVShows.length + 1,
                      itemBuilder: (context, index) {
                        if (index < showsProvider.popularTVShows.length) {
                          return TVShowLine(
                            tvShow: showsProvider.popularTVShows[index],
                          );
                        } else {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 18),
                            child: Center(
                              child: showsProvider.hasMorePages
                                  ? const CircularProgressIndicator()
                                  : Container(),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              )
            : const Center(child: CircularProgressIndicator()));
  }
}
