 toMinutes(int seconds) {
    final hours = (seconds / 3600).floor();
    final minutes = (seconds / 60).floor();
    final restSeconds = (seconds % 60).floor();
    return "${hours > 1 ? "$hours:" : ""}${minutes < 10 ? 0 : ""}$minutes:${restSeconds < 10 ? 0 : ""}$restSeconds";
  }