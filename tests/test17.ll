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
  %b1 = alloca i1
  %b2 = alloca i1

;STORE
  store i1 1, i1* %b1

;STORE
  store i1 0, i1* %b2

  %..1 = load i1* %b1
  %..2 = icmp eq i1 1, %..1
  br i1 %..2, label %if.do0, label %if.else0
if.do0:
;PRINT
    call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 0)

    br label %if.end0
if.else0:
  br label %if.end0
if.end0:
  %..4 = load i1* %b2
  %..5 = icmp eq i1 1, %..4
  br i1 %..5, label %if.do1, label %if.else1
if.do1:
;PRINT
    call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 1)

    br label %if.end1
if.else1:
  br label %if.end1
if.end1:
  %..7 = load i1* %b1
  %..8 = icmp eq i1 1, %..7
  br i1 %..8, label %if.do2, label %if.else2
if.do2:
;PRINT
    call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 2)

    br label %if.end2
if.else2:
;PRINT
    call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 3)

  br label %if.end2
if.end2:
  %..11 = load i1* %b2
  %..12 = icmp eq i1 1, %..11
  br i1 %..12, label %if.do3, label %if.else3
if.do3:
;PRINT
    call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 4)

    br label %if.end3
if.else3:
;PRINT
    call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 5)

  br label %if.end3
if.end3:
  %..15 = load i1* %b1
  %..16 = icmp eq i1 1, %..15
  br i1 %..16, label %if.do4, label %if.else4
if.do4:
    br label %if.end4
if.else4:
  br label %if.end4
if.end4:
  %..17 = load i1* %b2
  %..18 = icmp eq i1 1, %..17
  br i1 %..18, label %if.do5, label %if.else5
if.do5:
    br label %if.end5
if.else5:
  br label %if.end5
if.end5:
  %..19 = load i1* %b1
  %..20 = icmp eq i1 1, %..19
  br i1 %..20, label %if.do6, label %if.else6
if.do6:
    br label %if.end6
if.else6:
  br label %if.end6
if.end6:
  %..21 = load i1* %b2
  %..22 = icmp eq i1 1, %..21
  br i1 %..22, label %if.do7, label %if.else7
if.do7:
    br label %if.end7
if.else7:
  br label %if.end7
if.end7:
  %..23 = load i1* %b1
  %..24 = icmp eq i1 1, %..23
  br i1 %..24, label %if.do8, label %if.else8
if.do8:
;PRINT
    call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 6)

    br label %if.end8
if.else8:
  br label %if.end8
if.end8:
  %..26 = load i1* %b2
  %..27 = icmp eq i1 1, %..26
  br i1 %..27, label %if.do9, label %if.else9
if.do9:
;PRINT
    call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 7)

    br label %if.end9
if.else9:
  br label %if.end9
if.end9:
  %..29 = load i1* %b1
  %..30 = icmp eq i1 1, %..29
  br i1 %..30, label %if.do10, label %if.else10
if.do10:
    br label %if.end10
if.else10:
;PRINT
    call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 8)

  br label %if.end10
if.end10:
  %..32 = load i1* %b2
  %..33 = icmp eq i1 1, %..32
  br i1 %..33, label %if.do11, label %if.else11
if.do11:
    br label %if.end11
if.else11:
;PRINT
    call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 9)

  br label %if.end11
if.end11:

  ret i32 0
}

