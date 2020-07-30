# Fibonacci
---


# Background
---


因为Mathematica12.1引入了DataStructure，本来是在看HashTable，结果调大一个值就。。。$RecursionLimitProblem了，于是就调研了一下这个问题。

# Basic
---


    fibR1[n_] := Module[{res},Which[n <= 1,	n, True,	res = fibR1[n - 2] + fibR1[n - 1]]]

    fibR1[20]

6765

20还可以，30就不能秒出结果了。。。

    AbsoluteTiming[fibR1 /@ Range[30];
    ]

{17.7232,Null}

    f[1] = 1;
    f[2] = 1;
    f[n_] := f[n - 1] + f[n - 2]

Which的这个写法本身有毒吗，30这里慢了10倍

    AbsoluteTiming[r = f /@ Range[30];
    ]

{2.39841,Null}

### Plot


    timeList = Table[AbsoluteTiming[fibR@i;
    ], {i, 30}]

{{0.000029,Null},{0.000014,Null},{7.*10^-6,Null},{6.*10^-6,Null},{5.*10^-6,Null},{6.*10^-6,Null},{6.*10^-6,Null},{6.*10^-6,Null},{6.*10^-6,Null},{0.,Null},{5.*10^-6,Null},{2.*10^-6,Null},{1.*10^-6,Null},{6.*10^-6,Null},{6.*10^-6,Null},{0.,Null},{5.*10^-6,Null},{6.*10^-6,Null},{6.*10^-6,Null},{6.*10^-6,Null},{5.*10^-6,Null},{7.*10^-6,Null},{6.*10^-6,Null},{0.,Null},{1.*10^-6,Null},{1.*10^-6,Null},{2.*10^-6,Null},{1.*10^-6,Null},{1.*10^-6,Null},{0.,Null}}

    d = timeList[[All, 1]];
    

    fx = Fit[d, E^x, x];
    

    g = Show[ListPlot[d], Plot[fx, {x, 0, 50}]]

