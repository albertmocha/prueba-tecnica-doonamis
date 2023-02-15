import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qsdokinvgokqw/pages/shows_details_page.dart';
import '../global/global.dart';
import '../providers/tvshows_provider.dart';
import '../utils/colors.dart';
import '../widgets/tvshow_line.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Global.language = AppLocalizations.of(context)!.language;
      final showsProvider =
          Provider.of<TVShowsProvider>(context, listen: false);
      showsProvider.init(context);
      controller.addListener(() {
        if (controller.position.maxScrollExtent == controller.offset &&
            showsProvider.hasMorePages) {
          showsProvider.loadNewPage(context);
        }
      });
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
                      child: Text(
                        AppLocalizations.of(context)!.list_title,
                        style: const TextStyle(
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
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ShowsDetailsPage(
                                    tvShow: showsProvider.popularTVShows[index],
                                  ),
                                ),
                              );
                            },
                            child: TVShowLine(
                              tvShow: showsProvider.popularTVShows[index],
                            ),
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
