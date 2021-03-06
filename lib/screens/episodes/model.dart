import 'package:rick_and_morty/data/api/models/list_episodes_model.dart';

class EpisodesBySeasonsModel {
  final int season;
  final List<Episode> episodes;

  EpisodesBySeasonsModel({
    required this.season,
    required this.episodes,
  });
}
