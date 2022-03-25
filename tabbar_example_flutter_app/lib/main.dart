import 'package:flutter/material.dart';
import 'package:tabbar_example_flutter_app/animalItem.dart';
import 'package:tabbar_example_flutter_app/cupertinoMain.dart';
import 'package:tabbar_example_flutter_app/sub/firstPage.dart';
import 'package:tabbar_example_flutter_app/sub/secondPage.dart';

void main() {
  runApp(CupertinoMain());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
  with SingleTickerProviderStateMixin{ //singleTickerProviderStateMixin 클래스를 추가 상속하여 탭을 눌렀을 때 _MyHomePageState 클래스에서 애니메이션 동작을 처리할 수 있게 함.
  //만일 이 클래스를 상속에 포함하지 않으면 _MyHomePageState 클래스에서 탭 컨트롤러를 만들 수 없으므로 주의 필요.
  TabController? controller; //?는 해당 변수가 null이 될 수 있음
  List<Animal> animalList = new List.empty(growable: true); // 동물 정보를 담을 List. 처음엔 빈 값이므로 List.empty(growable:true)로 선언. growable은 이 리스트가 가변적으로 증가할 수 있다는 것을 의미.

  @override
  void initState() { //초기화. 해당 위젯이 로드 될때 필요한 초기화를 진행함. 빌드 이전에 한번만 실행됨.
    super.initState();
    controller=TabController(length: 2, vsync: this); //length는 몇개의 탭을 만들지. vsync는 탭이 이동했을 때 호출되는 콜백 함수를 어디서 처리할지 지정.

    animalList.add(Animal(animalName: "벌",kind: "곤충", imagePath: "repo/images/bee.png")); //add는 리스트에 값 추가.
    animalList.add(Animal(animalName: "고양이",kind: "포유류", imagePath: "repo/images/cat.png"));
    animalList.add(Animal(animalName: "젖소",kind: "포유류", imagePath: "repo/images/cow.png"));
    animalList.add(Animal(animalName: "강아지",kind: "포유류", imagePath: "repo/images/dog.png"));
    animalList.add(Animal(animalName: "여우",kind: "포유류", imagePath: "repo/images/fox.png"));
    animalList.add(Animal(animalName: "원숭이",kind: "영장류", imagePath: "repo/images/monkey.png"));
    animalList.add(Animal(animalName: "돼지",kind: "포유류", imagePath: "repo/images/pig.png"));
    animalList.add(Animal(animalName: "늑대",kind: "포유류", imagePath: "repo/images/wolf.png"));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Listview Example'),
      ),
      body: TabBarView(
        children: <Widget>[FirstApp(list: animalList), SecondApp(list: animalList)],
        controller: controller,
      ),
      bottomNavigationBar: TabBar(tabs: <Tab>[
        Tab(icon: Icon(Icons.looks_one, color: Colors.blue),),
        Tab(icon: Icon(Icons.looks_two, color: Colors.blue),)
    ], controller: controller,
    ),
    );
  }
  @override
  void dispose() { //Stateful 생명주기에서 위젯의 상태 관리를 완전히 끝내는(State 객체 소멸) 함수. Stateful이 마지막에 호출하는 함수임.
    // 탭 컨트롤러는 애니메이션을 이용하므로 dispose() 함수를 호출해 주어야 메모리 누수를 막을 수 있음.
    controller?.dispose(); //!는 null을 절대 가지지 않을 경우임. null일 경우 exception을 일으킴.
    super.dispose(); //super는 부모클래스. this는 자기자신(자식클래스)를 지칭.
  }
}
