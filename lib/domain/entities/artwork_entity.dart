class Artwork{
  String uploaderEmail;
  dynamic artworkImage;
  String? artistNationality;
  String? material;
  String? timePeriod;

  Artwork({required this.uploaderEmail, required this.artworkImage, this.artistNationality, this.material,
  this.timePeriod});
}