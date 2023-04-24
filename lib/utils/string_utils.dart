class StringUtils {
  static List<String?> getHashTags(String title) {
    RegExp exp = new RegExp(r"\B#\w\w+");
    exp.allMatches(title).forEach((match) {
      print(match.group(0));
    });
    return exp.allMatches(title).map((e) => e.group(0)).toList();
  }
}
