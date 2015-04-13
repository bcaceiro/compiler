declare i32 @printf(i8* noalias nocapture, ...)
declare noalias i8* @calloc(i32, i32) nounwind
declare i32 @atoi(i8*) nounwind readonly
@.printInt = private constant [4 x i8] c"%d\0A\00"
@.true = private constant [6 x i8] c"true\0A\00"
@.false = private constant [7 x i8] c"false\0A\00"
@.printBool = private constant [2 x i8*] [i8* getelementptr inbounds ([7 x i8]* @.false, i32 0, i32 0),i8* getelementptr inbounds ([6 x i8]* @.true, i32 0, i32 0)]

%.ArrayInt = type { i32, i32* }
%.ArrayBool = type { i32, i1* }
@i = global i32 0
@b = global i1 0


define i32 @main(i32 %argc, i8** %args){
  %j = alloca i32

;STORE
  store i32 0, i32* @i

br label %while.do0
while.do0:
  %..1 = load i32* @i
  %..2 = icmp sle i32 %..1, 100
  %..3 = icmp eq i1 1, %..2
  br i1 %..3, label %while.continue0, label %while.end0
while.continue0:
      %..4 = load i32* @i
      %..5 = icmp sgt i32 %..4, 10
      %..6 = alloca i1
      store i1 %..5, i1* %..6
      %..7 = icmp eq i1 1, %..5
      br i1 %..7, label %and.do1, label %and.end1
and.do1:
      %..8 = call i1 @test1()

      store i1 %..8, i1* %..6
      br label %and.end1
and.end1:
      %..9 = load i1* %..6
      %..10 = icmp eq i1 1, %..9
      br i1 %..10, label %if.do2, label %if.else2
if.do2:
        br label %if.end2
if.else2:
      br label %if.end2
if.end2:
;STORE
      store i32 0, i32* %j

br label %while.do3
while.do3:
      %..11 = load i32* %j
      %..12 = icmp sle i32 %..11, 10
      %..13 = icmp eq i1 1, %..12
      br i1 %..13, label %while.continue3, label %while.end3
while.continue3:
;STORE
        %..14 = load i32* %j
        %..15 = add i32 %..14 , 1

        store i32 %..15, i32* %j

              br label %while.do3
while.end3:
      %..16 = load i1* @b
      %..17 = sub i1 1, %..16
      %..18 = icmp eq i1 1, %..17
      br i1 %..18, label %if.do4, label %if.else4
if.do4:
        br label %if.end4
if.else4:
;PRINT
;.LENGTH
        %..19 = sub i32 %argc , 1
        call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 %..19)

      br label %if.end4
if.end4:
;STORE
      %..21 = load i32* @i
      %..22 = add i32 %..21 , 1

      store i32 %..22, i32* @i

      br label %while.do0
while.end0:

  ret i32 0
}


define i1 @test1(){

;PRINT
  %..1 = load i32* @i
  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 %..1)

  %..3 = load i32* @i
  %..4 = icmp sge i32 %..3, 50
  %..5 = icmp eq i1 1, %..4
  br i1 %..5, label %if.do5, label %if.else5
if.do5:
;STORE
      store i1 1, i1* @b

;RETURN
      ret i1 1
    br label %if.end5
if.else5:
;STORE
      store i1 0, i1* @b

;RETURN
      ret i1 0
  br label %if.end5
if.end5:

  ret i1 0
}

