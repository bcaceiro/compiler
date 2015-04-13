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
  %a1 = alloca %.ArrayInt
  %a2 = alloca %.ArrayInt
  %b1 = alloca %.ArrayBool
  %b2 = alloca %.ArrayBool

;STORE
;NEWINTARRAY
  %..1 = call noalias i8* @calloc(i32 3, i32 4) nounwind

  %..2 = bitcast i8* %..1 to i32*
  %..3 = insertvalue %.ArrayInt undef, i32 3, 0
  %..4 = insertvalue %.ArrayInt %..3, i32* %..2, 1
  store %.ArrayInt %..4, %.ArrayInt* %a1

;STORE
;NEWINTARRAY
  %..5 = call noalias i8* @calloc(i32 0, i32 4) nounwind

  %..6 = bitcast i8* %..5 to i32*
  %..7 = insertvalue %.ArrayInt undef, i32 0, 0
  %..8 = insertvalue %.ArrayInt %..7, i32* %..6, 1
  store %.ArrayInt %..8, %.ArrayInt* %a2

;STORE
;NEWBOOLARRAY
  %..9 = call noalias i8* @calloc(i32 4, i32 1) nounwind

  %..10 = bitcast i8* %..9 to i1*
  %..11 = insertvalue %.ArrayBool undef, i32 4, 0
  %..12 = insertvalue %.ArrayBool %..11, i1* %..10, 1
  store %.ArrayBool %..12, %.ArrayBool* %b1

;STORE
;NEWBOOLARRAY
  %..13 = call noalias i8* @calloc(i32 0, i32 1) nounwind

  %..14 = bitcast i8* %..13 to i1*
  %..15 = insertvalue %.ArrayBool undef, i32 0, 0
  %..16 = insertvalue %.ArrayBool %..15, i1* %..14, 1
  store %.ArrayBool %..16, %.ArrayBool* %b2

;PRINT
;.LENGTH
  %..17 = load %.ArrayInt* %a1
  %..18 = extractvalue %.ArrayInt %..17, 0
  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 %..18)

;PRINT
;.LENGTH
  %..20 = load %.ArrayInt* %a2
  %..21 = extractvalue %.ArrayInt %..20, 0
  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 %..21)

;PRINT
;.LENGTH
  %..23 = load %.ArrayBool* %b1
  %..24 = extractvalue %.ArrayBool %..23, 0
  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 %..24)

;PRINT
;.LENGTH
  %..26 = load %.ArrayBool* %b2
  %..27 = extractvalue %.ArrayBool %..26, 0
  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 %..27)


  ret i32 0
}

