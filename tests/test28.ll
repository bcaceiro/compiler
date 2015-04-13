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

;STOREARRAY
;ARRAY
  %..5 = load %.ArrayInt* @a1
;INDEX
;VALUE
  %..6 = mul i32 -1 , 1
;STOREFOFINHO
  %..7 = extractvalue %.ArrayInt %..5, 1
  %..8 = getelementptr i32* %..7, i32 0
  store i32 %..6, i32* %..8
;STOREARRAY
;ARRAY
  %..9 = load %.ArrayInt* @a1
;INDEX
;VALUE
;STOREFOFINHO
  %..10 = extractvalue %.ArrayInt %..9, 1
  %..11 = getelementptr i32* %..10, i32 1
  store i32 0, i32* %..11
;STOREARRAY
;ARRAY
  %..12 = load %.ArrayInt* @a1
;INDEX
;VALUE
;STOREFOFINHO
  %..13 = extractvalue %.ArrayInt %..12, 1
  %..14 = getelementptr i32* %..13, i32 2
  store i32 1, i32* %..14
;STORE
;NEWINTARRAY
  %..15 = call noalias i8* @calloc(i32 3, i32 4) nounwind

  %..16 = bitcast i8* %..15 to i32*
  %..17 = insertvalue %.ArrayInt undef, i32 3, 0
  %..18 = insertvalue %.ArrayInt %..17, i32* %..16, 1
  store %.ArrayInt %..18, %.ArrayInt* %a2

;STOREARRAY
;ARRAY
  %..19 = load %.ArrayInt* %a2
;INDEX
;VALUE
  %..20 = mul i32 -1 , 2
;STOREFOFINHO
  %..21 = extractvalue %.ArrayInt %..19, 1
  %..22 = getelementptr i32* %..21, i32 0
  store i32 %..20, i32* %..22
;STOREARRAY
;ARRAY
  %..23 = load %.ArrayInt* %a2
;INDEX
;VALUE
;STOREFOFINHO
  %..24 = extractvalue %.ArrayInt %..23, 1
  %..25 = getelementptr i32* %..24, i32 1
  store i32 0, i32* %..25
;STOREARRAY
;ARRAY
  %..26 = load %.ArrayInt* %a2
;INDEX
;VALUE
;STOREFOFINHO
  %..27 = extractvalue %.ArrayInt %..26, 1
  %..28 = getelementptr i32* %..27, i32 2
  store i32 2, i32* %..28
;STORE
;NEWBOOLARRAY
  %..29 = call noalias i8* @calloc(i32 4, i32 1) nounwind

  %..30 = bitcast i8* %..29 to i1*
  %..31 = insertvalue %.ArrayBool undef, i32 4, 0
  %..32 = insertvalue %.ArrayBool %..31, i1* %..30, 1
  store %.ArrayBool %..32, %.ArrayBool* @b1

;STOREARRAY
;ARRAY
  %..33 = load %.ArrayBool* @b1
;INDEX
;VALUE
;STOREFOFINHO
  %..34 = extractvalue %.ArrayBool %..33, 1
  %..35 = getelementptr i1* %..34, i32 0
  store i1 0, i1* %..35
;STOREARRAY
;ARRAY
  %..36 = load %.ArrayBool* @b1
;INDEX
;VALUE
;STOREFOFINHO
  %..37 = extractvalue %.ArrayBool %..36, 1
  %..38 = getelementptr i1* %..37, i32 1
  store i1 1, i1* %..38
;STOREARRAY
;ARRAY
  %..39 = load %.ArrayBool* @b1
;INDEX
;VALUE
;STOREFOFINHO
  %..40 = extractvalue %.ArrayBool %..39, 1
  %..41 = getelementptr i1* %..40, i32 2
  store i1 0, i1* %..41
;STOREARRAY
;ARRAY
  %..42 = load %.ArrayBool* @b1
;INDEX
;VALUE
;STOREFOFINHO
  %..43 = extractvalue %.ArrayBool %..42, 1
  %..44 = getelementptr i1* %..43, i32 3
  store i1 1, i1* %..44
;STORE
;NEWBOOLARRAY
  %..45 = call noalias i8* @calloc(i32 4, i32 1) nounwind

  %..46 = bitcast i8* %..45 to i1*
  %..47 = insertvalue %.ArrayBool undef, i32 4, 0
  %..48 = insertvalue %.ArrayBool %..47, i1* %..46, 1
  store %.ArrayBool %..48, %.ArrayBool* %b2

;STOREARRAY
;ARRAY
  %..49 = load %.ArrayBool* %b2
;INDEX
;VALUE
;STOREFOFINHO
  %..50 = extractvalue %.ArrayBool %..49, 1
  %..51 = getelementptr i1* %..50, i32 0
  store i1 0, i1* %..51
;STOREARRAY
;ARRAY
  %..52 = load %.ArrayBool* %b2
;INDEX
;VALUE
;STOREFOFINHO
  %..53 = extractvalue %.ArrayBool %..52, 1
  %..54 = getelementptr i1* %..53, i32 1
  store i1 1, i1* %..54
;STOREARRAY
;ARRAY
  %..55 = load %.ArrayBool* %b2
;INDEX
;VALUE
;STOREFOFINHO
  %..56 = extractvalue %.ArrayBool %..55, 1
  %..57 = getelementptr i1* %..56, i32 2
  store i1 0, i1* %..57
;STOREARRAY
;ARRAY
  %..58 = load %.ArrayBool* %b2
;INDEX
;VALUE
;STOREFOFINHO
  %..59 = extractvalue %.ArrayBool %..58, 1
  %..60 = getelementptr i1* %..59, i32 3
  store i1 1, i1* %..60
