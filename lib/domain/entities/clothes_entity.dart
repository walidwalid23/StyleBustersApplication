class UploadedClothes{
  dynamic clothesImage;
  String gender;

  UploadedClothes({required this.clothesImage, required this.gender});
}

class RetrievedClothes{
  String imageURL;
  String productName;
  String productPrice;
  String productURL;

  RetrievedClothes({required this.imageURL, required this.productName, required this.productPrice,
    required this.productURL});
}
