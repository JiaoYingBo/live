# live（直播项目）
#### 直播技术要点
1. 视频采集

    视频采集可以使用系统的AVFoundation实现，包括图像采集和音频采集。设置`AVCaptureVideoDataOutput`和`AVCaptureAudioDataOutput`的代理，通过`-captureOutput:didOutputSampleBuffer:fromConnection:`代理方法可获取每一帧图像，设置`AVCaptureVideoPreviewLayer`为图像预览图层。
    
    也可以使用GPUImage采集。GPUImage有个`GPUImageVideoCamera`类用来做视频采集，可为它设置滤镜，采集时顺便进行滤镜处理，也可以设置代理获取`sampleBuffer`，预览图层使用`GPUImageView`。
    
    
2. 视频编码

    录制出来的视频是非常大的，直接进行传出不太现实，所以要对视频进行编码压缩。iOS 8 之后可以使用系统的VideoToolBox/AudioToolBox进行基于GPU的硬编码，对`VTCompressionSessionRef`初始化并设置各项参数，如编码格式、输出帧率、码率、关键帧间隔等。
    
    目前最常用的编码格式是H.264，H.264定义了三种帧：I帧、P帧和B帧，I帧是完整的帧，PB帧都是预测帧；I帧采用帧内压缩，PB真采用帧间压缩；序列（GOP）是H.264编码后进行传输的基本单位；I帧是一个序列的第一个图像，也叫IDR图像（立即刷新图像），之后的PB帧都是基于它进行预测的；一个序列就是一段内容差异不太大的图像编码后生成的一串数据流。
    
    H264算法分为两层：视频编码层（VCL：Video Coding Layer）负责高效的视频内容表示，网络提取层（NAL：Network Abstraction Layer）负责以网络所要求的恰当的方式对数据进行打包和传送。上面所说的编码属于VCL层，NAL将每一帧数据写入一个NAL单元（NALU）中进行传输，NALU以 00 00 00 01 作为起始标志。IPB帧都被封装成NALU进行传输，不过I帧之前也有非VCL的数据：图像参数集（PPS）和序列参数集（SPS）。
   
    使用`VTCompressionSessionRef`对采集到的`sampleBuffer`进行H.264编码，并写入NALU进行数据存储和传输。若要支持 iOS 7，需要使用FFmpeg+X264库进行软编码。音频数据进行ACC编码。
    
3. 推流

    推流前需要把数据进行封装，封装成FLV格式的视频，然后通过RTMP协议进行推流，使用开源库[LFLiveKit](https://github.com/LaiFengiOS/LFLiveKit)可进行推流。
    
4. 拉流

    拉流播放可使用开源库[ijkPlayer](https://github.com/Bilibili/ijkplayer)。
