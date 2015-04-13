declare i32 @printf(i8* noalias nocapture, ...)
declare noalias i8* @calloc(i32, i32) nounwind
declare i32 @atoi(i8*) nounwind readonly
@.printInt = private constant [4 x i8] c"%d\0A\00"
@.true = private constant [6 x i8] c"true\0A\00"
@.false = private constant [7 x i8] c"false\0A\00"
@.printBool = private constant [2 x i8*] [i8* getelementptr inbounds ([7 x i8]* @.false, i32 0, i32 0),i8* getelementptr inbounds ([6 x i8]* @.true, i32 0, i32 0)]

%.ArrayInt = type { i32, i32* }
%.ArrayBool = type { i32, i1* }
@a1 = global i32 0
@a2 = global i32 0
@a3 = global i32 0
@a4 = global i32 0
@a5 = global i32 0
@a6 = global i32 0
@a7 = global i32 0
@a8 = global i32 0
@a9 = global i32 0
@a10 = global i32 0
@a11 = global i32 0
@a12 = global i32 0
@a13 = global i32 0
@a14 = global i32 0
@a15 = global i1 0
@a16 = global i1 0


define i32 @main(i32 %argc, i8** %args){

;STORE
  %..1 = mul i32 -1 , 1
  store i32 %..1, i32* @a1

;STORE
  store i32 0, i32* @a2

;STORE
  store i32 1, i32* @a3

;STORE
  store i32 7, i32* @a4

;STORE
  %..2 = mul i32 -1 , 7
  store i32 %..2, i32* @a5

;STORE
  store i32 8, i32* @a6

;STORE
  store i32 0, i32* @a7

;STORE
  %..3 = mul i32 -1 , 15
  store i32 %..3, i32* @a8

;STORE
  %..4 = mul i32 -1 , 15
  store i32 %..4, i32* @a9

;STORE
  store i32 0, i32* @a10

;STORE
  store i32 1, i32* @a11

;STORE
  store i32 9, i32* @a12

;STORE
  store i32 10, i32* @a13

;STORE
  store i32 16, i32* @a14

;STORE
  store i1 0, i1* @a15

;STORE
  store i1 1, i1* @a16


  ret i32 0
}

