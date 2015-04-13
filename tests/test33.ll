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

;STORE
;NEWBOOLARRAY
  %..1 = call noalias i8* @calloc(i32 9, i32 1) nounwind

  %..2 = bitcast i8* %..1 to i1*
  %..3 = insertvalue %.ArrayBool undef, i32 9, 0
  %..4 = insertvalue %.ArrayBool %..3, i1* %..2, 1
  store %.ArrayBool %..4, %.ArrayBool* @h

;STORE
;NEWINTARRAY
  %..5 = call noalias i8* @calloc(i32 3, i32 4) nounwind

  %..6 = bitcast i8* %..5 to i32*
  %..7 = insertvalue %.ArrayInt undef, i32 3, 0
  %..8 = insertvalue %.ArrayInt %..7, i32* %..6, 1
  store %.ArrayInt %..8, %.ArrayInt* @g

br label %while.do0
while.do0:
  %..9 = load i32* %a
;.LENGTH
  %..10 = sub i32 %argc , 1
  %..11 = icmp slt i32 %..9, %..10
  %..12 = icmp eq i1 1, %..11
  br i1 %..12, label %while.continue0, label %while.end0
while.continue0:
;PRINT
;PARSEARGS
      %..13 = load i32* %a
      %..14 = add i32 1 , %..13
      %..15 = getelementptr inbounds i8** %args, i32 %..14
      %..16 = load i8** %..15
      %..17 = call i32 @atoi(i8* %..16) nounwind readonly
      call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 %..17)

;STORE
      %..19 = load i32* %a
      %..20 = add i32 %..19 , 1

      store i32 %..20, i32* %a

      br label %while.do0
while.end0:
;STOREARRAY
;ARRAY
  %..21 = load %.ArrayInt* @g
;INDEX
;LOADARRAY
  %..22 = load %.ArrayInt* @g
;LOADARRAY
  %..23 = load %.ArrayInt* @g
  %..24 = extractvalue %.ArrayInt %..23, 1
  %..25 = getelementptr i32* %..24, i32 2
  %..26 = load i32* %..25
  %..27 = extractvalue %.ArrayInt %..22, 1
  %..28 = getelementptr i32* %..27, i32 %..26
  %..29 = load i32* %..28
;VALUE
;STOREFOFINHO
  %..30 = extractvalue %.ArrayInt %..21, 1
  %..31 = getelementptr i32* %..30, i32 %..29
  store i32 2, i32* %..31
;STORE
;NEWINTARRAY
  %..32 = call noalias i8* @calloc(i32 4, i32 4) nounwind

  %..33 = bitcast i8* %..32 to i32*
  %..34 = insertvalue %.ArrayInt undef, i32 4, 0
  %..35 = insertvalue %.ArrayInt %..34, i32* %..33, 1
  store %.ArrayInt %..35, %.ArrayInt* @f

;STOREARRAY
;ARRAY
  %..36 = load %.ArrayInt* @f
;INDEX
;VALUE
;STOREFOFINHO
  %..37 = extractvalue %.ArrayInt %..36, 1
  %..38 = getelementptr i32* %..37, i32 3
  store i32 3, i32* %..38
;STORE
;LOADARRAY
  %..39 = load %.ArrayInt* @f
  %..40 = extractvalue %.ArrayInt %..39, 1
  %..41 = getelementptr i32* %..40, i32 1
  %..42 = load i32* %..41
  store i32 %..42, i32* %a

;STORE
  %..43 = call %.ArrayInt @banana( i32 3 )

  store %.ArrayInt %..43, %.ArrayInt* @g

;STOREARRAY
;ARRAY
  %..44 = load %.ArrayInt* @f
;INDEX
;VALUE
;LOADARRAY
  %..45 = load %.ArrayInt* @g
  %..46 = extractvalue %.ArrayInt %..45, 1
  %..47 = getelementptr i32* %..46, i32 2
  %..48 = load i32* %..47
