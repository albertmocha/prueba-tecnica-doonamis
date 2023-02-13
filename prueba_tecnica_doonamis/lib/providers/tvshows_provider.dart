import 'package:flutter/material.dart';
import '../api/api_rest.dart';
import '../classes/tv_show.dart';
import '../widgets/custom_snackbar.dart';

class TVShowsProvider extends ChangeNotifier {
  List<TVShow> _popularTVShows = [];
  TVShow? _tvShow;
  int _page = 1;
  int limitOffset = 20;
  bool _hasMorePages = true;

  Future<void> init(BuildContext context) async {
    getPopularShows(context);
  }

  Future<void> getPopularShows(BuildContext context) async {
    try {
      _popularTVShows = await APIRest.getPopularTVShows(page: _page);
    } catch (e) {
      CustomSnackBar.show(
          context: context, text: e.toString(), color: Colors.red);
    }
    notifyListeners();
  }

  Future<void> getShowDetails(int id, BuildContext context) async {
    try {
      _tvShow = await APIRest.getTVShowInfo(id: id);
    } catch (e) {
      CustomSnackBar.show(
          context: context, text: e.toString(), color: Colors.red);
    }
    notifyListeners();
  }

  Future loadNewPage(context) async {
    try {
      _page++;
      final popularTVShowsNextPage =
          await APIRest.getPopularTVShows(page: _page);
      _popularTVShows.addAll(popularTVShowsNextPage);
      if (popularTVShowsNextPage.length < limitOffset) {
        _hasMorePages = false;
      }
    } catch (e) {
      CustomSnackBar.show(
          context: context, text: e.toString(), color: Colors.red);
    }
    notifyListeners();
  }

  List<TVShow> get popularTVShows => _popularTVShows;
  set popularTVShows(value) {
    _popularTVShows = value;
  }

  TVShow get tvShow => _tvShow!;
  set tvShow(value) {
    _tvShow = value;
  }

  bool get hasMorePages => _hasMorePages;
  set hasMorePages(value) {
    _hasMorePages = value;
  }
}
