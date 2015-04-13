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
@d = global i32 0
@e = global i32 0
@k = global i1 0
@l = global i1 0
@m = global i1 0
@n = global i1 0


define i32 @main(i32 %argc, i8** %args){
  %f = alloca i32
  %g = alloca i32
  %h = alloca i32
  %i = alloca i32
  %j = alloca i32

;STORE
  store i32 1, i32* @a

;STORE
  store i32 2, i32* @b

;STORE
  store i32 3, i32* @c

;STORE
  store i32 4, i32* @d

;STORE
  store i32 5, i32* @e

;STORE
  store i32 6, i32* %f

;STORE
  store i32 7, i32* %g

;STORE
  store i32 8, i32* %h

;STORE
  store i32 9, i32* %i

;STORE
  store i32 10, i32* %j

;STORE
  store i1 0, i1* @k

;STORE
  store i1 1, i1* @l

;STORE
  store i1 0, i1* @m

;STORE
  store i1 1, i1* @n

;STORE
  %..1 = mul i32 -1 , 1
  store i32 %..1, i32* @a

;STORE
  %..2 = mul i32 -1 , 2
  store i32 %..2, i32* @b

;STORE
  %..3 = mul i32 -1 , 3
  store i32 %..3, i32* @c

;STORE
  %..4 = mul i32 -1 , 4
  store i32 %..4, i32* @d

;STORE
  %..5 = mul i32 -1 , 5
  store i32 %..5, i32* @e

;STORE
  %..6 = mul i32 -1 , 6
  store i32 %..6, i32* %f

;STORE
  %..7 = mul i32 -1 , 7
  store i32 %..7, i32* %g

;STORE
  %..8 = mul i32 -1 , 8
  store i32 %..8, i32* %h

;STORE
  %..9 = mul i32 -1 , 9
  store i32 %..9, i32* %i

;STORE
  %..10 = mul i32 -1 , 10
  store i32 %..10, i32* %j

;STORE
  store i1 1, i1* @k

;STORE
  store i1 0, i1* @l

;STORE
  store i1 1, i1* @m

;STORE
  store i1 0, i1* @n

;PRINT
  %..11 = load i32* @a
  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 %..11)

;PRINT
  %..13 = load i32* @b
  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 %..13)

;PRINT
  %..15 = load i32* @c
  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 %..15)

;PRINT
  %..17 = load i32* @d
  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 %..17)

;PRINT
  %..19 = load i32* @e
  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 %..19)

;PRINT
  %..21 = load i32* %f
  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 %..21)

;PRINT
  %..23 = load i32* %g
  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 %..23)

;PRINT
  %..25 = load i32* %h
  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 %..25)

;PRINT
  %..27 = load i32* %i
  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 %..27)

;PRINT
  %..29 = load i32* %j
  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 %..29)

;PRINT
  %..31 = load i1* @k
  %..32 = zext i1 %..31 to i32
  %..33 = getelementptr inbounds [2 x i8*]* @.printBool, i32 0, i32 %..32
  %..34 = load i8** %..33
  call i32 (i8*, ...)* @printf(i8* %..34)

;PRINT
  %..36 = load i1* @l
  %..37 = zext i1 %..36 to i32
  %..38 = getelementptr inbounds [2 x i8*]* @.printBool, i32 0, i32 %..37
  %..39 = load i8** %..38
  call i32 (i8*, ...)* @printf(i8* %..39)

;PRINT
  %..41 = load i1* @m
  %..42 = zext i1 %..41 to i32
  %..43 = getelementptr inbounds [2 x i8*]* @.printBool, i32 0, i32 %..42
  %..44 = load i8** %..43
  call i32 (i8*, ...)* @printf(i8* %..44)

;PRINT
  %..46 = load i1* @n
  %..47 = zext i1 %..46 to i32
  %..48 = getelementptr inbounds [2 x i8*]* @.printBool, i32 0, i32 %..47
  %..49 = load i8** %..48
  call i32 (i8*, ...)* @printf(i8* %..49)


  ret i32 0
}

