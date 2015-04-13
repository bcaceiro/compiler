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
  %a = alloca i32
  %b = alloca i32
  %c = alloca i32
  %d = alloca i32
  %e = alloca i32
  %f = alloca i32
  %g = alloca i32
  %h = alloca i32
  %i = alloca i32
  %j = alloca i32
  %k = alloca i32
  %l = alloca i32

;STORE
  store i1 0, i1* %b1

;STORE
  store i1 1, i1* %b2

;STORE
  %..1 = mul i32 -1 , 1
  store i32 %..1, i32* %a

;STORE
  store i32 1, i32* %b

;STORE
  store i32 0, i32* %c

;STORE
  %..2 = mul i32 -1 , 1
  store i32 %..2, i32* %d

;STORE
  store i32 1, i32* %e

;STORE
  store i32 0, i32* %f

;STORE
  %..3 = mul i32 -1 , 1
  store i32 %..3, i32* %g

;STORE
  store i32 1, i32* %h

;STORE
  store i32 0, i32* %i

;PRINT
  %..4 = load i32* %a
  %..5 = mul i32 -1 , %..4
  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 %..5)

;PRINT
  %..7 = load i32* %b
  %..8 = mul i32 -1 , %..7
  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 %..8)

;PRINT
  %..10 = load i32* %c
  %..11 = mul i32 -1 , %..10
  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 %..11)

;PRINT
  %..13 = load i32* %a
  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 %..13)

;PRINT
  %..15 = load i32* %b
  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 %..15)

;PRINT
  %..17 = load i32* %c
  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 %..17)

;PRINT
  %..19 = load i32* %d
  %..20 = mul i32 -1 , %..19
  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 %..20)

;PRINT
  %..22 = load i32* %e
  %..23 = mul i32 -1 , %..22
  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 %..23)

;PRINT
  %..25 = load i32* %f
  %..26 = mul i32 -1 , %..25
  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 %..26)

;PRINT
  %..28 = load i32* %d
  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 %..28)

;PRINT
  %..30 = load i32* %e
  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 %..30)

;PRINT
  %..32 = load i32* %f
  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 %..32)

;PRINT
  %..34 = load i32* %g
  %..35 = mul i32 -1 , %..34
  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 %..35)

;PRINT
  %..37 = load i32* %h
  %..38 = mul i32 -1 , %..37
  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 %..38)

;PRINT
  %..40 = load i32* %i
  %..41 = mul i32 -1 , %..40
  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 %..41)

;PRINT
  %..43 = load i32* %g
  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 %..43)

;PRINT
  %..45 = load i32* %h
  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 %..45)

;PRINT
  %..47 = load i32* %i
  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 %..47)

;PRINT
  %..49 = load i1* %b1
  %..50 = sub i1 1, %..49
  %..51 = zext i1 %..50 to i32
  %..52 = getelementptr inbounds [2 x i8*]* @.printBool, i32 0, i32 %..51
  %..53 = load i8** %..52
  call i32 (i8*, ...)* @printf(i8* %..53)

;PRINT
  %..55 = load i1* %b2
  %..56 = sub i1 1, %..55
  %..57 = zext i1 %..56 to i32
  %..58 = getelementptr inbounds [2 x i8*]* @.printBool, i32 0, i32 %..57
  %..59 = load i8** %..58
  call i32 (i8*, ...)* @printf(i8* %..59)


  ret i32 0
}

