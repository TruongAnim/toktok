class AudioDetails {
  final String image;
  final String title;
  final String subtitle;

  AudioDetails(this.image, this.title, this.subtitle);

  @override
  String toString() {
    // TODO: implement toString
    return '$title - $subtitle';
  }
}
