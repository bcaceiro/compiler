declare i32 @printf(i8* noalias nocapture, ...)
declare noalias i8* @calloc(i32, i32) nounwind
declare i32 @atoi(i8*) nounwind readonly
@.printInt = private constant [4 x i8] c"%d\0A\00"
@.true = private constant [6 x i8] c"true\0A\00"
@.false = private constant [7 x i8] c"false\0A\00"
@.printBool = private constant [2 x i8*] [i8* getelementptr inbounds ([7 x i8]* @.false, i32 0, i32 0),i8* getelementptr inbounds ([6 x i8]* @.true, i32 0, i32 0)]

%.ArrayInt = type { i32, i32* }
%.ArrayBool = type { i32, i1* }


define i32 @main(i32 %argc, i8** %args){
  %a = alloca i32
  %b = alloca i32
  %a2 = alloca %.ArrayInt
  %b2 = alloca %.ArrayInt
  %c = alloca i1
  %d = alloca i1
  %c2 = alloca %.ArrayBool
  %d2 = alloca %.ArrayBool

;STORE
  %..1 = call i32 @test1()

  store i32 %..1, i32* %a

;STORE
    %..2 = load i32* %a
  %..3 = mul i32 -1 , 1
%..4 = call i32 @test2( i32 %..2 , i32 %..3 )

  store i32 %..4, i32* %b

;STORE
  %..5 = call i1 @test3()

  store i1 %..5, i1* %c

;STORE
  %..6 = call i1 @test4()

  store i1 %..6, i1* %d

;STORE
  %..7 = call %.ArrayInt @test5()

  store %.ArrayInt %..7, %.ArrayInt* %a2

;STORE
  %..8 = call %.ArrayInt @test6()

  store %.ArrayInt %..8, %.ArrayInt* %b2

;STORE
  %..9 = call %.ArrayBool @test7()

  store %.ArrayBool %..9, %.ArrayBool* %c2

;STORE
  %..10 = call %.ArrayBool @test8()

  store %.ArrayBool %..10, %.ArrayBool* %d2

;PRINT
  %..11 = load i32* %a
  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 %..11)

;PRINT
  %..13 = load i32* %b
  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 %..13)

;PRINT
  %..15 = load i1* %c
  %..16 = zext i1 %..15 to i32
  %..17 = getelementptr inbounds [2 x i8*]* @.printBool, i32 0, i32 %..16
  %..18 = load i8** %..17
  call i32 (i8*, ...)* @printf(i8* %..18)

;PRINT
  %..20 = load i1* %d
  %..21 = zext i1 %..20 to i32
  %..22 = getelementptr inbounds [2 x i8*]* @.printBool, i32 0, i32 %..21
  %..23 = load i8** %..22
  call i32 (i8*, ...)* @printf(i8* %..23)

;PRINT
;LOADARRAY
  %..25 = load %.ArrayInt* %b2
  %..26 = extractvalue %.ArrayInt %..25, 1
  %..27 = getelementptr i32* %..26, i32 0
  %..28 = load i32* %..27
  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 %..28)

;PRINT
;LOADARRAY
  %..30 = load %.ArrayBool* %d2
  %..31 = extractvalue %.ArrayBool %..30, 1
  %..32 = getelementptr i1* %..31, i32 0
  %..33 = load i1* %..32
  %..34 = zext i1 %..33 to i32
  %..35 = getelementptr inbounds [2 x i8*]* @.printBool, i32 0, i32 %..34
  %..36 = load i8** %..35
  call i32 (i8*, ...)* @printf(i8* %..36)

;PRINT
;LOADARRAY
  %..38 = load %.ArrayBool* %d2
  %..39 = extractvalue %.ArrayBool %..38, 1
  %..40 = getelementptr i1* %..39, i32 1
  %..41 = load i1* %..40
  %..42 = zext i1 %..41 to i32
  %..43 = getelementptr inbounds [2 x i8*]* @.printBool, i32 0, i32 %..42
  %..44 = load i8** %..43
  call i32 (i8*, ...)* @printf(i8* %..44)


  ret i32 0
}


