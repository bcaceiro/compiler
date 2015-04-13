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
  %b = alloca i1
  %i = alloca i32
  %r = alloca i32
  %lim = alloca i32

;STORE
  store i32 1, i32* %i

;STORE
  store i32 0, i32* %r

;STORE
;PARSEARGS
  %..1 = add i32 1 , 0
  %..2 = getelementptr inbounds i8** %args, i32 %..1
  %..3 = load i8** %..2
  %..4 = call i32 @atoi(i8* %..3) nounwind readonly
  store i32 %..4, i32* %lim

br label %while.do0
while.do0:
  %..5 = load i32* %i
  %..6 = load i32* %lim
  %..7 = icmp sle i32 %..5, %..6
  %..8 = icmp eq i1 1, %..7
  br i1 %..8, label %while.continue0, label %while.end0
while.continue0:
;STORE
      %..9 = load i32* %r
      %..10 = load i32* %i
      %..11 = add i32 %..9 , %..10

      store i32 %..11, i32* %r

;STORE
      %..12 = load i32* %i
      %..13 = add i32 %..12 , 1

      store i32 %..13, i32* %i

      br label %while.do0
while.end0:
;PRINT
  %..14 = load i32* %r
  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 %..14)

;STORE
  store i1 0, i1* %b

br label %while.do1
while.do1:
  %..16 = load i1* %b
  %..17 = icmp eq i1 1, %..16
  br i1 %..17, label %while.continue1, label %while.end1
while.continue1:
      br label %while.do1
while.end1:

  ret i32 0
}

