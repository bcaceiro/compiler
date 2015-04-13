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
@e = global i1 0
@f = global i1 0
@g = global i1 0


define i32 @main(i32 %argc, i8** %args){
  %a = alloca i32
  %b = alloca i32
  %e = alloca i1

;STORE
  %..1 = mul i32 -1 , 1
  store i32 %..1, i32* %a

;STORE
  store i32 7, i32* %b

;STORE
  store i1 1, i1* %e

;PRINT
  %..2 = load i32* %a
  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 %..2)

;PRINT
  %..4 = load i32* %b
  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 %..4)

;PRINT
  %..6 = load i32* @c
  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 %..6)

;PRINT
  %..8 = load i1* %e
  %..9 = zext i1 %..8 to i32
  %..10 = getelementptr inbounds [2 x i8*]* @.printBool, i32 0, i32 %..9
  %..11 = load i8** %..10
  call i32 (i8*, ...)* @printf(i8* %..11)

;PRINT
  %..13 = load i1* @f
  %..14 = zext i1 %..13 to i32
  %..15 = getelementptr inbounds [2 x i8*]* @.printBool, i32 0, i32 %..14
  %..16 = load i8** %..15
  call i32 (i8*, ...)* @printf(i8* %..16)

;PRINT
  %..18 = load i1* @g
  %..19 = zext i1 %..18 to i32
  %..20 = getelementptr inbounds [2 x i8*]* @.printBool, i32 0, i32 %..19
  %..21 = load i8** %..20
  call i32 (i8*, ...)* @printf(i8* %..21)


  ret i32 0
}

