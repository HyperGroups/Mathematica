(* ::Package:: *)

(* ::Section:: *)
(*Begin*)


BeginPackage["MyWord`"]


MyWord::usage ="\:5982\:4e2d\:82f1\:6587\:7684\:5355\:8bcd\:ff0c\:751f\:8bcd\:7684\:63d0\:53d6\:7b49\:ff0c\:8bcd\:5178\:7684\:67e5\:627e\:7b49";


DictBaiduURL::usage ="\:767e\:5ea6\:8bcd\:5178\:7f51\:5740\:751f\:6210";
DictBaidu\:7b80\:660e\:91ca\:4e49::usage ="\:767e\:5ea6\:8bcd\:5178\:7b80\:660e\:91ca\:4e49";
dirHome::usage ="\:9605\:8bfb\:6570\:636e\:5e93\:8def\:5f84";
dirReading::usage ="\:9605\:8bfb\:6570\:636e\:5e93\:8def\:5f84";
filesReading::usage ="\:9605\:8bfb\:6570\:636e\:5e93\:7684\:6587\:672c\:6587\:4ef6\:540d";
VocabularyReading::usage ="\:9605\:8bfb\:8bcd\:5e93";
\:751f\:8bcd\:8868::usage ="\:751f\:8bcd\:8868";
\:751f\:8bcd\:672c\:4fe1\:606f::usage ="\:751f\:8bcd\:672c\:4fe1\:606f";
\:719f\:8bcd\:672c\:4fe1\:606f::usage ="\:9605\:8bfb\:6570\:636e\:5e93\:4e2d\:7684\:6587\:672c\:6587\:4ef6";

FunctionNameSplit::usage ="\:5927\:5199\:51fd\:6570\:540d\:5206\:5272";

\:719f\:8bcd\:672c\:6dfb\:52a0\:51fd\:6570List::usage ="\:6dfb\:52a0\:5355\:8bcd\:5230\:719f\:8bcd\:672c";
\:719f\:8bcd\:672c\:5220\:9664\:51fd\:6570List::usage ="\:6dfb\:52a0\:5355\:8bcd\:5230\:719f\:8bcd\:672c";
\:751f\:8bcd\:672c\:6dfb\:52a0\:51fd\:6570List::usage ="\:6dfb\:52a0\:5355\:8bcd\:5230\:751f\:8bcd\:672c";

azWordsExtended::usage =  "\:63d0\:8bcd\:ff0c\:6269\:5c55\:7684";
\:751f\:8bcdGet::usage="\:83b7\:5f97\:751f\:8bcd";
AzCases::usage =  "A-z\:7684\:63d0\:8bcd";
WordsPickerFile::usage =  "\:5355\:8bcd\:6311\:9009\:5668";
(*WordsPickerBaidu::usage =  "\:5355\:8bcd\:6311\:9009\:5668";
WordsPickerURL::usage =  "\:5355\:8bcd\:6311\:9009\:5668";*)


\:767e\:5ea6\:7b80\:660e\:8bcd\:5178Get::usage =  "\:767e\:5ea670000+\:4e2a\:6709\:7b80\:660e\:91ca\:4e49\:7684\:672c\:5730\:8bcd\:5178\:7684Map\:52a0\:8f7d";
\:767e\:5ea6\:7b80\:660e\:8bcd\:5178\:67e5\:8be2::usage =  "\:67e5\:8be2\:672c\:5730\:8bcd\:5178";
(*wordlistX::usage="wordlistX\:6311\:9009\:7684\:751f\:8bcd\:7684\:53d8\:91cf\:540d";*)
\:751f\:8bcd::usage="";
Word2UTF8::usage="";
Dir2UTF8::usage="";
Dir2UnicodeHTML::usage="";


url[msn]="http://www.msn.com/";


Begin["`Private`"];


(* ::Section:: *)
(*Commons*)


\:751f\:8bcdGet[str_List]:=Complement[azWordsExtended@str,VocabularyReading]


