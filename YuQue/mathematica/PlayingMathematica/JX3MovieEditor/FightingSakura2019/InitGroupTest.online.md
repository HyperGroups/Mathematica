# 逆水寒动画编辑器静态群组生成
---


    << "/Users/hypergroups/Documents/githubhg/MathematicaMovieEditor/\JusticeMovieEditor/Packages/JusticeEditorV001.wl"

# Mathematica
---


    pts = Append[N@1000 #, 0] & /@ CirclePoints[100];
    

在Mathematica里生成群组的坐标，这里我们生成的是100个点组成的圈圈

# MovieGen
---


### DataTransform


    centerEditor = {68909.86, 1453.97, 53776.79};
    

    ptsEditor = centerEditor + {#[[1]], #[[3]], #[[2]]} & /@ pts;
    

    element[Director] = JusticeEditor`elementTemplate[Director];
    

### MovieGen&&Export


    actors = EditorActorGen["initPos" -> #] & /@ ptsEditor;
    

    movie = EditorMovieGen[{actors}];
    

    EditorMovieExport["testGroup", movie,  dirOutput -> NotebookDirectory[]]

/Users/hypergroups/Documents/githubhg/MathematicaMovieEditor/JusticeMovieEditor/Working/Test/testGroup.movie

# 教程
---


导出的Movie文件要用Notepad++打开点一下转换编码为ANSI，然后复制到大宋映画的指定目录中去，然后在动画编辑器中导入动画文件即可生效。

    << "/Users/hypergroups/Nutstore/Wolfram \Mathematica/DeployProjects/MyMarkDown/MyMarkDown.wl"

    Notebook2Markdown[EvaluationNotebook[],  "dirOutput" -> NotebookDirectory[], "title" -> "InitGroupTest",  ImagePrefix -> "https://raw.githubusercontent.com/HyperGroups/Mathematica/master/\YuQue/mathematica/PlayingMathematica/InitGroupTest"]