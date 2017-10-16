# live（直播项目）
#### 直播技术要点
1. 视频采集

    视频采集可以使用系统的AVFoundation实现，包括图像采集和音频采集。设置`AVCaptureVideoDataOutput`和`AVCaptureAudioDataOutput`的代理，通过`-captureOutput:didOutputSampleBuffer:fromConnection:`代理方法可获取每一帧图像，设置`AVCaptureVideoPreviewLayer`为图像预览图层。
    
    也可以使用GPUImage采集。GPUImage有个`GPUImageVideoCamera`类用来做视频采集，可为它设置滤镜，采集时顺便进行滤镜处理，也可以设置代理获取`sampleBuffer`，预览图层使用`GPUImageView`。
    
2. 视频编码

    录制出来的视频是非常大的，直接进行传出不太现实，所以要对视频进行编码压缩。iOS 8 之后可以使用系统的VideoToolBox进行基于GPU的硬编码，对`VTCompressionSessionRef`初始化并设置各项参数，如编码格式、输出帧率、码率、关键帧间隔等。目前最常用的编码格式是H.264，H.264定义了三种帧：I帧、P帧和B帧，I帧是完整的帧，PB帧都是预测帧；I帧采用帧内压缩，PB真采用帧间压缩。对采集到的`sampleBuffer`
