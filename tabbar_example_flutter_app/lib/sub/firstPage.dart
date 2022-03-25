import 'package:flutter/material.dart';
import 'package:tabbar_example_flutter_app/animalItem.dart';

class FirstApp extends StatelessWidget {
  final List<Animal>? list; //Animal list 선언. final은 변경 불가.
  FirstApp({Key? key, this.list}): super(key:key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child : Center(
          child: ListView.builder(itemBuilder: (context,position){//ListView.builder는 리스트뷰를 위젯으로 만들기. itemBuilder는 BuildContext와 int를 반환함.
            // BuildContext는 위젯 트리에서 위젯의 위치를 알려주고 int는 아이템의 순번을 의미함.
            //position은 리스트에서 아이템의 위치를 나타냄.
            return GestureDetector( // 터치 이벤트. 손가락 제스처와 관련한 많은 이벤트를 처리함.
              child: Card(//이 부분에 위젯을 이용해 데이터를 표시. 동물 이름을 출력하는 코드
              child: Row(
                children: <Widget>[
                  Image.asset(
                    list![position].imagePath!,
                    height: 100,
                    width: 100,
                    fit: BoxFit.contain,
                  ),
                  Text(list![position].animalName!)
                ],
              ),
              ),
              onTap: (){
                AlertDialog dialog = AlertDialog( //dialog라는 이름의 알림 창 만들기.
                  //내용과 스타일을  content와 style로 설정.
                  content: Text(
                    '이 동물은 ${list![position].kind}입니다',
                    style: TextStyle(fontSize: 30.0),
                  ),
                );
                showDialog(context: context, builder: (BuildContext context)=>dialog); // showDialog() 함수를 이용해 알림 창 띄움.
              },
            );
          },
            itemCount: list!.length),//아이템 개수만큼만 스크롤 할 수 있게 제한
        )
      )
    );
  }
}