define i32 @test1(){

;RETURN
  ret i32 1

  ret i32 0
}


define i32 @test2(i32 %.a,i32 %.b){
%b  = alloca i32
store i32 %.b, i32* %b%a  = alloca i32
store i32 %.a, i32* %a
;RETURN
  %..1 = load i32* %a
  %..2 = load i32* %b
  %..3 = add i32 %..1 , %..2

  ret i32 %..3

  ret i32 0
}


define i1 @test3(){

;RETURN
  ret i1 1

  ret i1 0
}


define i1 @test4(){

;RETURN
  ret i1 0

  ret i1 0
}


define %.ArrayInt @test5(){

;RETURN
;NEWINTARRAY
  %..1 = call noalias i8* @calloc(i32 2, i32 4) nounwind

  %..2 = bitcast i8* %..1 to i32*
  %..3 = insertvalue %.ArrayInt undef, i32 2, 0
  %..4 = insertvalue %.ArrayInt %..3, i32* %..2, 1
  ret %.ArrayInt %..4

  ret %.ArrayInt {i32 0, i32* null}
}


define %.ArrayInt @test6(){
  %b = alloca %.ArrayInt

;STORE
;NEWINTARRAY
  %..1 = call noalias i8* @calloc(i32 1, i32 4) nounwind

  %..2 = bitcast i8* %..1 to i32*
  %..3 = insertvalue %.ArrayInt undef, i32 1, 0
  %..4 = insertvalue %.ArrayInt %..3, i32* %..2, 1
  store %.ArrayInt %..4, %.ArrayInt* %b

;STOREARRAY
;ARRAY
  %..5 = load %.ArrayInt* %b
;INDEX
;VALUE
;STOREFOFINHO
  %..6 = extractvalue %.ArrayInt %..5, 1
  %..7 = getelementptr i32* %..6, i32 0
  store i32 127, i32* %..7
;RETURN
  %..8 = load %.ArrayInt* %b
  ret %.ArrayInt %..8

  ret %.ArrayInt {i32 0, i32* null}
}


define %.ArrayBool @test7(){

;RETURN
;NEWBOOLARRAY
  %..1 = call noalias i8* @calloc(i32 0, i32 1) nounwind

  %..2 = bitcast i8* %..1 to i1*
  %..3 = insertvalue %.ArrayBool undef, i32 0, 0
  %..4 = insertvalue %.ArrayBool %..3, i1* %..2, 1
  ret %.ArrayBool %..4

  ret %.ArrayBool {i32 0, i1* null}
}


define %.ArrayBool @test8(){
  %a = alloca %.ArrayBool

;STORE
;NEWBOOLARRAY
  %..1 = call noalias i8* @calloc(i32 7, i32 1) nounwind

  %..2 = bitcast i8* %..1 to i1*
  %..3 = insertvalue %.ArrayBool undef, i32 7, 0
  %..4 = insertvalue %.ArrayBool %..3, i1* %..2, 1
  store %.ArrayBool %..4, %.ArrayBool* %a

;STOREARRAY
;ARRAY
  %..5 = load %.ArrayBool* %a
;INDEX
;VALUE
;STOREFOFINHO
  %..6 = extractvalue %.ArrayBool %..5, 1
  %..7 = getelementptr i1* %..6, i32 0
  store i1 0, i1* %..7
;STOREARRAY
;ARRAY
  %..8 = load %.ArrayBool* %a
;INDEX
;VALUE
;STOREFOFINHO
  %..9 = extractvalue %.ArrayBool %..8, 1
  %..10 = getelementptr i1* %..9, i32 1
  store i1 1, i1* %..10
;RETURN
  %..11 = load %.ArrayBool* %a
  ret %.ArrayBool %..11

  ret %.ArrayBool {i32 0, i1* null}
}

