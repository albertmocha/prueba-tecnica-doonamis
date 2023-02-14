import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../classes/tv_show.dart';
import '../global/global.dart';
import '../providers/tvshows_provider.dart';
import '../utils/colors.dart';
import '../widgets/text_bg_rounded_fill.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ShowsDetailsPage extends StatefulWidget {
  TVShow tvShow;
  ShowsDetailsPage({
    Key? key,
    required this.tvShow,
  }) : super(key: key);

  @override
  State<ShowsDetailsPage> createState() => _ShowsDetailsPageState();
}

class _ShowsDetailsPageState extends State<ShowsDetailsPage> {
  @override
  void initState() {
    super.initState();
    getDetails();
  }

  Future<void> getDetails() async {
    final showsProvider = Provider.of<TVShowsProvider>(context, listen: false);
    await showsProvider.getShowDetails(widget.tvShow.id, context);
    widget.tvShow = showsProvider.tvShow;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.azulTenue,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 35, 15, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    //TITULO DE LA SERIE---
                    TextBgRoundedFill(
                        text: widget.tvShow.name,
                        fontSize: 22,
                        backgroundColor: AppColors.azulFuerte,
                        altura: 60,
                        fontWeight: FontWeight.bold),
                    const Expanded(child: SizedBox()),
                    //---BOTON ARROW BACK---
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back_ios_new_rounded),
                      color: AppColors.scaffoldColor,
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                //---FECHA---
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(
                    widget.tvShow.releasedDate,
                    style: const TextStyle(
                      color: AppColors.scaffoldColor,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Expanded(child: SizedBox()),
          _ScoreWidget(widget: widget),
          //---STACK DE LA IMAGEN Y EL CONTENIDO DE INFORMACION---
          Stack(
            clipBehavior: Clip.none,
            children: [
              _BodyContainer(tvShow: widget.tvShow),
              _ImgWidget(widget: widget),
            ],
          ),
        ],
      ),
    );
  }
}

class _ImgWidget extends StatelessWidget {
  const _ImgWidget({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final ShowsDetailsPage widget;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 30,
      top: -170,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(
          '${Global.urlPoster}${widget.tvShow.imgPath}',
          width: 180,
          height: 220,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _ScoreWidget extends StatelessWidget {
  const _ScoreWidget({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final ShowsDetailsPage widget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 38, bottom: 20),
      child: Container(
        width: 80,
        height: 80,
        decoration: const BoxDecoration(
          color: AppColors.verde,
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
        child: Align(
          child: Text(
            widget.tvShow.score.toStringAsFixed(1),
            style: const TextStyle(
              color: AppColors.scaffoldColor,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class _BodyContainer extends StatelessWidget {
  final TVShow tvShow;
  const _BodyContainer({
    Key? key,
    required this.tvShow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.width * 1.25,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        color: AppColors.scaffoldColor,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(35.0),
          topLeft: Radius.circular(35.0),
        ),
      ),
      alignment: Alignment.topCenter,
      child: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: ListView(
          padding: const EdgeInsets.fromLTRB(25, 55, 25, 0),
          children: [
            Visibility(
                visible: tvShow.overview != '',
                child: _DescriptionContainer(tvShow: tvShow)),
            const SizedBox(height: 15),
            _ExtraInfoContainer(tvShow: tvShow),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}

class _DescriptionContainer extends StatelessWidget {
  final TVShow tvShow;
  const _DescriptionContainer({
    Key? key,
    required this.tvShow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 180),
      child: FittedBox(
        fit: BoxFit.contain,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.85,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(35.0)),
          ),
          child: Align(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Text(
                    AppLocalizations.of(context)!.description,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Divider(thickness: 2),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(tvShow.overview),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ExtraInfoContainer extends StatelessWidget {
  final TVShow tvShow;
  const _ExtraInfoContainer({
    Key? key,
    required this.tvShow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.contain,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.85,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(35.0)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              _subtitleInfo(AppLocalizations.of(context)!.released_date),
              Text(tvShow.releasedDate),
              const SizedBox(height: 15),
              Visibility(
                  visible: tvShow.directors.isNotEmpty,
                  child:
                      _subtitleInfo(AppLocalizations.of(context)!.directors)),
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Wrap(
                  spacing: 5,
                  runSpacing: 5,
                  children: _showDirectors(tvShow),
                ),
              ),
              Visibility(
                  visible: tvShow.genres.isNotEmpty,
                  child: _subtitleInfo(AppLocalizations.of(context)!.genres)),
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Wrap(
                  spacing: 5,
                  runSpacing: 5,
                  children: _showGenres(tvShow),
                ),
              ),
              Visibility(
                  visible: tvShow.platforms.isNotEmpty,
                  child:
                      _subtitleInfo(AppLocalizations.of(context)!.platforms)),
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Wrap(
                  spacing: 5,
                  runSpacing: 5,
                  children: _showPlatforms(tvShow),
                ),
              ),
              Visibility(
                  visible: tvShow.platforms.isNotEmpty,
                  child: _subtitleInfo(AppLocalizations.of(context)!.country)),
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Wrap(
                  spacing: 5,
                  runSpacing: 5,
                  children: _showCountries(tvShow),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _subtitleInfo(String titulo) {
  return Text(
    titulo,
    style: const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold,
    ),
  );
}

List<TextBgRoundedFill> _showDirectors(TVShow tvShow) {
  List<TextBgRoundedFill> directors = [];
  for (var element in tvShow.directors) {
    directors.add(TextBgRoundedFill(
      text: element.name,
      fontSize: 14,
      backgroundColor: AppColors.azulTenue.withOpacity(0.8),
      altura: 30,
      paddingLateral: 10,
      textColor: Colors.white,
    ));
  }
  return directors;
}

List<TextBgRoundedFill> _showGenres(TVShow tvShow) {
  List<TextBgRoundedFill> genres = [];
  for (var element in tvShow.genres) {
    genres.add(TextBgRoundedFill(
      text: element.name,
      fontSize: 14,
      backgroundColor: AppColors.turquesa,
      altura: 30,
      paddingLateral: 10,
      textColor: AppColors.grisOscuro,
    ));
  }
  return genres;
}

List<TextBgRoundedFill> _showPlatforms(TVShow tvShow) {
  List<TextBgRoundedFill> platforms = [];
  for (var element in tvShow.platforms) {
    platforms.add(TextBgRoundedFill(
      text: element.name,
      fontSize: 14,
      backgroundColor: AppColors.azulTenue.withOpacity(0.8),
      altura: 30,
      paddingLateral: 10,
      textColor: Colors.white,
    ));
  }
  return platforms;
}

List<TextBgRoundedFill> _showCountries(TVShow tvShow) {
  List<TextBgRoundedFill> countries = [];
  for (var element in tvShow.originCountry) {
    countries.add(TextBgRoundedFill(
      text: element,
      fontSize: 14,
      backgroundColor: AppColors.turquesa,
      altura: 30,
      paddingLateral: 10,
      textColor: AppColors.grisOscuro,
    ));
  }
  return countries;
}
