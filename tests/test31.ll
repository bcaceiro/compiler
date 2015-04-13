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
  %a = alloca i32
  %e = alloca i32
  %b = alloca %.ArrayInt
  %c = alloca i1
  %d = alloca %.ArrayBool

;STORE
  store i32 1, i32* %a

;STORE
;NEWINTARRAY
  %..1 = call noalias i8* @calloc(i32 2, i32 4) nounwind

  %..2 = bitcast i8* %..1 to i32*
  %..3 = insertvalue %.ArrayInt undef, i32 2, 0
  %..4 = insertvalue %.ArrayInt %..3, i32* %..2, 1
  store %.ArrayInt %..4, %.ArrayInt* %b

;STOREARRAY
;ARRAY
  %..5 = load %.ArrayInt* %b
;INDEX
;VALUE
  %..6 = mul i32 -1 , 1
;STOREFOFINHO
  %..7 = extractvalue %.ArrayInt %..5, 1
  %..8 = getelementptr i32* %..7, i32 0
  store i32 %..6, i32* %..8
;STOREARRAY
;ARRAY
  %..9 = load %.ArrayInt* %b
;INDEX
;VALUE
;STOREFOFINHO
  %..10 = extractvalue %.ArrayInt %..9, 1
  %..11 = getelementptr i32* %..10, i32 1
  store i32 1, i32* %..11
;STORE
  store i1 1, i1* %c

;STORE
;NEWBOOLARRAY
  %..12 = call noalias i8* @calloc(i32 2, i32 1) nounwind

  %..13 = bitcast i8* %..12 to i1*
  %..14 = insertvalue %.ArrayBool undef, i32 2, 0
  %..15 = insertvalue %.ArrayBool %..14, i1* %..13, 1
  store %.ArrayBool %..15, %.ArrayBool* %d

;STOREARRAY
;ARRAY
  %..16 = load %.ArrayBool* %d
;INDEX
;VALUE
;STOREFOFINHO
  %..17 = extractvalue %.ArrayBool %..16, 1
  %..18 = getelementptr i1* %..17, i32 0
  store i1 0, i1* %..18
;STOREARRAY
;ARRAY
  %..19 = load %.ArrayBool* %d
;INDEX
;VALUE
;STOREFOFINHO
  %..20 = extractvalue %.ArrayBool %..19, 1
  %..21 = getelementptr i1* %..20, i32 1
  store i1 1, i1* %..21
;STORE
    %..22 = load i32* %a
  %..23 = load %.ArrayInt* %b
  %..24 = load i1* %c
  %..25 = load %.ArrayBool* %d
%..26 = call i32 @test1( i32 %..22 , %.ArrayInt %..23 , i1 %..24 , %.ArrayBool %..25 )

  store i32 %..26, i32* %e


  ret i32 0
}


define i32 @test1(i32 %.a,%.ArrayInt %.b,i1 %.c,%.ArrayBool %.d){
%d  = alloca %.ArrayBool
store %.ArrayBool %.d, %.ArrayBool* %d%c  = alloca i1
store i1 %.c, i1* %c%b  = alloca %.ArrayInt
store %.ArrayInt %.b, %.ArrayInt* %b%a  = alloca i32
store i32 %.a, i32* %a
;STORE
  %..1 = load i32* %a
  %..2 = mul i32 -1 , %..1
  store i32 %..2, i32* %a

;STORE
;NEWINTARRAY
  %..3 = call noalias i8* @calloc(i32 2, i32 4) nounwind

  %..4 = bitcast i8* %..3 to i32*
  %..5 = insertvalue %.ArrayInt undef, i32 2, 0
  %..6 = insertvalue %.ArrayInt %..5, i32* %..4, 1
  store %.ArrayInt %..6, %.ArrayInt* %b

;STORE
  %..7 = load i1* %c
  %..8 = sub i1 1, %..7
  store i1 %..8, i1* %c

;STORE
;NEWBOOLARRAY
  %..9 = call noalias i8* @calloc(i32 2, i32 1) nounwind

  %..10 = bitcast i8* %..9 to i1*
  %..11 = insertvalue %.ArrayBool undef, i32 2, 0
  %..12 = insertvalue %.ArrayBool %..11, i1* %..10, 1
  store %.ArrayBool %..12, %.ArrayBool* %d

;RETURN
  ret i32 0

  ret i32 0
}

