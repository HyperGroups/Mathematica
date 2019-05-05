# 猫种识别？
---


# Background
---


某QQ群有群友问？有人知道这是一只什么猫吗？有人答：布偶。

当然我也不知道这是什么猫，于是让Wolfram Mathematica来识别一下，正好12.0版本强化了一下目标检测的功能。

彼时我正在吃金拱门加班，于是就小小玩了一下。

### Why Mathematica?


答：For Fun &&方便@顺利的话几分钟到十几分钟不等。

图片是GIF的，所以用其他工具的话，如果不是有现成的服务，或我自己非常熟悉的工具，没这么快的，我也就压根不会临时这么去玩一下了。

# Let's begin
---


首先，查看GIF，选择一张图片，截图试一下@@

![OutputCell](https://raw.githubusercontent.com/HyperGroups/Mathematica/master/ZhiHu/MachineLearningInAction/Source/CatRecognize/CatRecognize/resource/CatRecognize_11.jpg)

    net = NetModel["Wolfram ImageIdentify Net V1"];
    

    net@img

![OutputCell](https://raw.githubusercontent.com/HyperGroups/Mathematica/master/ZhiHu/MachineLearningInAction/Source/CatRecognize/CatRecognize/resource/CatRecognize_14.jpg)

    net[img, "TopProbabilities"]

![OutputCell](https://raw.githubusercontent.com/HyperGroups/Mathematica/master/ZhiHu/MachineLearningInAction/Source/CatRecognize/CatRecognize/resource/CatRecognize_16.jpg)

    ImageIdentify[img]

![OutputCell](https://raw.githubusercontent.com/HyperGroups/Mathematica/master/ZhiHu/MachineLearningInAction/Source/CatRecognize/CatRecognize/resource/CatRecognize_18.jpg)

所以这是一只北极熊，，，这是一只狗。。。反正各种悲剧。。。

多年前，ImageIdentify好像是个联网功能，能精准地识别这是一只hound还是什么狗的，让我印象深刻，但也因为网络体验差等并没有深度使用，[模型联网预测慢]。这两年DeepLearning模型流行，这个也变成了本地模型。但是如果本地模型效果不好的话，用户体验的感觉就不好了。理想的话，其实还不如可以切在线模式，Wolfram自己有个更全能的模型[包含图像搜索库等]，效果更好。

# GIF功能
---


Wolfram Mathematica非常方便用于GIF处理+图像处理生成表情包等玩玩的东西

    gList = Import@"cat.gif";
    Rasterize@gList

![OutputCell](https://raw.githubusercontent.com/HyperGroups/Mathematica/master/ZhiHu/MachineLearningInAction/Source/CatRecognize/CatRecognize/resource/CatRecognize_24.jpg)

导入GIF后就可以方便地挑选一张图片，然后Crop一下，去使用。

# 目标检测@图片裁剪
---


    AbsoluteTiming[ imgsAsso = ImageCases[#, TargetDevice -> "CPU"] & /@ gList[[1 ;; -1]];
    ]

{18.1778,Null}

    assoMerge = Merge[imgsAsso, Identity];
    assoMerge // Keys

![OutputCell](https://raw.githubusercontent.com/HyperGroups/Mathematica/master/ZhiHu/MachineLearningInAction/Source/CatRecognize/CatRecognize/resource/CatRecognize_30.jpg)

### 类别映射


因为...
某个Entity[Key]下可能有你想要的东西，可以合并起来传入KeyTake

![OutputCell](https://raw.githubusercontent.com/HyperGroups/Mathematica/master/ZhiHu/MachineLearningInAction/Source/CatRecognize/CatRecognize/resource/CatRecognize_33.jpg)

# 批量识别
---


    net = NetModel["Inception V3 Trained on ImageNet Competition Data"];
    

    AbsoluteTiming[ result = net[imgsCat[[1 ;; -1]], TargetDevice -> "CPU"];
    ]

{4.03368,Null}

    res2Show = AssociationThread[imgsCat -> result];
    ReverseSort[result // Counts]

![OutputCell](https://raw.githubusercontent.com/HyperGroups/Mathematica/master/ZhiHu/MachineLearningInAction/Source/CatRecognize/CatRecognize/resource/CatRecognize_39.jpg)

### 哼，肥波斯的概率比较大。


# Summary
---


Inception V3对猫更友好@@其他模型大概率判断会各种奇怪非奇怪的物种

我真不知道这是什么猫，听网友说B站开发过一个猫脸识别，没玩过，哪里有细分的猫的数据集，可以做FineTuning训练，有兴趣的可以接着玩。

CPU其实在预测的时候已经够快了，我在回家的车上将本文测试了一下，还是实用的。

### Story:


下午车上还遇到一个转换Notebook文件到MarkDown文件的程序包的Bug，然后Clean了一下一个历史代码，更新了一下，MyMarkDown.wl@欢迎使用，回头有空整理一个简单文章和文档和演示视频，有兴趣的先内测一下，提些需求，转换有问题的可以联系我。其实是很久没用，调错包了，，，然后顺便这个就成了最新的。

我之前使用的MWeb写作，然后它的图床是支持七牛云-有拍云-Google相册-Imgur，发现Imgur被屏蔽了，然后Google相册关闭图床功能了，然后七牛云要域名备案。。。一番测试，又滚回GitHub当图床了，发现没被墙能行。

知乎的文档上传功能中，markdown文件中的图片链接来自imgur.com的时候，显示上传图片失败。。。知乎能穿越一下么。。。或者能支持导入本地图片链接。然后，知乎导入图片很容易就成这样了。。。

    << "/Users/hypergroups/Nutstore/Wolfram \Mathematica/DeployProjects/MyMarkDown/MyMarkDown.wl"

    Notebook2Markdown[EvaluationNotebook[],  "dirOutput" -> NotebookDirectory[], "title" -> "CatRecognize",  ImagePrefix -> "https://raw.githubusercontent.com/HyperGroups/Mathematica/master/\ZhiHu/MachineLearningInAction/Source/CatRecognize"]