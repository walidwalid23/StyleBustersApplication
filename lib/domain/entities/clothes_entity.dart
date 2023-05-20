class UploadedClothes{
  dynamic clothesImage;
  String gender;
  // class name in case of multiple objects in the uploaded image
  String? className;

  UploadedClothes({required this.clothesImage, required this.gender, this.className});
}

class RetrievedClothes{
  String imageURL;
  String productName;
  String productPrice;
  String productURL;

  RetrievedClothes({required this.imageURL, required this.productName, required this.productPrice,
    required this.productURL});
}

class ClothesPagination {
  List<RetrievedClothes> retrievedClothes;
  bool fetchingLoading;

  ClothesPagination({required this.retrievedClothes,
    required this.fetchingLoading, });

  ClothesPagination copyWith({List<RetrievedClothes>? newClothes,  bool? newFetchingLoading}){
    //IF THE USER UPDATED VALUES OF ATTRIBUTES PUT THEM. IF HE LEFT THEM NULL PUT THE EXISTING VALUES
    return ClothesPagination(retrievedClothes: newClothes?? retrievedClothes,
        fetchingLoading: newFetchingLoading ?? fetchingLoading,
);


  }


}



