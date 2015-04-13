declare i32 @printf(i8* noalias nocapture, ...)
declare noalias i8* @calloc(i32, i32) nounwind
declare i32 @atoi(i8*) nounwind readonly
@.printInt = private constant [4 x i8] c"%d\0A\00"
@.true = private constant [6 x i8] c"true\0A\00"
@.false = private constant [7 x i8] c"false\0A\00"
@.printBool = private constant [2 x i8*] [i8* getelementptr inbounds ([7 x i8]* @.false, i32 0, i32 0),i8* getelementptr inbounds ([6 x i8]* @.true, i32 0, i32 0)]

%.ArrayInt = type { i32, i32* }
%.ArrayBool = type { i32, i1* }
@a1 = global %.ArrayInt {i32 0, i32* null}
@b1 = global %.ArrayBool {i32 0, i1* null}


define i32 @main(i32 %argc, i8** %args){
  %a2 = alloca %.ArrayInt
  %b2 = alloca %.ArrayBool

;STORE
;NEWINTARRAY
  %..1 = call noalias i8* @calloc(i32 3, i32 4) nounwind

  %..2 = bitcast i8* %..1 to i32*
  %..3 = insertvalue %.ArrayInt undef, i32 3, 0
  %..4 = insertvalue %.ArrayInt %..3, i32* %..2, 1
  store %.ArrayInt %..4, %.ArrayInt* @a1

;STORE
;NEWINTARRAY
  %..5 = call noalias i8* @calloc(i32 3, i32 4) nounwind

  %..6 = bitcast i8* %..5 to i32*
  %..7 = insertvalue %.ArrayInt undef, i32 3, 0
  %..8 = insertvalue %.ArrayInt %..7, i32* %..6, 1
  store %.ArrayInt %..8, %.ArrayInt* %a2

;STORE
;NEWBOOLARRAY
  %..9 = call noalias i8* @calloc(i32 4, i32 1) nounwind

  %..10 = bitcast i8* %..9 to i1*
  %..11 = insertvalue %.ArrayBool undef, i32 4, 0
  %..12 = insertvalue %.ArrayBool %..11, i1* %..10, 1
  store %.ArrayBool %..12, %.ArrayBool* @b1

;STORE
;NEWBOOLARRAY
  %..13 = call noalias i8* @calloc(i32 4, i32 1) nounwind

  %..14 = bitcast i8* %..13 to i1*
  %..15 = insertvalue %.ArrayBool undef, i32 4, 0
  %..16 = insertvalue %.ArrayBool %..15, i1* %..14, 1
  store %.ArrayBool %..16, %.ArrayBool* %b2

;PRINT
;LOADARRAY
  %..17 = load %.ArrayInt* @a1
  %..18 = extractvalue %.ArrayInt %..17, 1
  %..19 = getelementptr i32* %..18, i32 0
  %..20 = load i32* %..19
  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 %..20)

;PRINT
;LOADARRAY
  %..22 = load %.ArrayInt* @a1
  %..23 = extractvalue %.ArrayInt %..22, 1
  %..24 = getelementptr i32* %..23, i32 1
  %..25 = load i32* %..24
  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 %..25)

;PRINT
;LOADARRAY
  %..27 = load %.ArrayInt* @a1
  %..28 = extractvalue %.ArrayInt %..27, 1
  %..29 = getelementptr i32* %..28, i32 2
  %..30 = load i32* %..29
  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 %..30)

;PRINT
;LOADARRAY
  %..32 = load %.ArrayInt* %a2
  %..33 = extractvalue %.ArrayInt %..32, 1
  %..34 = getelementptr i32* %..33, i32 0
  %..35 = load i32* %..34
  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 %..35)

;PRINT
;LOADARRAY
  %..37 = load %.ArrayInt* %a2
  %..38 = extractvalue %.ArrayInt %..37, 1
  %..39 = getelementptr i32* %..38, i32 1
  %..40 = load i32* %..39
  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 %..40)

;PRINT
;LOADARRAY
  %..42 = load %.ArrayInt* %a2
  %..43 = extractvalue %.ArrayInt %..42, 1
  %..44 = getelementptr i32* %..43, i32 2
  %..45 = load i32* %..44
  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 %..45)

