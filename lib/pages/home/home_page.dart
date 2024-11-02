import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:fq/route/RoutePages.dart';
import 'package:get/get.dart';
import '../../route/RouteNames.dart';
import '../../utils/images_utils.dart';
import 'home_logic.dart';

// 远程图片列表
const List<String> imageUrls = [
  'https://ts1.cn.mm.bing.net/th/id/R-C.60709a750a17a1e71508013fbdbe02b1?rik=Nyo0laGwtyHh5A&riu=http%3a%2f%2fimg.netbian.com%2ffile%2f2023%2f1009%2f154725fDlbG.jpg&ehk=De1OrFEmBnOAN87uMPPXMjUkisPVD7sRgff1oXADvuA%3d&risl=&pid=ImgRaw&r=0',
  'https://ts1.cn.mm.bing.net/th/id/R-C.6fbaf38efbd985a4bee9fde5a62b3bb7?rik=a1MfAJGAN%2bZK4Q&riu=http%3a%2f%2fimg.netbian.com%2ffile%2f2024%2f0125%2f010813rQ3kM.jpg&ehk=ZVG8arGy45cjfenrB081WJkBR2RYl9Pj7LfuTkgvmkA%3d&risl=&pid=ImgRaw&r=0',
  'https://img-baofun.zhhainiao.com/pcwallpaper_ugc/static/dc6c8c5dc7d28a88f6506396161bcd13.jpg?x-oss-process=image%2fresize%2cm_lfit%2cw_3840%2ch_2160',
];

// 本地资源图片列表
List<String> assetImages = [
  ImageUtils.getImagePath('e18'),
  ImageUtils.getImagePath('e17'),
  ImageUtils.getImagePath('e19'),
];

// 网页链接和标题
const List<String> ImageUrls = [
  'https://www.baidu.com/',
  'https://www.google.com/',
  'https://www.bing.com/',
];
const List<String> titles = ['百度', '谷歌', '必应'];
const List<String> routenames = ['米线', '答题', '设置'];

class Home_Page extends StatefulWidget {
  const Home_Page({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<Home_Page> {
  int _currentTitleIndex = 0; // 当前标题索引
  int _currentRouteIndex = 0; // 当前路由索引

  // 标题索引变化时调用
  void _onIndexTitleChanged(int index) {
    setState(() {
      _currentTitleIndex = index;
    });
  }

  // 路由索引变化时调用
  void _onIndexRouteChanged(int index) {
    setState(() {
      _currentRouteIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Get.put(HomeLogic()); // 初始化 HomeLogic 控制器

    return Scaffold(
      appBar: AppBar(
        title: const Text('首页'), // 设置应用栏标题
      ),
      body: ListView(
        children: [
          // 第一个 Swiper 组件，显示远程图片
          SizedBox(
            height: 300,
            child: Stack(
              children: [
                Swiper(
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        // 点击图片时导航到 WebView 页面
                        Get.toNamed(RouteNames.webView, arguments: ImageUrls[index]);
                      },
                      child: Image.network(
                        imageUrls[index],
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Center(
                          child: Icon(Icons.error), // 加载失败时显示错误图标
                        ),
                      ),
                    );
                  },
                  itemCount: imageUrls.length,
                  pagination: const SwiperPagination(
                      alignment: Alignment.bottomRight), // 分页控件位置
                  control: const SwiperControl(), // 控制器
                  autoplay: true, // 自动播放
                  autoplayDelay: 3000, // 自动播放延迟
                  onIndexChanged: _onIndexTitleChanged, // 监听索引变化
                ),
                // 标题展示
                Positioned(
                  bottom: 16,
                  left: 16,
                  right: 16,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7), // 半透明黑色背景
                      borderRadius: BorderRadius.circular(8), // 圆角
                    ),
                    child: Text(
                      (_currentTitleIndex < titles.length) ? titles[_currentTitleIndex] : '没有标题',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // 第二个 Swiper 组件，显示本地资源图片
          SizedBox(
            height: 300,
            child: Stack(
              children: [
                Swiper(
                  layout: SwiperLayout.STACK, // 使用堆叠布局
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        // 点击不同图片时导航到不同页面
                        if (index == 0) {
                          Get.toNamed(RouteNames.question);
                        }
                        if (index == 1) {
                          Get.toNamed(RouteNames.setting);
                        }
                        if (index == 2) {
                          Get.toNamed(RouteNames.home);
                        }
                      },
                      child: Image.asset(
                        assetImages[index],
                        fit: BoxFit.cover,
                        width: 100,
                        height: 100,
                      ),
                    );
                  },
                  itemWidth: 300,
                  itemHeight: 300,
                  itemCount: assetImages.length,
                  pagination: const SwiperPagination(
                    builder: DotSwiperPaginationBuilder(
                      size: 2.0, // 点的大小
                      activeSize: 15.0, // 活动点的大小
                      color: Colors.black54, // 点的颜色
                      activeColor: Colors.blue, // 活动点的颜色
                    ),
                  ),
                  control: const SwiperControl(), // 控制器
                  autoplay: true, // 自动播放
                  autoplayDelay: 3000, // 自动播放延迟
                  onIndexChanged: _onIndexRouteChanged, // 监听索引变化
                ),
                // 路由标题展示
                Positioned(
                  bottom: 16,
                  left: 16,
                  right: 16,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7), // 半透明黑色背景
                      borderRadius: BorderRadius.circular(8), // 圆角
                    ),
                    child: Text(
                      (_currentRouteIndex < routenames.length) ? routenames[_currentRouteIndex] : '没有标题',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      // 侧边栏菜单
      drawer: Drawer(
        child: ListView(
          children: [
            // 侧边菜单项
            ListTile(
              leading: Icon(Icons.home),
              title: Text('首页'),
              onTap: () {
                Get.offNamed(RouteNames.welcome); // 导航到欢迎页面
              },
            ),
            ListTile(
              leading: Icon(Icons.question_mark),
              title: Text('答题'),
              onTap: () {
                Get.offAndToNamed(RouteNames.question); // 导航到答题页面
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('设置'),
              onTap: () {
                Get.offNamed(RouteNames.setting); // 导航到设置页面
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('个人中心'),
              onTap: () {
                Get.toNamed(RouteNames.use); // 导航到个人中心
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('退出'),
              onTap: () {
                Get.offNamed(RouteNames.welcome); // 导航到欢迎页面
              },
            ),
          ],
        ),
      ),
    );
  }
}
