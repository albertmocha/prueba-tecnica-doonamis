import 'package:flutter/material.dart';
import '../classes/tv_show.dart';
import '../global/global.dart';
import '../utils/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TVShowLine extends StatelessWidget {
  final TVShow tvShow;
  const TVShowLine({
    Key? key,
    required this.tvShow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(22, 0, 12, 16),
      child: Container(
        padding: const EdgeInsets.only(top: 16),
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(color: AppColors.gris, width: 1),
          ),
        ),
        child: Row(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                tvShow.imgPath != ''
                    ? _ImagePosterShow(imgPath: tvShow.imgPath)
                    : const _DefaultImg(),
                _ShowScore(score: tvShow.score)
              ],
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _ShowTitle(title: tvShow.name),
                  const SizedBox(height: 5),
                  _ReleasedDate(releasedDate: tvShow.releasedDate),
                  const SizedBox(height: 5),
                  _Popularity(popularityScore: tvShow.popularity),
                  const SizedBox(height: 5),
                  _DescriptionTVShow(overview: tvShow.overview)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _DefaultImg extends StatelessWidget {
  const _DefaultImg({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.asset(
          'assets/defaultImg.png',
          width: 140,
          height: 160,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _DescriptionTVShow extends StatelessWidget {
  final String overview;
  const _DescriptionTVShow({
    Key? key,
    required this.overview,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      overview,
      style: const TextStyle(
        fontSize: 11,
      ),
      maxLines: 4,
      overflow: TextOverflow.ellipsis,
      softWrap: false,
    );
  }
}

class _Popularity extends StatelessWidget {
  final double popularityScore;
  const _Popularity({
    Key? key,
    required this.popularityScore,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          popularityScore.toString(),
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 12,
            color: AppColors.grisOscuro,
          ),
        ),
        const SizedBox(width: 3),
        const Icon(
          Icons.person,
          color: AppColors.grisOscuro,
          size: 17,
        )
      ],
    );
  }
}

class _ReleasedDate extends StatelessWidget {
  final String releasedDate;
  const _ReleasedDate({
    Key? key,
    required this.releasedDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '${AppLocalizations.of(context)!.released_date}:',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
        const SizedBox(width: 5),
        Text(
          releasedDate,
          style: const TextStyle(
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

class _ShowTitle extends StatelessWidget {
  final String title;
  const _ShowTitle({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.turquesa,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Text(
          title,
          style: const TextStyle(
            color: AppColors.azulFuerte,
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

class _ImagePosterShow extends StatelessWidget {
  final String imgPath;
  const _ImagePosterShow({
    Key? key,
    required this.imgPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(
          '${Global.urlPoster}$imgPath',
          width: 140,
          height: 160,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _ShowScore extends StatelessWidget {
  final double score;
  const _ShowScore({
    Key? key,
    required this.score,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: -17,
      left: -27,
      child: SizedBox(
        width: 60,
        height: 60,
        child: Row(
          children: [
            const Spacer(),
            Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  '$score',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