;STOREFOFINHO
  %..49 = extractvalue %.ArrayInt %..44, 1
  %..50 = getelementptr i32* %..49, i32 0
  store i32 %..48, i32* %..50
;RETURN
ret i32 0

  ret i32 0
}


define %.ArrayInt @banana(i32 %.a){
%a  = alloca i32
store i32 %.a, i32* %a  %f2 = alloca %.ArrayInt
  %i = alloca i32

;STORE
;NEWINTARRAY
  %..1 = load i32* %a
  %..2 = call noalias i8* @calloc(i32 %..1, i32 4) nounwind

  %..3 = bitcast i8* %..2 to i32*
  %..4 = insertvalue %.ArrayInt undef, i32 %..1, 0
  %..5 = insertvalue %.ArrayInt %..4, i32* %..3, 1
  store %.ArrayInt %..5, %.ArrayInt* %f2

  %..6 = load i32* %a
  %..7 = icmp sgt i32 %..6, 7
  %..8 = icmp eq i1 1, %..7
  br i1 %..8, label %if.do1, label %if.else1
if.do1:
;STOREARRAY
;ARRAY
      %..9 = load %.ArrayBool* @h
;INDEX
;VALUE
;STOREFOFINHO
      %..10 = extractvalue %.ArrayBool %..9, 1
      %..11 = getelementptr i1* %..10, i32 8
      store i1 1, i1* %..11
;STOREARRAY
;ARRAY
      %..12 = load %.ArrayInt* %f2
;INDEX
;VALUE
;STOREFOFINHO
      %..13 = extractvalue %.ArrayInt %..12, 1
      %..14 = getelementptr i32* %..13, i32 3
      store i32 3, i32* %..14
    br label %if.end1
if.else1:
;STOREARRAY
;ARRAY
      %..15 = load %.ArrayBool* @h
;INDEX
;VALUE
;STOREFOFINHO
      %..16 = extractvalue %.ArrayBool %..15, 1
      %..17 = getelementptr i1* %..16, i32 0
      store i1 0, i1* %..17
;STORE
      store i32 0, i32* %i

br label %while.do2
while.do2:
      %..18 = load i32* %i
      %..19 = icmp slt i32 %..18, 9
      %..20 = icmp eq i1 1, %..19
      br i1 %..20, label %while.continue2, label %while.end2
while.continue2:
          %..21 = load i32* %a
          %..22 = srem i32 %..21 , 2

          %..23 = icmp eq i32 %..22, 0
          %..24 = icmp eq i1 1, %..23
          br i1 %..24, label %if.do3, label %if.else3
if.do3:
;STOREARRAY
;ARRAY
            %..25 = load %.ArrayInt* %f2
;INDEX
            %..26 = load i32* %i
;VALUE
            %..27 = load i32* %a
            %..28 = mul i32 %..27 , 2

            %..29 = load i32* %i
            %..30 = mul i32 %..29 , 7

            %..31 = add i32 %..28 , %..30

;STOREFOFINHO
            %..32 = extractvalue %.ArrayInt %..25, 1
            %..33 = getelementptr i32* %..32, i32 %..26
            store i32 %..31, i32* %..33
            br label %if.end3
if.else3:
          br label %if.end3
if.end3:
;STOREARRAY
;ARRAY
          %..34 = load %.ArrayBool* @h
;INDEX
          %..35 = load i32* %i
;VALUE
;STOREFOFINHO
          %..36 = extractvalue %.ArrayBool %..34, 1
          %..37 = getelementptr i1* %..36, i32 %..35
          store i1 1, i1* %..37
;STORE
          %..38 = load i32* %i
          %..39 = add i32 %..38 , 1

          store i32 %..39, i32* %i

              br label %while.do2
while.end2:
  br label %if.end1
if.end1:
;RETURN
  %..40 = load %.ArrayInt* %f2
  ret %.ArrayInt %..40

  ret %.ArrayInt {i32 0, i32* null}
}

