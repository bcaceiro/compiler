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


define i32 @main(i32 %argc, i8** %args){
  %f = alloca i32
  %g = alloca i32
  %h = alloca i32
  %i = alloca i32
  %j = alloca i32

;STORE
;PARSEARGS
  %..1 = add i32 1 , 0
  %..2 = getelementptr inbounds i8** %args, i32 %..1
  %..3 = load i8** %..2
  %..4 = call i32 @atoi(i8* %..3) nounwind readonly
  store i32 %..4, i32* @a

;STORE
;PARSEARGS
  %..5 = add i32 1 , 1
  %..6 = getelementptr inbounds i8** %args, i32 %..5
  %..7 = load i8** %..6
  %..8 = call i32 @atoi(i8* %..7) nounwind readonly
  store i32 %..8, i32* @b

;STORE
;PARSEARGS
  %..9 = add i32 1 , 2
  %..10 = getelementptr inbounds i8** %args, i32 %..9
  %..11 = load i8** %..10
  %..12 = call i32 @atoi(i8* %..11) nounwind readonly
  store i32 %..12, i32* @c

;STORE
;PARSEARGS
  %..13 = add i32 1 , 3
  %..14 = getelementptr inbounds i8** %args, i32 %..13
  %..15 = load i8** %..14
  %..16 = call i32 @atoi(i8* %..15) nounwind readonly
  store i32 %..16, i32* @d

;STORE
;PARSEARGS
  %..17 = add i32 1 , 4
  %..18 = getelementptr inbounds i8** %args, i32 %..17
  %..19 = load i8** %..18
  %..20 = call i32 @atoi(i8* %..19) nounwind readonly
  store i32 %..20, i32* @e

;STORE
;PARSEARGS
  %..21 = add i32 1 , 5
  %..22 = getelementptr inbounds i8** %args, i32 %..21
  %..23 = load i8** %..22
  %..24 = call i32 @atoi(i8* %..23) nounwind readonly
  store i32 %..24, i32* %f

;STORE
;PARSEARGS
  %..25 = add i32 1 , 6
  %..26 = getelementptr inbounds i8** %args, i32 %..25
  %..27 = load i8** %..26
  %..28 = call i32 @atoi(i8* %..27) nounwind readonly
  store i32 %..28, i32* %g

;STORE
;PARSEARGS
  %..29 = add i32 1 , 7
  %..30 = getelementptr inbounds i8** %args, i32 %..29
  %..31 = load i8** %..30
  %..32 = call i32 @atoi(i8* %..31) nounwind readonly
  store i32 %..32, i32* %h

;STORE
;PARSEARGS
  %..33 = add i32 1 , 8
  %..34 = getelementptr inbounds i8** %args, i32 %..33
  %..35 = load i8** %..34
  %..36 = call i32 @atoi(i8* %..35) nounwind readonly
  store i32 %..36, i32* %i

;STORE
;PARSEARGS
  %..37 = add i32 1 , 9
  %..38 = getelementptr inbounds i8** %args, i32 %..37
  %..39 = load i8** %..38
  %..40 = call i32 @atoi(i8* %..39) nounwind readonly
  store i32 %..40, i32* %j

;PRINT
  %..41 = load i32* @a
  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 %..41)

;PRINT
  %..43 = load i32* @b
  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 %..43)

;PRINT
  %..45 = load i32* @c
  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 %..45)

;PRINT
  %..47 = load i32* @d
  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 %..47)

;PRINT
  %..49 = load i32* @e
  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 %..49)

;PRINT
  %..51 = load i32* %f
  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 %..51)

;PRINT
  %..53 = load i32* %g
  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 %..53)

;PRINT
  %..55 = load i32* %h
  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 %..55)

;PRINT
  %..57 = load i32* %i
  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 %..57)

;PRINT
  %..59 = load i32* %j
  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 %..59)


  ret i32 0
}