;PRINT
;LOADARRAY
  %..61 = load %.ArrayInt* @a1
  %..62 = extractvalue %.ArrayInt %..61, 1
  %..63 = getelementptr i32* %..62, i32 0
  %..64 = load i32* %..63
  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 %..64)

;PRINT
;LOADARRAY
  %..66 = load %.ArrayInt* @a1
  %..67 = extractvalue %.ArrayInt %..66, 1
  %..68 = getelementptr i32* %..67, i32 1
  %..69 = load i32* %..68
  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 %..69)

;PRINT
;LOADARRAY
  %..71 = load %.ArrayInt* @a1
  %..72 = extractvalue %.ArrayInt %..71, 1
  %..73 = getelementptr i32* %..72, i32 2
  %..74 = load i32* %..73
  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 %..74)

;PRINT
;LOADARRAY
  %..76 = load %.ArrayInt* %a2
  %..77 = extractvalue %.ArrayInt %..76, 1
  %..78 = getelementptr i32* %..77, i32 0
  %..79 = load i32* %..78
  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 %..79)

;PRINT
;LOADARRAY
  %..81 = load %.ArrayInt* %a2
  %..82 = extractvalue %.ArrayInt %..81, 1
  %..83 = getelementptr i32* %..82, i32 1
  %..84 = load i32* %..83
  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 %..84)

;PRINT
;LOADARRAY
  %..86 = load %.ArrayInt* %a2
  %..87 = extractvalue %.ArrayInt %..86, 1
  %..88 = getelementptr i32* %..87, i32 2
  %..89 = load i32* %..88
  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 %..89)

;PRINT
;LOADARRAY
  %..91 = load %.ArrayBool* @b1
  %..92 = extractvalue %.ArrayBool %..91, 1
  %..93 = getelementptr i1* %..92, i32 0
  %..94 = load i1* %..93
  %..95 = zext i1 %..94 to i32
  %..96 = getelementptr inbounds [2 x i8*]* @.printBool, i32 0, i32 %..95
  %..97 = load i8** %..96
  call i32 (i8*, ...)* @printf(i8* %..97)

;PRINT
;LOADARRAY
  %..99 = load %.ArrayBool* @b1
  %..100 = extractvalue %.ArrayBool %..99, 1
  %..101 = getelementptr i1* %..100, i32 1
  %..102 = load i1* %..101
  %..103 = zext i1 %..102 to i32
  %..104 = getelementptr inbounds [2 x i8*]* @.printBool, i32 0, i32 %..103
  %..105 = load i8** %..104
  call i32 (i8*, ...)* @printf(i8* %..105)

;PRINT
;LOADARRAY
  %..107 = load %.ArrayBool* @b1
  %..108 = extractvalue %.ArrayBool %..107, 1
  %..109 = getelementptr i1* %..108, i32 2
  %..110 = load i1* %..109
  %..111 = zext i1 %..110 to i32
  %..112 = getelementptr inbounds [2 x i8*]* @.printBool, i32 0, i32 %..111
  %..113 = load i8** %..112
  call i32 (i8*, ...)* @printf(i8* %..113)

;PRINT
;LOADARRAY
  %..115 = load %.ArrayBool* @b1
  %..116 = extractvalue %.ArrayBool %..115, 1
  %..117 = getelementptr i1* %..116, i32 3
  %..118 = load i1* %..117
  %..119 = zext i1 %..118 to i32
  %..120 = getelementptr inbounds [2 x i8*]* @.printBool, i32 0, i32 %..119
  %..121 = load i8** %..120
  call i32 (i8*, ...)* @printf(i8* %..121)

;PRINT
;LOADARRAY
  %..123 = load %.ArrayBool* %b2
  %..124 = extractvalue %.ArrayBool %..123, 1
  %..125 = getelementptr i1* %..124, i32 0
  %..126 = load i1* %..125
  %..127 = zext i1 %..126 to i32
  %..128 = getelementptr inbounds [2 x i8*]* @.printBool, i32 0, i32 %..127
  %..129 = load i8** %..128
  call i32 (i8*, ...)* @printf(i8* %..129)

;PRINT
;LOADARRAY
  %..131 = load %.ArrayBool* %b2
  %..132 = extractvalue %.ArrayBool %..131, 1
  %..133 = getelementptr i1* %..132, i32 1
  %..134 = load i1* %..133
  %..135 = zext i1 %..134 to i32
  %..136 = getelementptr inbounds [2 x i8*]* @.printBool, i32 0, i32 %..135
  %..137 = load i8** %..136
  call i32 (i8*, ...)* @printf(i8* %..137)

;PRINT
;LOADARRAY
  %..139 = load %.ArrayBool* %b2
  %..140 = extractvalue %.ArrayBool %..139, 1
  %..141 = getelementptr i1* %..140, i32 2
  %..142 = load i1* %..141
  %..143 = zext i1 %..142 to i32
  %..144 = getelementptr inbounds [2 x i8*]* @.printBool, i32 0, i32 %..143
  %..145 = load i8** %..144
  call i32 (i8*, ...)* @printf(i8* %..145)

;PRINT
;LOADARRAY
  %..147 = load %.ArrayBool* %b2
  %..148 = extractvalue %.ArrayBool %..147, 1
  %..149 = getelementptr i1* %..148, i32 3
  %..150 = load i1* %..149
  %..151 = zext i1 %..150 to i32
  %..152 = getelementptr inbounds [2 x i8*]* @.printBool, i32 0, i32 %..151
  %..153 = load i8** %..152
  call i32 (i8*, ...)* @printf(i8* %..153)


  ret i32 0
}

