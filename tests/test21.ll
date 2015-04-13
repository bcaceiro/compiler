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
  %c = alloca i1
  %d = alloca i1

;STORE
  %..1 = alloca i1
  store i1 1, i1* %..1
  %..2 = icmp eq i1 1, 1
  br i1 %..2, label %and.do0, label %and.end0
and.do0:
  %..3 = call i1 @test1()

  store i1 %..3, i1* %..1
  br label %and.end0
and.end0:
  %..4 = load i1* %..1
  store i1 %..4, i1* %c

;STORE
  %..5 = alloca i1
  store i1 0, i1* %..5
  %..6 = icmp eq i1 1, 0
  br i1 %..6, label %and.do1, label %and.end1
and.do1:
  %..7 = call i1 @test1()

  store i1 %..7, i1* %..5
  br label %and.end1
and.end1:
  %..8 = load i1* %..5
  store i1 %..8, i1* %d

;STORE
  %..9 = alloca i1
  store i1 1, i1* %..9
  %..10 = icmp eq i1 1, 1
  br i1 %..10, label %and.do2, label %and.end2
and.do2:
  %..11 = call i1 @test2()

  store i1 %..11, i1* %..9
  br label %and.end2
and.end2:
  %..12 = load i1* %..9
  store i1 %..12, i1* %c

;STORE
  %..13 = alloca i1
  store i1 0, i1* %..13
  %..14 = icmp eq i1 1, 0
  br i1 %..14, label %and.do3, label %and.end3
and.do3:
  %..15 = call i1 @test2()

  store i1 %..15, i1* %..13
  br label %and.end3
and.end3:
  %..16 = load i1* %..13
  store i1 %..16, i1* %d

;STORE
  %..17 = alloca i1
  store i1 0, i1* %..17
  %..18 = icmp eq i1 1, 0
  br i1 %..18, label %and.do4, label %and.end4
and.do4:
  %..19 = call i1 @test1()

  store i1 %..19, i1* %..17
  br label %and.end4
and.end4:
  %..20 = load i1* %..17
  store i1 %..20, i1* %c

;STORE
  %..21 = alloca i1
  store i1 1, i1* %..21
  %..22 = icmp eq i1 1, 1
  br i1 %..22, label %and.do5, label %and.end5
and.do5:
  %..23 = call i1 @test1()

  store i1 %..23, i1* %..21
  br label %and.end5
and.end5:
  %..24 = load i1* %..21
  store i1 %..24, i1* %d

;STORE
  %..25 = alloca i1
  store i1 0, i1* %..25
  %..26 = icmp eq i1 1, 0
  br i1 %..26, label %and.do6, label %and.end6
and.do6:
  %..27 = call i1 @test2()

  store i1 %..27, i1* %..25
  br label %and.end6
and.end6:
  %..28 = load i1* %..25
  store i1 %..28, i1* %c

;STORE
  %..29 = alloca i1
  store i1 1, i1* %..29
  %..30 = icmp eq i1 1, 1
  br i1 %..30, label %and.do7, label %and.end7
and.do7:
  %..31 = call i1 @test2()

  store i1 %..31, i1* %..29
  br label %and.end7
and.end7:
  %..32 = load i1* %..29
  store i1 %..32, i1* %d


  ret i32 0
}


define i1 @test1(){

;PRINT
  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 1)

;RETURN
  ret i1 1

  ret i1 0
}


define i1 @test2(){

;PRINT
  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 2)

;RETURN
  ret i1 0

  ret i1 0
}