![OutputCell](https://raw.githubusercontent.com/HyperGroups/Mathematica/master/YuQue/mathematica/PlayingMathematica/Fibonacci/Playing@Fibonacci_001/resource/Playing@Fibonacci_001_21.jpg)

### Plot@f


f也一样，

    AbsoluteTiming[f@30]

{0.937777,832040}

    AbsoluteTiming[f@40]

$Aborted

    timeList = Table[AbsoluteTiming[f@i;
    ], {i, 30}]

{{3.*10^-6,Null},{1.*10^-6,Null},{6.*10^-6,Null},{4.*10^-6,Null},{7.*10^-6,Null},{0.000011,Null},{0.000018,Null},{0.000029,Null},{0.000089,Null},{0.000079,Null},{0.000124,Null},{0.000204,Null},{0.000333,Null},{0.000535,Null},{0.000911,Null},{0.00141,Null},{0.002418,Null},{0.003805,Null},{0.006172,Null},{0.010139,Null},{0.01379,Null},{0.021882,Null},{0.032887,Null},{0.051828,Null},{0.082915,Null},{0.136113,Null},{0.218067,Null},{0.355798,Null},{0.576217,Null},{0.950675,Null}}

    d = timeList[[All, 1]];
    

    fx = Fit[d, E^x, x];
    

    g = Show[ListPlot[d], Plot[fx, {x, 0, 50}]]

![OutputCell](https://raw.githubusercontent.com/HyperGroups/Mathematica/master/YuQue/mathematica/PlayingMathematica/Fibonacci/Playing@Fibonacci_001/resource/Playing@Fibonacci_001_33.jpg)

### ms指数级？
指数级是多可怕呢


对于一个黑盒函数，有时我们想，30能算出来，那么参数变一变，31可能也能算出来吧？我们看到，30花了一秒，31花了3秒，于是手一抖，
写个40...\[LongDash]\[LongDash]好了，等半天跑不出来，要跑6个小时。

    fx /. x -> 30

1.03781

    fx /. x -> 31

2.82106

    fx /. x -> 40

22859.3

    22859.27838947847`/3600 // N

6.3498

### 为什么指数级？


每个f[n]计算时，都把所有小于n的数计算了一次f，x+x*x

f[1] = t[f[1_]]=1*x
f[2] = T[f[1]] + T[f[1]]=2*x
f[3] = T[f[2]] + T[f[1]] +T[f[3_]]= T[f[1]] + T[f[1]] + T[f[1]]+T[f[3_]]=4*x
f[4]=T[f[3]]+T[f[2]]+T[f[4_]]=T[f[3]]+T[f[2]]+T[f[4_]]=6*x<=>8*x

设单位时间为x,那么为什么不是计算每个f[n]不是平方x^2呢？
首先从结论来看，如果计算每个f[n]都是平方时间复杂度，那么累加起来也是平方复杂度，
其次，我们看到上面的的手推中，这里的{1,2,4,8}约等于可以差不多获得2^(n-1)次，所以网上百度后是2^n次的说法只是近似，这样比较简单，怎么理解呢，f[4]就相当于算两次f[3]，即T[f[4]]=2*T[f[3]]，其实是f[2]的时间要小于f[3]。

因为按常微分方程的特征方程可以获得通解，其中有1.618这个数字，在Mathematica只要查看RecurrenceTable也可以获得更多信息。

# 画图@拟合时间复杂度
---


    fx1 = Fit[d, 1.617^x, x];
    fx2 = Fit[d, 2^x, x];
    

    g = Show[ListPlot[d], Plot[fx, {x, 0, 50}, PlotStyle -> Red], Plot[fx1, {x, 0, 50}, PlotStyle -> Green], Plot[fx2, {x, 0, 50}, PlotStyle -> Dashed]]

![OutputCell](https://raw.githubusercontent.com/HyperGroups/Mathematica/master/YuQue/mathematica/PlayingMathematica/Fibonacci/Playing@Fibonacci_001/resource/Playing@Fibonacci_001_52.jpg)

# Memorization
---


    f1[1] = 1;
    f1[2] = 1;
    f1[n_] := f1[n] = f1[n - 1] + f1[n - 2]

    AbsoluteTiming[r = f1 /@ Range[30];
    ]

{0.000177,Null}

    fibR2[n_] := Module[{res},Which[n <= 2,	1, True,	res = fibR2[n] = fibR2[n - 2] + fibR2[n - 1]]]

    AbsoluteTiming[fibR2 /@ Range[30000];
    ]

{0.018734,Null}

# Fib@HashTable
---


    FibR2A[n_] :=iFib[CreateDataStructure["HashTable"], n]

    iFibR2A[st_, n_] := Module[{res},Which[n <= 1,	n,st["KeyExistsQ", n],	st["Lookup", n],True,	res = iFibR2A[st, n - 2] + iFibR2A[st, n - 1];
    	st["Insert", n -> res];
    	res]]

    AbsoluteTiming[FibR2A /@ Range[1000];
    ]

{5.20567,Null}

1000以上，我这测试时，就触发$RecursionLimit的问题了，也就是本文的源起了。

### 划重点


那么问题来了，既然在上面，我们只添加了【fibR2[n]=】这个东西就解决我们的需求，那么，现在对于FibR2A怎么简单改一下，就非常OK了呢？？？【修改$RecursionLimit不算】

这个例子摆在这里是几个意思呢？是HashTable可以这样用？但是很不实用？。。。

# 循环实现
---


    fibLoop[n_] := Module[{res, a, b, i},a = 0;
    b = 1;
    For[i = 2, i <= n, i++,res = a + b;
    a = b;
    b = res;
    ];
    If[n <= 1, n,res]]

    fibLoop /@ Range[30]

{1,1,2,3,5,8,13,21,34,55,89,144,233,377,610,987,1597,2584,4181,6765,10946,17711,28657,46368,75025,121393,196418,317811,514229,832040}

    AbsoluteTiming[fibLoop /@ Range[3000];
    ]

{5.52563,Null}

    fibLoop1[n_] := Module[{res, a, b, i},a = 0;
    b = 1;
    Do[res = a + b;
    a = b;
    b = res;
    i = i + 1;
    , {i, 2, n}];
    If[n <= 1, n,res]]

    AbsoluteTiming[fibLoop1 /@ Range[3000];
    ]

{5.56601,Null}

说好的For循环慢呢？Do也一样慢啊===>此处。。。

# End
---


本文先玩到这里。

    << "/Users/hypergroups/Nutstore/Wolfram \Mathematica/DeployProjects/MyMarkDown/MyMarkDown.wl"

    Notebook2Markdown[EvaluationNotebook[],  "dirOutput" -> NotebookDirectory[],  "title" -> "Playing@Fibonacci_001",  ImagePrefix -> "https://raw.githubusercontent.com/HyperGroups/Mathematica/master/\YuQue/mathematica/PlayingMathematica/Fibonacci"]