Word2UTF8[x_]:="%"<>ToString[Row[IntegerString[ToCharacterCode[ToString[x],"UTF8"],16]//ToUpperCase,"%"]]


Dir2UTF8[dir_]:=If[IntervalMemberQ[Interval[{10000,60000}],ToCharacterCode[#]][[1]],Word2UTF8[#],#]&/@Characters[dir]//StringJoin


Dir2UnicodeHTML[dir_]:=If[IntervalMemberQ[Interval[{10000,60000}],ToCharacterCode[#]][[1]],"&#"<>ToString[ToCharacterCode[#,"Unicode"][[1]]]<>";",#]&/@Characters[dir]//StringJoin


(* ::Section:: *)
(*\:7f51\:7edc\:8bcd\:5178*)


(* ::Subsection:: *)
(*\:767e\:5ea6\:8bcd\:5178*)


urlTemplate[DictBaidu]=StringTemplate@"http://dict.baidu.com/s?wd=``";


urlBaidu[Dict][word0_]:=Module[{word=word0},TemplateApply[urlTemplate[DictBaidu],word]]


DictBaidu:=URLFetch[urlBaidu[Dict][ToString@#],"Content"]&

DictBaidu\:7b80\:660e\:91ca\:4e49:=StringTrim@StringCases[StringReplace[DictBaidu@#,"<"~~Except[">"]..~~">"->""],Shortest["\:7b80\:660e\:91ca\:4e49"~~x___~~"\:4ee5\:4e0b\:7ed3\:679c\:7531 \:91d1\:5c71\:8bcd\:9738 \:63d0\:4f9b"]->x]&

DictBaiduShort:=StringTrim@StringReplace[StringCases[DictBaidu@#,"\:7b80\:660e\:91ca\:4e49"~~x___~~"\:4ee5\:4e0b\:7ed3\:679c\:7531  \:91d1\:5c71\:8bcd\:9738 \:63d0\:4f9b"->x],{"\:4ee5\:4e0b\:7ed3\:679c\:7531  \:91d1\:5c71\:8bcd\:9738 \:63d0\:4f9b"->"","\:67e5\:770b\:66f4\:591a"->"","\:767e\:79d1\:91ca\:4e49"->"","\:7f51\:7edc\:91ca\:4e49"->""}]&



\:7f51\:7edc\:91ca\:4e49:=StringCases[#,Shortest["\:767e\:79d1\:91ca\:4e49"~~x___~~"\:67e5\:770b\:66f4\:591a"]->StringTrim[x]]&;


\:7b80\:660e\:91ca\:4e49:=StringCases[#,Shortest["\:7b80\:660e\:91ca\:4e49"~~x___~~"\:4ee5\:4e0b\:7ed3\:679c\:7531 \:91d1\:5c71\:8bcd\:9738 \:63d0\:4f9b"]->StringTrim@x]&;


(* ::Section:: *)
(*\:751f\:8bcd\:672c\:76f8\:5173*)


dirHome=DirectoryName[FindFile["MyWord`"]];
Print@dirHome;
(*dirReading:="F:\\Documents\\English\\ReadingDataBase";*)
(*filesReading:=FileNames["*.txt",dirReading,Infinity];*)
VocabularyReading:=Import[dirHome<>"\:6781\:5c0f\:9605\:8bfb\:8bcd\:6c47.txt","List"];
\:751f\:8bcd\:8868:=Import[dirHome<>"\:751f\:8bcd\:672c.txt","List"];
\:751f\:8bcd\:672c\:4fe1\:606f:=(\:751f\:8bcd\:8868;VocabularyReading;Print["\:751f\:8bcd\:6570\:91cf=",\:751f\:8bcd\:8868//Union//Length];\:751f\:8bcd\:672c\:7edf\:8ba1=\:751f\:8bcd\:8868//Tally)
\:719f\:8bcd\:672c\:4fe1\:606f:=(Print["\:719f\:8bcd\:6570\:91cf=",Length@VocabularyReading])


(*file="E:\\Users\\Hyper\\Documents\\Mathematica\\WordListBaidu75455"*)


(*fileBaseNameDict="asso\:767e\:5ea6\:7b80\:660e\:8bcd\:5178_M@10.2@win10_x64.mx";*)


fileBaseNameDict="asso\:767e\:5ea6\:7b80\:660e\:8bcd\:5178_M@10.3.1@win7_x64.mx";


fileNameAssoDict=FileNameJoin[{dirHome,fileBaseNameDict}];


\:767e\:5ea6\:7b80\:660e\:8bcd\:5178Get:=Get[fileNameAssoDict]


\:767e\:5ea6\:7b80\:660e\:8bcd\:5178\:67e5\:8be2[word_]:=If[ValueQ@Global`asso\:767e\:5ea6\:7b80\:660e\:8bcd\:5178,Lookup[Global`asso\:767e\:5ea6\:7b80\:660e\:8bcd\:5178,ToString[word],"None"],\:767e\:5ea6\:7b80\:660e\:8bcd\:5178Get;Lookup[Global`asso\:767e\:5ea6\:7b80\:660e\:8bcd\:5178[ToString[word]],"None"]](*/.Missing["KeyAbsent",__]->"None"*)


nf=Nearest[DictionaryLookup["*"]];

AzCases=StringCases[If[StringQ[#],#,ToString[#]//StringJoin],RegularExpression["[a-z]+"],IgnoreCase->True]&;

azCases=StringCases[ToString[#]//StringJoin//ToLowerCase,RegularExpression["[a-z]+"]]&;

azWords=Flatten[azCases[#]//DeleteDuplicates//DictionaryLookup/@#&]&;

azWordsLength[string_,length___:3]:=Select[azWords[string],StringLength[#]>=length&]

wordsFileIntersection[file1_?FileExistsQ,file2_?FileExistsQ]:=Intersection[azWordsLength[Import@file1,3],azWordsLength[Import@file2,3]]

wordsFileComplement[file_?FileExistsQ,file2_?FileExistsQ]:=Complement[azWordsLength[Import@file1,3],azWordsLength[Import@file2,3]]

FunctionNameSplit[word0_String]:=Module[{word=word0},Flatten@
DeleteDuplicates@{ToLowerCase@word,Sequence@@StringSplit[
StringReplace[word,x:RegularExpression["[A-Z]"]->Sequence@@{"\:5206\:5272\:7b26",x}]
,"\:5206\:5272\:7b26"]}/;StringQ[word]]

SetAttributes[FunctionNameSplit,Listable]

azWordsExtended=Union@DeleteDuplicates@Select[Flatten[(Flatten[FunctionNameSplit@AzCases[#]]//DeleteDuplicates//DictionaryLookup[#,IgnoreCase->True]&/@#&)],StringLength[#]>2&]&;
SetAttributes[azWordsExtended,Listable]



WordsPickerFile[file0_String]:=DynamicModule[{file=file0,i,wordListToPickPartitioned,length(*,wordList*)},If[FileExistsQ[file],True,If[StringMatchQ[file,"http"~~__],True,Print["File Not Found"];Abort[]]];wordList=Complement[azWordsExtended@Import[file,"Plaintext"],VocabularyReading];length=Length@wordList;Print[length];If[length==0,Print["No New Words"];Abort[]];

wordListToPickPartitioned=Partition[wordList,If[length>10,10,length],If[length>10,10,length],1,{}];

wordListX={};

(*\:751f\:6210\:4e00\:4e2a\:7b14\:8bb0\:672c\:7528\:4e8e\:5355\:8bcd\:6d4f\:89c8\:4e0e\:751f\:8bcd\:9009\:62e9\:3002*)
CreateDocument[Button[(*\:6309\:662f\:5426\:5728\:751f\:8bcd\:672c\:53ca\:7b80\:660e\:8bcd\:5178\:6807\:8bb0\:989c\:8272*)If[MemberQ[\:751f\:8bcd\:8868,#],Style[{#,\:767e\:5ea6\:7b80\:660e\:8bcd\:5178\:67e5\:8be2[#]},Red,Bold],Style[{#,\:767e\:5ea6\:7b80\:660e\:8bcd\:5178\:67e5\:8be2[#]},Blue,Bold]],(*(\:6309\:94ae\:529f\:80fd\:ff1a\:6309\:4e00\:6b21\:52a0\:5165wordlistX,\:6309\:4e24\:6b21\:4ecewordlistX\:53bb\:9664)*)If[MemberQ[wordListX,#],wordListX=DeleteCases[wordListX,#],AppendTo[wordListX,#]],Appearance->None]&/@wordList];
Column@{Dynamic[Row[wordListX,"@"]],"\n\n",Column@Table[TogglerBar[Dynamic[wordListX],(Thread[Rule[wordListToPickPartitioned[[i]],If[MemberQ[\:751f\:8bcd\:8868,#],Pane[Style[#,Red,Bold],ImageSize->{100,30}];If[\:767e\:5ea6\:7b80\:660e\:8bcd\:5178\:67e5\:8be2[#]!="None",Pane[Style[#,Blue,Bold],ImageSize->{100,30}],Pane[Style[#,Green,Bold],ImageSize->{100,30}]],Pane[#,ImageSize->{100,30}]]&/@wordListToPickPartitioned[[i]]]])],{i,Length@wordListToPickPartitioned}],Button["\:6dfb\:52a0\:5230\:751f\:8bcd\:672c",\:751f\:8bcd\:672c\:6dfb\:52a0\:51fd\:6570List[wordListX]],Button["\:6dfb\:52a0\:5230\:719f\:8bcd\:672c",\:719f\:8bcd\:672c\:6dfb\:52a0\:51fd\:6570List[Complement[wordList,wordListX]]]}]


\:751f\:8bcdQ:=MemberQ[\:751f\:8bcd\:8868,#]&
\:719f\:8bcdQ:=MemberQ[VocabularyReading,#]&
SetAttributes[\:719f\:8bcdQ,Listable];
SetAttributes[\:751f\:8bcdQ,Listable];
dictionaryLookup=If[\:719f\:8bcdQ[#],{#},{}]&;
SetAttributes[dictionaryLookup,Listable];


\:719f\:8bcd\:672c\:6dfb\:52a0\:51fd\:6570List[file0_List] := 
	Module[{file = file0}, VocabularyReading;
  wordsNew = Complement[file,VocabularyReading,\:751f\:8bcd\:8868]; 
  \:6781\:5c0f\:9605\:8bfb\:8bcd\:6c47 = Import[\:6781\:5c0f\:9605\:8bfb\:8bcd\:6c47fileToExport = FileNameJoin[{dirHome,"\:6781\:5c0f\:9605\:8bfb\:8bcd\:6c47.txt"}],"List"];
  \:65b0\:6781\:5c0f\:9605\:8bfb\:8bcd\:6c47 = wordsNew~Join~\:6781\:5c0f\:9605\:8bfb\:8bcd\:6c47 // Union; 
  fileToCopy = FileNameJoin[{dirHome,"\:8bcd\:6c47\:5e93\:5907\:4efd\\\:6781\:5c0f\:9605\:8bfb\:8bcd\:6c47" <> 
    Block[{$DateStringFormat = {"Month", "-", "Day", "-", "Year", "-", "Hour", "-", "Minute", "-", "Second"}},
     DateString[]] <> "Length" <> ToString[Length@\:65b0\:6781\:5c0f\:9605\:8bfb\:8bcd\:6c47] <> ".txt"}];
     
  If[FileExistsQ[fileToCopy], DeleteFile[fileToCopy];CopyFile[\:6781\:5c0f\:9605\:8bfb\:8bcd\:6c47fileToExport, fileToCopy], 
   CopyFile[\:6781\:5c0f\:9605\:8bfb\:8bcd\:6c47fileToExport, fileToCopy]]; 
   
   Print["\:65b0\:589e\:8bcd\:6c47=", If[Length[#]==0,"None",#]&@Complement[\:65b0\:6781\:5c0f\:9605\:8bfb\:8bcd\:6c47, \:6781\:5c0f\:9605\:8bfb\:8bcd\:6c47]];
   	
   	Export[\:6781\:5c0f\:9605\:8bfb\:8bcd\:6c47fileToExport, \:65b0\:6781\:5c0f\:9605\:8bfb\:8bcd\:6c47];
VocabularyReading;
   /;And@@(StringQ/@file)]


\:719f\:8bcd\:672c\:5220\:9664\:51fd\:6570List[file0_List] := 
	Module[{file = file0}, 
  \:6781\:5c0f\:9605\:8bfb\:8bcd\:6c47 = Import[\:6781\:5c0f\:9605\:8bfb\:8bcd\:6c47fileToExport = "\:6781\:5c0f\:9605\:8bfb\:8bcd\:6c47.txt","List"];
  \:65b0\:6781\:5c0f\:9605\:8bfb\:8bcd\:6c47 =Delete[\:6781\:5c0f\:9605\:8bfb\:8bcd\:6c47,Flatten[Position[\:6781\:5c0f\:9605\:8bfb\:8bcd\:6c47,#]&/@file,1]]// Union; 
  fileToCopy = FileNameJoin[{dirHome,"\:8bcd\:6c47\:5e93\:5907\:4efd\\\:6781\:5c0f\:9605\:8bfb\:8bcd\:6c47"<> 
    Block[{$DateStringFormat = {"Month", "-", "Day", "-", "Year", "-", "Hour", "-", "Minute", "-", "Second"}},
     DateString[]] <> "Length" <> ToString[Length@\:65b0\:6781\:5c0f\:9605\:8bfb\:8bcd\:6c47] <> ".txt"}];
     
  If[FileExistsQ[fileToCopy], DeleteFile[fileToCopy];CopyFile[\:6781\:5c0f\:9605\:8bfb\:8bcd\:6c47fileToExport, fileToCopy], 
   CopyFile[\:6781\:5c0f\:9605\:8bfb\:8bcd\:6c47fileToExport, fileToCopy]]; 
   
   Print["\:5220\:9664\:8bcd\:6c47=", If[Length[#]==0,"None",#]&@Complement[file]];
   	
   	Export[\:6781\:5c0f\:9605\:8bfb\:8bcd\:6c47fileToExport, \:65b0\:6781\:5c0f\:9605\:8bfb\:8bcd\:6c47]
   /;And@@(StringQ/@file)]


\:751f\:8bcd\:672c\:6dfb\:52a0\:51fd\:6570List[file0_List] := 
	Module[{file = file0}, 
  wordsNew = file; 
  \:751f\:8bcd\:8868 = Import[\:751f\:8bcd\:672cfileToExport = FileNameJoin[{dirHome,"\:751f\:8bcd\:672c.txt"}], "List"];
  \:65b0\:751f\:8bcd = wordsNew~Join~\:751f\:8bcd\:8868; 
  fileToCopy =  FileNameJoin[{dirHome, "\:8bcd\:6c47\:5e93\:5907\:4efd\\\:751f\:8bcd\:8868" <> 
    Block[{$DateStringFormat = {"Month", "-", "Day", "-", "Year", "-", "Hour", "-", "Minute", "-", "Second"}},
     DateString[]] <> "Length" <> ToString[Length@\:65b0\:751f\:8bcd] <> ".txt"}];
     
  If[FileExistsQ[fileToCopy], DeleteFile[fileToCopy];CopyFile[\:751f\:8bcd\:672cfileToExport, fileToCopy], 
   CopyFile[\:751f\:8bcd\:672cfileToExport, fileToCopy]]; 
   
   Print["\:65b0\:589e\:8bcd\:6c47=", If[Length[#]==0,"None",#]&@Complement[\:65b0\:751f\:8bcd,\:751f\:8bcd\:8868]];
Export[\:751f\:8bcd\:672cfileToExport, \:65b0\:751f\:8bcd];
\:751f\:8bcd\:672c\:4fe1\:606f;
\:751f\:8bcd\:8868;
   /;And@@(StringQ/@file)]


(* ::Section:: *)
(*\:751f\:8bcd\:5728\:6587\:672c\:4e2d\:7684\:6807\:8bb0*)


ColorMark[text0_,word0_]:=Module[{text=text0,word=word0},TextCell[Row[List@@StringReplace[text,{word:>Style[word,24,Bold,Red]}]],"Text"]]
SetAttributes[ColorMark,Listable]


(* ::Section:: *)
(*End*)


End[]


\:767e\:5ea6\:7b80\:660e\:8bcd\:5178Get;


EndPackage[]
