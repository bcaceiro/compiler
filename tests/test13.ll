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
  %..2 = mul i32 -1 , %..1
  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 %..2)

;PRINT
  %..4 = mul i32 -1 , 1
  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 %..4)

;PRINT
  %..6 = mul i32 -1 , 0
  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 %..6)

;PRINT
  %..8 = mul i32 -1 , 1
  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 %..8)

;PRINT
  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 1)

;PRINT
  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 0)

;PRINT
  %..12 = mul i32 -1 , 1
  %..13 = mul i32 -1 , %..12
  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 %..13)

;PRINT
  %..15 = mul i32 -1 , 1
  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 %..15)

;PRINT
  %..17 = mul i32 -1 , 0
  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 %..17)

;PRINT
  %..19 = mul i32 -1 , 1
  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 %..19)

;PRINT
  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 1)

;PRINT
  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 0)

;PRINT
  %..23 = mul i32 -1 , 1
  %..24 = mul i32 -1 , %..23
  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 %..24)

;PRINT
  %..26 = mul i32 -1 , 1
  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 %..26)

;PRINT
  %..28 = mul i32 -1 , 0
  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 %..28)

;PRINT
  %..30 = mul i32 -1 , 1
  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 %..30)

;PRINT
  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 1)

;PRINT
  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 0)

;PRINT
  %..34 = sub i1 1, 0
  %..35 = zext i1 %..34 to i32
  %..36 = getelementptr inbounds [2 x i8*]* @.printBool, i32 0, i32 %..35
  %..37 = load i8** %..36
  call i32 (i8*, ...)* @printf(i8* %..37)

;PRINT
  %..39 = sub i1 1, 1
  %..40 = zext i1 %..39 to i32
  %..41 = getelementptr inbounds [2 x i8*]* @.printBool, i32 0, i32 %..40
  %..42 = load i8** %..41
  call i32 (i8*, ...)* @printf(i8* %..42)


  ret i32 0
}

