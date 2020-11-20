class Track {
  final String artistName;
  final String trackName;
  final String albumName;

  Track({this.artistName, this.trackName, this.albumName});

  @override
  String toString() {
    return trackName + " - " + artistName + " - " + albumName;
  }
}
