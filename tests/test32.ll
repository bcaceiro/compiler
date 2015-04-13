declare i32 @printf(i8* noalias nocapture, ...)
declare noalias i8* @calloc(i32, i32) nounwind
declare i32 @atoi(i8*) nounwind readonly
@.printInt = private constant [4 x i8] c"%d\0A\00"
@.true = private constant [6 x i8] c"true\0A\00"
@.false = private constant [7 x i8] c"false\0A\00"
@.printBool = private constant [2 x i8*] [i8* getelementptr inbounds ([7 x i8]* @.false, i32 0, i32 0),i8* getelementptr inbounds ([6 x i8]* @.true, i32 0, i32 0)]

%.ArrayInt = type { i32, i32* }
%.ArrayBool = type { i32, i1* }
@a = global i32 0
@b = global i32 0
@c = global i32 0
@d = global i1 0
@e = global i1 0
@f = global %.ArrayInt {i32 0, i32* null}
@g = global %.ArrayInt {i32 0, i32* null}
@h = global %.ArrayBool {i32 0, i1* null}
@i = global %.ArrayBool {i32 0, i1* null}
@j = global %.ArrayBool {i32 0, i1* null}


define i32 @main(i32 %argc, i8** %args){
  %a = alloca i32

;STORE
  store i32 0, i32* %a

br label %while.do0
while.do0:
  %..1 = load i32* %a
;.LENGTH
  %..2 = sub i32 %argc , 1
  %..3 = icmp slt i32 %..1, %..2
  %..4 = icmp eq i1 1, %..3
  br i1 %..4, label %while.continue0, label %while.end0
while.continue0:
;PRINT
;PARSEARGS
      %..5 = load i32* %a
      %..6 = add i32 1 , %..5
      %..7 = getelementptr inbounds i8** %args, i32 %..6
      %..8 = load i8** %..7
      %..9 = call i32 @atoi(i8* %..8) nounwind readonly
      call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 %..9)

;STORE
      %..11 = load i32* %a
      %..12 = add i32 %..11 , 1

      store i32 %..12, i32* %a

      br label %while.do0
while.end0:
;STORE
;NEWINTARRAY
  %..13 = call noalias i8* @calloc(i32 4, i32 4) nounwind

  %..14 = bitcast i8* %..13 to i32*
  %..15 = insertvalue %.ArrayInt undef, i32 4, 0
  %..16 = insertvalue %.ArrayInt %..15, i32* %..14, 1
  store %.ArrayInt %..16, %.ArrayInt* @f

;STOREARRAY
;ARRAY
  %..17 = load %.ArrayInt* @f
;INDEX
;VALUE
;STOREFOFINHO
  %..18 = extractvalue %.ArrayInt %..17, 1
  %..19 = getelementptr i32* %..18, i32 3
  store i32 3, i32* %..19
;STORE
  %..20 = call %.ArrayInt @banana()

  store %.ArrayInt %..20, %.ArrayInt* @g

;STOREARRAY
;ARRAY
  %..21 = load %.ArrayInt* @f
;INDEX
;VALUE
;LOADARRAY
  %..22 = load %.ArrayInt* @g
  %..23 = extractvalue %.ArrayInt %..22, 1
  %..24 = getelementptr i32* %..23, i32 2
  %..25 = load i32* %..24
;STOREFOFINHO
  %..26 = extractvalue %.ArrayInt %..21, 1
  %..27 = getelementptr i32* %..26, i32 0
  store i32 %..25, i32* %..27

  ret i32 0
}


define %.ArrayInt @banana(){
  %f2 = alloca %.ArrayInt

;STORE
;NEWINTARRAY
  %..1 = call noalias i8* @calloc(i32 4, i32 4) nounwind

  %..2 = bitcast i8* %..1 to i32*
  %..3 = insertvalue %.ArrayInt undef, i32 4, 0
  %..4 = insertvalue %.ArrayInt %..3, i32* %..2, 1
  store %.ArrayInt %..4, %.ArrayInt* %f2

;STOREARRAY
;ARRAY
  %..5 = load %.ArrayInt* %f2
;INDEX
;VALUE
;STOREFOFINHO
  %..6 = extractvalue %.ArrayInt %..5, 1
  %..7 = getelementptr i32* %..6, i32 3
  store i32 3, i32* %..7
;RETURN
  %..8 = load %.ArrayInt* %f2
  ret %.ArrayInt %..8

  ret %.ArrayInt {i32 0, i32* null}
}

