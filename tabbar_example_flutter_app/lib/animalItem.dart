import 'package:flutter/material.dart';

class Animal{
  String? imagePath; // 동물 이미지 경로
  String? animalName; // 동물 이름
  String? kind; //동물 종류
  bool? flyExist = false; //날 수 있는지. false -> 기본값. 새로운 Animal 객체를 선언할 때 이를 입력받음.

  Animal( //클래스의 생성자(constructor)
  {
    required this.animalName, //@required 애너테이션은 함수를 호출할 때 곡 전달해야 하는 값이라는 뜻.
    required this.kind,
    required this.imagePath,
    this.flyExist});
}
