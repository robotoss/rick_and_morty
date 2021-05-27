double setAvatarOpacity(double shrinkOffset, double expandedHeight) {
  final opacity = 1 - shrinkOffset / (expandedHeight / 3);
  return opacity >= 0 ? opacity : 0;
}
