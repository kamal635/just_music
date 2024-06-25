extension DurationExtensions on Duration {
  // if duration contain hours use this with show Character [h : hours , m: minute , s : second]
  String toFormattedStringWithHoursWithCharacter() {
    return '${inHours}h ${inMinutes.remainder(60)}m ${(inSeconds.remainder(60))}s';
  }

  // if duration doesnt contain hours use this with show Character [ m: minute , s : second]
  String toFormattedStringWithoutHoursWithCharacter() {
    return '${inMinutes.remainder(60)}m ${(inSeconds.remainder(60))}s';
  }

// if duration contain hours use this without Character
  String toFormattedStringWithHoursWithoutCharacter() {
    return '${inHours.remainder(60).toString().padLeft(2, "0")}: ${(inMinutes.remainder(60).toString().padLeft(2, "0"))}  ${(inSeconds.toString().padLeft(2, "0"))}';
  }

  // if duration doesnt contain hours use this without Character
  String toFormattedStringWithoutHoursWithoutCharacter() {
    return '${(inMinutes.remainder(60).toString().padLeft(2, "0"))} : ${(inSeconds.remainder(60).toString().padLeft(2, "0"))}';
  }
}
