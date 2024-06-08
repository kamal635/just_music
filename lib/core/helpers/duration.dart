extension DurationExtensions on Duration {
  String toFormattedStringWithHours() {
    return '${inHours}h ${inMinutes.remainder(60)}m ${(inSeconds.remainder(60))}s';
  }

  String toFormattedStringWithoutHours() {
    return '${inMinutes.remainder(60)}m ${(inSeconds.remainder(60))}s';
  }
}
