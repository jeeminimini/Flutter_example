import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tabbar_example_flutter_app/animalItem.dart';

class SecondApp extends StatefulWidget {
  List<Animal>? list;
  SecondApp({Key? key, @required this.list}): super(key:key);

  @override
  State<StatefulWidget> createState() =>_SecondApp();


}

class _SecondApp extends State<SecondApp>{
  final nameController = TextEditingController(); //nameController를 사용하기 위해 final로 선언.
  int _radioValue=0; //라디오 버튼을 위해서.
  bool flyExist = false; //날 수 있는지.
  var _imagePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[//대괄호 안에 위젯 담는다.
                  TextField(  //사용자가 동물 이름을 입력할 텍스트필드.
                    controller: nameController,
                    keyboardType: TextInputType.text, //키보드 유형은 텍스트.
                    maxLines: 1,
                  ),
                  Row( //위젯 가로로 배치
                    children: <Widget>[ //라디오 버튼 만들기. value는 인덱스값, groupValue는 그룹화(같은 그룹에서 하나만 선택 가능), onChanged는 이벤트 처리.
                      Radio(value: 0,groupValue: _radioValue,onChanged: _radioChange),
                      Text('양서류'),
                      Radio(value: 1, groupValue: _radioValue, onChanged: _radioChange),
                      Text('파충류'),
                      Radio(value: 2, groupValue: _radioValue, onChanged: _radioChange),
                      Text('포유류'),
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceAround),// 양쪽 여백 사이에 규일하게 배치.
                  Row(
                    children: <Widget>[
                      Text('날 수 있나요?'),
                      Checkbox( // 날 수 있는지 체크 박스.
                        value: flyExist,
                        onChanged: (bool? check){
                          setState(() {
                            flyExist = check!;
                          });
                      })
                    ],
                      mainAxisAlignment: MainAxisAlignment.spaceAround),
                  Container(//이미지 선택하는 영역.
                    height: 100,
                    child: ListView(
                        scrollDirection: Axis.horizontal, //리스트뷰를 가로로 변경.
                      children: <Widget>[
                        GestureDetector(
                          child: Image.asset('repo/images/cow.png',width:80),
                          onTap: (){
                            _imagePath = 'repo/images/cow.png';
                          },
                        ),
                        GestureDetector(
                          child: Image.asset('repo/images/pig.png',width:80),
                          onTap: (){
                            _imagePath = 'repo/images/pig.png';
                          },
                        ),
                        GestureDetector(
                          child: Image.asset('repo/images/bee.png',width:80),
                          onTap: (){
                            _imagePath = 'repo/images/bee.png';
                          },
                        ),
                        GestureDetector(
                          child: Image.asset('repo/images/cat.png',width:80),
                          onTap: (){
                            _imagePath = 'repo/images/cat.png';
                          },
                        ),
                        GestureDetector(
                          child: Image.asset('repo/images/fox.png',width:80),
                          onTap: (){
                            _imagePath = 'repo/images/fox.png';
                          },
                        ),
                        GestureDetector(
                          child: Image.asset('repo/images/monkey.png',width:80),
                          onTap: (){
                            _imagePath = 'repo/images/monkey.png';
                          },
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                      child: Text('동물 추가하기'),
                      onPressed: (){
                        var animal = Animal(
                          animalName: nameController.value.text,
                          kind: getKind(_radioValue),
                          imagePath: _imagePath,
                          flyExist: flyExist);
                        AlertDialog dialog = AlertDialog( //알림창 띄우기
                          title: Text('동물 추가하기'),
                          content: Text(
                            '이 동물은 ${animal.animalName} 입니다. 또 동물의 종류는 ${animal.kind}입니다.\n이 동물을 추가하시겠습니까?',
                            style: TextStyle(fontSize: 30.0),
                          ),
                          actions: [
                            ElevatedButton(onPressed: (){
                              widget.list?.add(animal);
                              Navigator.of(context).pop();
                            }, child: Text('예'),
                            ),
                            ElevatedButton(onPressed: (){
                              Navigator.of(context).pop();
                            }, child: Text('아니요'),
                            ),
                          ],
                        );
                        showDialog(context: context, builder: (BuildContext context)=>dialog);
                      }),
                ],
              )
            )
        )
    );
  }
  _radioChange(int? value){
    setState(() {
      _radioValue = value!;
    });
  }
  getKind(int radioValue){
    switch (radioValue){
      case 0:
        return "양서류";
      case 1:
        return "파충류";
      case 2:
        return "포유류";
    }
  }
}