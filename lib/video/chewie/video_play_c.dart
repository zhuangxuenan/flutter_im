import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class VideoDemo extends StatefulWidget {
  @override
  _VideoDemoState createState() => _VideoDemoState();
}

class _VideoDemoState extends State<VideoDemo> {
  VideoPlayerController _videoPlayerController1;
  ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _videoPlayerController1 = VideoPlayerController.network(
        'http://vjs.zencdn.net/v/oceans.mp4');
    _chewieController = ChewieController(
      ///要播放的视频的控制器最终视频播放器控制器视频播放器控制器
      videoPlayerController: _videoPlayerController1,
      aspectRatio: _videoPlayerController1.value.aspectRatio,
      ///显示后立即播放视频
      autoPlay: true,
      ///视频是否循环
      looping: false,
      // Try playing around with some of these other options:
      ///是否显示控制器
      showControls: true,
      ///定义按下Play时播放器是否全屏启动
      fullScreenByDefault:false,
      ///定义是否应显示全屏控件
      allowFullScreen:true,
      ///定义是否应显示静音控件
      allowMuting: true,
      ///用于材质进度条的颜色。默认情况下，材质播放器使用主题中的颜色。
      materialProgressColors: ChewieProgressColors(
        playedColor: Color.fromRGBO(255, 255, 255, 0.85),
        handleColor: Color.fromRGBO(255, 255, 255, 0.85),
        backgroundColor: Color.fromRGBO(1, 1, 1, 0.35),
        bufferedColor: Color(0x80000000),
      ),
      //在初始化之前，占位符显示在视频下方或播放完之后。
      placeholder: Container(
        color: Colors.grey,
      ),
      ///启动时初始化视频。这将使视频做好播放准备。
      autoInitialize: true,
    );
  }

  @override
  void dispose() {
    _videoPlayerController1.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Video Demo',
      home: new Scaffold(
        appBar: AppBar(
          title: Text("视频播放"),
        ),
        body: new Center(
          child: Chewie(
            controller: _chewieController,
          ),
        ),
      ),
    );
  }
}