;PRINT
;LOADARRAY
  %..47 = load %.ArrayBool* @b1
  %..48 = extractvalue %.ArrayBool %..47, 1
  %..49 = getelementptr i1* %..48, i32 0
  %..50 = load i1* %..49
  %..51 = zext i1 %..50 to i32
  %..52 = getelementptr inbounds [2 x i8*]* @.printBool, i32 0, i32 %..51
  %..53 = load i8** %..52
  call i32 (i8*, ...)* @printf(i8* %..53)

;PRINT
;LOADARRAY
  %..55 = load %.ArrayBool* @b1
  %..56 = extractvalue %.ArrayBool %..55, 1
  %..57 = getelementptr i1* %..56, i32 1
  %..58 = load i1* %..57
  %..59 = zext i1 %..58 to i32
  %..60 = getelementptr inbounds [2 x i8*]* @.printBool, i32 0, i32 %..59
  %..61 = load i8** %..60
  call i32 (i8*, ...)* @printf(i8* %..61)

;PRINT
;LOADARRAY
  %..63 = load %.ArrayBool* @b1
  %..64 = extractvalue %.ArrayBool %..63, 1
  %..65 = getelementptr i1* %..64, i32 2
  %..66 = load i1* %..65
  %..67 = zext i1 %..66 to i32
  %..68 = getelementptr inbounds [2 x i8*]* @.printBool, i32 0, i32 %..67
  %..69 = load i8** %..68
  call i32 (i8*, ...)* @printf(i8* %..69)

;PRINT
;LOADARRAY
  %..71 = load %.ArrayBool* @b1
  %..72 = extractvalue %.ArrayBool %..71, 1
  %..73 = getelementptr i1* %..72, i32 3
  %..74 = load i1* %..73
  %..75 = zext i1 %..74 to i32
  %..76 = getelementptr inbounds [2 x i8*]* @.printBool, i32 0, i32 %..75
  %..77 = load i8** %..76
  call i32 (i8*, ...)* @printf(i8* %..77)

;PRINT
;LOADARRAY
  %..79 = load %.ArrayBool* %b2
  %..80 = extractvalue %.ArrayBool %..79, 1
  %..81 = getelementptr i1* %..80, i32 0
  %..82 = load i1* %..81
  %..83 = zext i1 %..82 to i32
  %..84 = getelementptr inbounds [2 x i8*]* @.printBool, i32 0, i32 %..83
  %..85 = load i8** %..84
  call i32 (i8*, ...)* @printf(i8* %..85)

;PRINT
;LOADARRAY
  %..87 = load %.ArrayBool* %b2
  %..88 = extractvalue %.ArrayBool %..87, 1
  %..89 = getelementptr i1* %..88, i32 1
  %..90 = load i1* %..89
  %..91 = zext i1 %..90 to i32
  %..92 = getelementptr inbounds [2 x i8*]* @.printBool, i32 0, i32 %..91
  %..93 = load i8** %..92
  call i32 (i8*, ...)* @printf(i8* %..93)

;PRINT
;LOADARRAY
  %..95 = load %.ArrayBool* %b2
  %..96 = extractvalue %.ArrayBool %..95, 1
  %..97 = getelementptr i1* %..96, i32 2
  %..98 = load i1* %..97
  %..99 = zext i1 %..98 to i32
  %..100 = getelementptr inbounds [2 x i8*]* @.printBool, i32 0, i32 %..99
  %..101 = load i8** %..100
  call i32 (i8*, ...)* @printf(i8* %..101)

;PRINT
;LOADARRAY
  %..103 = load %.ArrayBool* %b2
  %..104 = extractvalue %.ArrayBool %..103, 1
  %..105 = getelementptr i1* %..104, i32 3
  %..106 = load i1* %..105
  %..107 = zext i1 %..106 to i32
  %..108 = getelementptr inbounds [2 x i8*]* @.printBool, i32 0, i32 %..107
  %..109 = load i8** %..108
  call i32 (i8*, ...)* @printf(i8* %..109)


  ret i32 0
}

