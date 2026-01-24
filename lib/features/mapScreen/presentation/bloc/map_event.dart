
abstract class MapEvent {}

class ViewportChanged extends MapEvent{
  final double north, south, east, west;

  ViewportChanged({
    required this.north,
    required this.south,
    required this.east,
    required this.west,
  });

}
