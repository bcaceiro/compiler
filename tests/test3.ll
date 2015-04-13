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

;PRINT
  %..1 = mul i32 -1 , 1
  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 %..1)

;PRINT
  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 0)

;PRINT
  %..4 = mul i32 -1 , 0
  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 %..4)

;PRINT
  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 1)

;PRINT
  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 7)

;PRINT
  %..8 = mul i32 -1 , 7
  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 %..8)

;PRINT
  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 8)

;PRINT
  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 0)

;PRINT
  %..12 = mul i32 -1 , 15
  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 %..12)

;PRINT
  %..14 = mul i32 -1 , 15
  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 %..14)

;PRINT
  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 0)

;PRINT
  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 1)

;PRINT
  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 9)

;PRINT
  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 10)

;PRINT
  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 16)

;PRINT
  %..21 = zext i1 0 to i32
  %..22 = getelementptr inbounds [2 x i8*]* @.printBool, i32 0, i32 %..21
  %..23 = load i8** %..22
  call i32 (i8*, ...)* @printf(i8* %..23)

;PRINT
  %..25 = zext i1 1 to i32
  %..26 = getelementptr inbounds [2 x i8*]* @.printBool, i32 0, i32 %..25
  %..27 = load i8** %..26
  call i32 (i8*, ...)* @printf(i8* %..27)


  ret i32 0
}

