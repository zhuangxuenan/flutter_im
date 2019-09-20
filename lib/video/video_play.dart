import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
/**
 * https://media.w3.org/2010/05/sintel/trailer.mp4
 * http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4
 * http://vjs.zencdn.net/v/oceans.mp4
 * https://media.w3.org/2010/05/sintel/trailer.mp4
 * */
class VideoApp extends StatefulWidget {
  @override
  _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoApp> {
  VideoPlayerController _controller;
  bool _isPlaying = false;
  String url = "https://media.w3.org/2010/05/sintel/trailer.mp4";

  /**
   *initialize() - 初始化播放器。
   *dispose() - 释放播放器资源。
   *notifyListeners() - 监听播放消息。
   *addListener(listener) - 添加监听器。
   *removeListener(listener) - 移除监听器。
   *pause() - 暂停播放。
   *play() - 开始播放。
   *position - 播放位置。
   *seekTo(moment) - 指定到某个位置播放。
   *setLooping(looping) - 是否循环播放。
   */
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(this.url)
      // 播放状态
      ..addListener(() {
        final bool isPlaying = _controller.value.isPlaying;
        if (isPlaying != _isPlaying) {
          setState(() {
            _isPlaying = isPlaying;
          });
        }
      })
      // 在初始化完成后必须更新界面
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void deactivate() {
    super.deactivate();
    _controller.dispose();
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
          child: _controller.value.initialized
              // 加载成功
              ? new AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                )
              : new Container(),
        ),
        floatingActionButton: new FloatingActionButton(
          onPressed: _controller.value.isPlaying
              ? _controller.pause
              : _controller.play,
          child: new Icon(
            _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
          ),
        ),
      ),
    );
  }
}