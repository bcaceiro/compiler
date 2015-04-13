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

  %..1 = alloca i1
  store i1 1, i1* %..1
  %..2 = icmp eq i1 1, 1
  br i1 %..2, label %and.do0, label %and.end0
and.do0:
  store i1 1, i1* %..1
  br label %and.end0
and.end0:
  %..3 = load i1* %..1
  %..4 = alloca i1
  store i1 %..3, i1* %..4
  %..5 = icmp eq i1 1, %..3
  br i1 %..5, label %and.do1, label %and.end1
and.do1:
  store i1 1, i1* %..4
  br label %and.end1
and.end1:
  %..6 = load i1* %..4
  %..7 = alloca i1
  store i1 %..6, i1* %..7
  %..8 = icmp eq i1 1, %..6
  br i1 %..8, label %and.do2, label %and.end2
and.do2:
  store i1 1, i1* %..7
  br label %and.end2
and.end2:
  %..9 = load i1* %..7
  %..10 = alloca i1
  store i1 %..9, i1* %..10
  %..11 = icmp eq i1 1, %..9
  br i1 %..11, label %and.do3, label %and.end3
and.do3:
  store i1 1, i1* %..10
  br label %and.end3
and.end3:
  %..12 = load i1* %..10
  %..13 = alloca i1
  store i1 %..12, i1* %..13
  %..14 = icmp eq i1 0, %..12
  br i1 %..14, label %and.do4, label %and.end4
and.do4:
  %..15 = alloca i1
  store i1 0, i1* %..15
  %..16 = icmp eq i1 1, 0
  br i1 %..16, label %and.do5, label %and.end5
and.do5:
  %..17 = call i1 @test2()

  store i1 %..17, i1* %..15
  br label %and.end5
and.end5:
  %..18 = load i1* %..15
  store i1 %..18, i1* %..13
  br label %and.end4
and.end4:
  %..19 = load i1* %..13
  %..20 = icmp eq i1 1, %..19
  br i1 %..20, label %if.do6, label %if.else6
if.do6:
;PRINT
    call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 666)

    br label %if.end6
if.else6:
  br label %if.end6
if.end6:

  ret i32 0
}


define i1 @test1(){
  %b1 = alloca i1
  %b2 = alloca i1

;STORE
  store i1 1, i1* %b1

;STORE
  store i1 0, i1* %b2

;RETURN
  %..1 = load i1* %b1
  %..2 = alloca i1
  store i1 %..1, i1* %..2
  %..3 = icmp eq i1 0, %..1
  br i1 %..3, label %and.do7, label %and.end7
and.do7:
  %..4 = load i1* %b2
  %..5 = alloca i1
  store i1 %..4, i1* %..5
  %..6 = icmp eq i1 1, %..4
  br i1 %..6, label %and.do8, label %and.end8
and.do8:
  %..7 = load i1* %b1
  store i1 %..7, i1* %..5
  br label %and.end8
and.end8:
  %..8 = load i1* %..5
  %..9 = alloca i1
  store i1 %..8, i1* %..9
  %..10 = icmp eq i1 1, %..8
  br i1 %..10, label %and.do9, label %and.end9
and.do9:
  %..11 = load i1* %b2
  store i1 %..11, i1* %..9
  br label %and.end9
and.end9:
  %..12 = load i1* %..9
  store i1 %..12, i1* %..2
  br label %and.end7
and.end7:
  %..13 = load i1* %..2
  ret i1 %..13

  ret i1 0
}


define i1 @test2(){

;PRINT
  %..1 = zext i1 1 to i32
  %..2 = getelementptr inbounds [2 x i8*]* @.printBool, i32 0, i32 %..1
  %..3 = load i8** %..2
  call i32 (i8*, ...)* @printf(i8* %..3)

;RETURN
  ret i1 0

  ret i1 0
}

