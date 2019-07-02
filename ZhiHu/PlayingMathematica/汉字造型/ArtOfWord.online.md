# 汉字的3D造型艺术
---


# Background
---


一来简单整理一下，几个Mathematica中相关的函数，大家可以参考一下有空玩玩，二来简单宣传一下几个历史小作品，三来给组织做一些Case展示，有兴趣一起玩的大概能知道玩些啥，怎么玩，然后我只负责挖坑最好。。。

本文主要是专注于汉字的静态三维造型，并且主要是平面上的。

有了基础的所有汉字的坐标后，那么我们可以控制点出现的先后顺序，又是另一种动画的形态了，参考倾城之恋。

# Sample@Net
---


![OutputCell](https://raw.githubusercontent.com/HyperGroups/Mathematica/master/ZhiHu/PlayingMathematica/汉字造型//ArtOfWord/resource/ArtOfWord_7.jpg)

# Sample@剑
---


    pos2D = (Composition[ReflectionTransform[{0, -1}]] /@ (Reverse /@ Position[ImageData[Binarize@Rasterize[Style["剑", 500](*,RasterSize\[Rule]2000*)]], 0]));
    

    ListPlot[pos2D]

![OutputCell](https://raw.githubusercontent.com/HyperGroups/Mathematica/master/ZhiHu/PlayingMathematica/汉字造型//ArtOfWord/resource/ArtOfWord_11.jpg)

    ListPlot[pos2DCenter = TranslationTransform[{0, 100} - Mean[pos2D] // N]@# & /@ pos2D[[1 ;; -1 ;; 250]]]

![OutputCell](https://raw.githubusercontent.com/HyperGroups/Mathematica/master/ZhiHu/PlayingMathematica/汉字造型//ArtOfWord/resource/ArtOfWord_13.jpg)

    pos3D = RotationMatrix[-90 Degree, {0, 0, 1}].{28 #[[1]], 28 #[[2]], 0} & /@ pos2DCenter;
    len = pos3D // LengthListPointPlot3D[pos3D, ViewPoint -> Top]

296

![OutputCell](https://raw.githubusercontent.com/HyperGroups/Mathematica/master/ZhiHu/PlayingMathematica/汉字造型//ArtOfWord/resource/ArtOfWord_16.jpg)

# Raster3D
---


    Graphics3D[{Raster3D[t = {Rasterize[ExpressionCell[Style["Hello", 80, Red], "Output", Background -> None], "Data", Background -> None]}, {{0, 1, 0.4}, {1, 0, 0.6}}, Method -> {"InterpolateValues" -> True}]},  PlotRange -> {0, 1}, ViewPoint -> {-1.54, 0.35, 3},  ViewVertical -> {-0.23, 0.86, 0.46}]

![OutputCell](https://raw.githubusercontent.com/HyperGroups/Mathematica/master/ZhiHu/PlayingMathematica/汉字造型//ArtOfWord/resource/ArtOfWord_19.jpg)

# ImageMesh
---


Create 3D-printable objects from 2D images:

![OutputCell](https://raw.githubusercontent.com/HyperGroups/Mathematica/master/ZhiHu/PlayingMathematica/汉字造型//ArtOfWord/resource/ArtOfWord_22.jpg)

    ImageMesh[ColorNegate[i]]

![OutputCell](https://raw.githubusercontent.com/HyperGroups/Mathematica/master/ZhiHu/PlayingMathematica/汉字造型//ArtOfWord/resource/ArtOfWord_24.jpg)

    RegionProduct[%, Line[{{0.}, {50.}}]]

![OutputCell](https://raw.githubusercontent.com/HyperGroups/Mathematica/master/ZhiHu/PlayingMathematica/汉字造型//ArtOfWord/resource/ArtOfWord_26.jpg)

# Sample@Wall
---


Demonstrations里竟然搜索不到了，我上传了一下

这里[下载](https://github.com/HyperGroups/Mathematica/blob/master/ZhiHu/PlayingMathematica/%E6%B1%89%E5%AD%97%E9%80%A0%E5%9E%8B/bricks.nb)

![OutputCell](https://raw.githubusercontent.com/HyperGroups/Mathematica/master/ZhiHu/PlayingMathematica/汉字造型//ArtOfWord/resource/ArtOfWord_30.jpg)

# Sample@汉字的透视图重构
---


之前的一个重构的问题，本来是想合并到这里的，但是想着这篇主要是整体，并且专注于静态的三维点为主就不放了。

[article](https://zhuanlan.zhihu.com/p/68269562)

![OutputCell](https://raw.githubusercontent.com/HyperGroups/Mathematica/master/ZhiHu/PlayingMathematica/汉字造型//ArtOfWord/resource/ArtOfWord_34.jpg)

# Other
---


其他风格化的汉字

关于这个Topic有哪些Example，欢迎链接到评论区或发我~~~

# Summary
---


Mathematica里有许多有趣的Demo，但是他们视觉效果太Naive，我们可以从中获取许多数据，然后生成一些更好看更好玩的作品。
当然对Demonstration感兴趣的也可以自己做一些上传。

[projects_page](https://www.yuque.com/animation_projects)

### GIF Gallery




### B站作品


[作品_B站](https://www.bilibili.com/video/av56828439/)

    << "/Users/hypergroups/Nutstore/Wolfram \Mathematica/DeployProjects/MyMarkDown/MyMarkDown.wl"

    Notebook2Markdown[EvaluationNotebook[],  "dirOutput" -> NotebookDirectory[], "title" -> "ArtOfWord",  ImagePrefix -> "https://raw.githubusercontent.com/HyperGroups/Mathematica/master/\ZhiHu/PlayingMathematica/汉字造型/"]