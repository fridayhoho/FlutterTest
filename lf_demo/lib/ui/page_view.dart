import 'package:flutter/material.dart';
import 'dart:async';
class DisplayPage extends StatefulWidget {
  @override
  _DisplayPageState createState() => new _DisplayPageState();
}

class _DisplayPageState extends State<DisplayPage> with WidgetsBindingObserver, SingleTickerProviderStateMixin{
  //=============banner ============
  bool _isAddGradient = false;
  final int imgCounts = 5;
  var timer;
  int curShowIndex = 0;
  PageController _pageController = new PageController(viewportFraction: 0.85);
  Duration duration = new Duration(milliseconds: 500);
  // =============bottom tab==========
//定义底部导航项目
  final List<Tab> _bottomTabs = <Tab>[
    new Tab(text: '首页',icon: new Icon(Icons.home),),    //icon和text的显示顺序已经内定，如需自定义，到child属性里面加吧
    new Tab(icon: new Icon(Icons.mail),text: '消息',),
    // new Tab(icon: new Icon(Icons.people),text: '邻里',),
    new Tab(icon: new Icon(Icons.photo),text: '发现',),
    new Tab(icon: new Icon(Icons.pie_chart),text: '我的',),
  ];

  //定义底部导航Tab
  TabController _bottomNavigation;


  @override
  void initState() {
    super.initState();
    // void callback
    WidgetsBinding.instance.addObserver(this);
    print('---initstate'); 
    timer = new Timer.periodic(new Duration(seconds: 2), (Timer timer){
      var date = new DateTime.now().millisecondsSinceEpoch;
      
      // print(date.toString()+' $date'); 
      print('curshowIndex: $curShowIndex');
      curShowIndex += 1;
      if (curShowIndex >= imgCounts) {
                curShowIndex = 0;
              }
      _pageController.animateToPage(curShowIndex, duration:duration, curve: Curves.decelerate);
    });
    
    _bottomNavigation = new TabController(
      vsync: this,    //动画处理参数
      length: _bottomTabs.length    //控制Tab的数量
      );   //底部主导航栏控制器
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    print('deactivate');
  }
  
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print('state:$state');
    if (state == AppLifecycleState.paused) {
      timer.cancel();
    }else if(state == AppLifecycleState.resumed){
      // timer.resume();
    }
  }
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
    print('dispose');
    timer.cancel();
    _bottomNavigation.dispose();
  }
  ///@override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildPageView(context),
      appBar: new AppBar(
            backgroundColor: Colors.lightBlue,
            title: new Text('阳光100分'),
          ),   //头部的标题AppBar
      drawer: buildDrawer(),
      bottomNavigationBar: new Material(
            color: Colors.lightBlue,   //底部导航栏主题颜色
            child: new TabBar(
              controller: _bottomNavigation,
              tabs: _bottomTabs,
              indicatorColor: Colors.white, //tab标签的下划线颜色
            ),
    )
    );
  }
  Widget buildDrawer(){
    return new Drawer(     //侧边栏按钮Drawer
            child: new ListView(
              children: <Widget>[
                new UserAccountsDrawerHeader(   //Material内置控件
                  accountName: new Text('格列兹曼'), //用户名
                  accountEmail: new Text('example@126.com'),  //用户邮箱
                  currentAccountPicture: new GestureDetector( //用户头像
                    onTap: () => print('current user'),
                    child: new CircleAvatar(    //圆形图标控件
                      backgroundImage: new ExactAssetImage('assetss/1.png'),
                       
                    ),
                  ),
                  // otherAccountsPictures: <Widget>[    //粉丝头像
                  //   new GestureDetector(    //手势探测器，可以识别各种手势，这里只用到了onTap
                  //     onTap: () => print('other user'), //暂且先打印一下信息吧，以后再添加跳转页面的逻辑
                  //     child: new CircleAvatar(
                  //       backgroundImage: new NetworkImage('https://upload.jianshu.io/users/upload_avatars/10878817/240ab127-e41b-496b-80d6-fc6c0c99f291?imageMogr2/auto-orient/strip|imageView2/1/w/240/h/240'),
                  //     ),
                  //   ),
                  //   new GestureDetector(
                  //     onTap: () => print('other user'),
                  //     child: new CircleAvatar(
                  //       backgroundImage: new NetworkImage('https://upload.jianshu.io/users/upload_avatars/8346438/e3e45f12-b3c2-45a1-95ac-a608fa3b8960?imageMogr2/auto-orient/strip|imageView2/1/w/240/h/240'),
                  //       ),
                  //   ),
                  // ],
                  decoration: new BoxDecoration(    //用一个BoxDecoration装饰器提供背景图片
                    color: Colors.lightBlue
                    // image: new DecorationImage(
                    //   fit: BoxFit.fill,
                    //   // image: new NetworkImage('https://raw.githubusercontent.com/flutter/website/master/_includes/code/layout/lakes/images/lake.jpg')
                    //   //可以试试图片调取自本地。调用本地资源，需要到pubspec.yaml中配置文件路径
                    //   image: new ExactAssetImage('assetss/1.png'),
                    // ),
                  ),
                ),
                new ListTile(   //第一个功能项
                  title: new Text('账户明细'),
                  trailing: new Icon(Icons.arrow_upward),
                  onTap: () {
                    Navigator.of(context).pop();
                    // Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new SidebarPage('First Page')));
                  }
                ),
                new ListTile(   //第二个功能项
                  title: new Text('车位配置'),
                  trailing: new Icon(Icons.arrow_right),
                  onTap: () {
                    Navigator.of(context).pop();
                    // Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new SidebarPage('Second Page')));
                  } 
                ),
                new ListTile(   //第二个功能项
                  title: new Text('租金历史'),
                  trailing: new Icon(Icons.arrow_right),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pushNamed('/a');
                  } 
                ),
                new Divider(),    //分割线控件
                new ListTile(   //退出按钮
                  title: new Text('关闭菜单'),
                  trailing: new Icon(Icons.cancel),
                  onTap: () => Navigator.of(context).pop(),   //点击后收起侧边栏
                ),
              ],
            ),
          );
  }
  Widget buildPageView(BuildContext context){
    return Padding(
        padding: new EdgeInsets.only(top: 0.0),
        child: SizedBox.fromSize(
          size: Size.fromHeight(200.0),
          child: PageView.builder(
            controller: _pageController,
            itemCount: imgCounts,
            itemBuilder: (BuildContext context, int index) {
              // curShowIndex = index;
              return Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 2.0,
                  horizontal: 5.0,
                ),
                child: GestureDetector(
                  onTap: () {
                    Scaffold.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.lightGreen,
                          duration: Duration(milliseconds: 800),
                          content: Center(
                            child: Text(
                              '开发中',
                              style: TextStyle(fontSize: 25.0),
                            ),
                          ),
                        ));
                  },
                  child: Material(
                    elevation: 2.0,
                    borderRadius: BorderRadius.circular(3.0),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.asset(
                          'assetss/a' + (index+1).toString() + '.jpg',
                          fit: BoxFit.cover,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      );
  }
}
