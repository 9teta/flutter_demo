
import 'dart:developer';

import 'package:faker/faker.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_shop_demo/model/ClosedModel.dart';

class RepoInitializer {
  final hatImages = <AssetImage>[];
  final shirtImages = <AssetImage>[];
  final shoeImages = <AssetImage>[];

  final faker = Faker();

  final Map<String, Set<Product>> mapNameOfGroupToProducts = <String, Set<Product>>{};

  Map<String, Set<Product>> generateAll() {
    loadAssetImages();
    generateProductsAndFillWithImages(["hat","shirt","shoe"], [hatImages,shirtImages,shoeImages]);
    log(mapNameOfGroupToProducts.length.toString());
    return mapNameOfGroupToProducts;
  }

  void loadAssetImages() {
    const imagesFolderPath = 'assets/images/';
    for (int i = 0; i < 15; i++) {
      final fullPath = collectFullAssetPath(imagesFolderPath, "hat", i);
      final hatImage = AssetImage(fullPath);
      hatImages.add(hatImage);
    }
    for (int i = 0; i < 15; i++) {
      final fullPath = collectFullAssetPath(imagesFolderPath, "shoe", i);
      final shoeImage = AssetImage(fullPath);
      shoeImages.add(shoeImage);
    }
    for (int i = 0; i < 15; i++) {
      final fullPath = collectFullAssetPath(imagesFolderPath, "shirt", i);
      final shirtImage = AssetImage(fullPath);
      shirtImages.add(shirtImage);
    }
  }

  String collectFullAssetPath(String imagesFolderPath, String imageName, int number) {
    return "${imagesFolderPath}${imageName}s/${imageName}_${number}_phone.jpg";
  }

  void generateProductsAndFillWithImages(List<String> nameOfGroups, List<List<AssetImage>> groupedImages) {
    for (int groupIdx = 0; groupIdx < nameOfGroups.length; groupIdx ++) {
      final nameOfGroup = nameOfGroups[groupIdx];
      final assetImages = groupedImages[groupIdx];
      final setOfProducts = <Product>{};
      for (int imageIdx = 0; imageIdx < assetImages.length; imageIdx++) {
        final id = groupIdx * 100 + imageIdx;
        final name = faker.color.color() + " " + faker.job.title();
        final price = faker.randomGenerator.decimal(scale: 50);
        final description = faker.lorem.sentences(10);
        final assetImage = assetImages[imageIdx];
        final Product product = Product(id, name, price, description, assetImage: assetImage, group: nameOfGroup);
        setOfProducts.add(product);
      }
      mapNameOfGroupToProducts[nameOfGroup] = setOfProducts;
    }
  }


}