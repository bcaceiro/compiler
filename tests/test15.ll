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
  %..1 = add i32 1 , 15

  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 %..1)

;PRINT
  %..3 = mul i32 -1 , 1
  %..4 = sub i32 15 , %..3

  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 %..4)

;PRINT
  %..6 = mul i32 -1 , 7
  %..7 = add i32 %..6 , 1

  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 %..7)

;PRINT
  %..9 = mul i32 -1 , 33
  %..10 = sub i32 %..9 , 7

  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 %..10)

;PRINT
  %..12 = mul i32 1 , 13

  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 %..12)

;PRINT
  %..14 = mul i32 1 , 13

  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 %..14)

;PRINT
  %..16 = mul i32 1 , 7

  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 %..16)

;PRINT
  %..18 = mul i32 7 , 3

  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 %..18)

;PRINT
  %..20 = mul i32 -1 , 2
  %..21 = mul i32 8 , %..20

  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 %..21)

;PRINT
  %..23 = mul i32 -1 , 4
  %..24 = mul i32 %..23 , 2

  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 %..24)

;PRINT
  %..26 = mul i32 -1 , 3
  %..27 = mul i32 %..26 , 3

  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 %..27)

;PRINT
  %..29 = sdiv i32 3 , 3

  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 %..29)

;PRINT
  %..31 = sdiv i32 3 , 2

  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 %..31)

;PRINT
  %..33 = sdiv i32 3 , 4

  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 %..33)

;PRINT
  %..35 = mul i32 -1 , 3
  %..36 = sdiv i32 %..35 , 3

  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 %..36)

;PRINT
  %..38 = mul i32 -1 , 2
  %..39 = sdiv i32 3 , %..38

  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 %..39)

;PRINT
  %..41 = sdiv i32 3 , 4

  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 %..41)

;PRINT
  %..43 = sdiv i32 5 , 7

  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 %..43)

;PRINT
  %..45 = sdiv i32 100 , 50

  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 %..45)

;PRINT
  %..47 = srem i32 3 , 3

  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 %..47)

;PRINT
  %..49 = srem i32 3 , 2

  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 %..49)

;PRINT
  %..51 = srem i32 3 , 4

  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 %..51)

;PRINT
  %..53 = mul i32 -1 , 3
  %..54 = srem i32 %..53 , 3

  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 %..54)

;PRINT
  %..56 = mul i32 -1 , 2
  %..57 = srem i32 3 , %..56

  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 %..57)

;PRINT
  %..59 = srem i32 3 , 4

  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 %..59)

;PRINT
  %..61 = srem i32 5 , 7

  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 %..61)

;PRINT
  %..63 = srem i32 100 , 50

  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 %..63)

;PRINT
  %..65 = icmp slt i32 3, 2
  %..66 = zext i1 %..65 to i32
  %..67 = getelementptr inbounds [2 x i8*]* @.printBool, i32 0, i32 %..66
  %..68 = load i8** %..67
  call i32 (i8*, ...)* @printf(i8* %..68)

;PRINT
  %..70 = icmp slt i32 2, 3
  %..71 = zext i1 %..70 to i32
  %..72 = getelementptr inbounds [2 x i8*]* @.printBool, i32 0, i32 %..71
  %..73 = load i8** %..72
  call i32 (i8*, ...)* @printf(i8* %..73)

;PRINT
  %..75 = icmp slt i32 1, 1
  %..76 = zext i1 %..75 to i32
  %..77 = getelementptr inbounds [2 x i8*]* @.printBool, i32 0, i32 %..76
  %..78 = load i8** %..77
  call i32 (i8*, ...)* @printf(i8* %..78)

;PRINT
  %..80 = mul i32 -1 , 3
  %..81 = icmp slt i32 %..80, 2
  %..82 = zext i1 %..81 to i32
  %..83 = getelementptr inbounds [2 x i8*]* @.printBool, i32 0, i32 %..82
  %..84 = load i8** %..83
  call i32 (i8*, ...)* @printf(i8* %..84)

;PRINT
  %..86 = mul i32 -1 , 2
  %..87 = mul i32 -1 , 3
  %..88 = icmp slt i32 %..86, %..87
  %..89 = zext i1 %..88 to i32
  %..90 = getelementptr inbounds [2 x i8*]* @.printBool, i32 0, i32 %..89
  %..91 = load i8** %..90
  call i32 (i8*, ...)* @printf(i8* %..91)

;PRINT
  %..93 = mul i32 -1 , 3
  %..94 = mul i32 -1 , 3
  %..95 = icmp slt i32 %..93, %..94
  %..96 = zext i1 %..95 to i32
  %..97 = getelementptr inbounds [2 x i8*]* @.printBool, i32 0, i32 %..96
  %..98 = load i8** %..97
  call i32 (i8*, ...)* @printf(i8* %..98)

;PRINT
  %..100 = icmp sle i32 3, 2
  %..101 = zext i1 %..100 to i32
  %..102 = getelementptr inbounds [2 x i8*]* @.printBool, i32 0, i32 %..101
  %..103 = load i8** %..102
  call i32 (i8*, ...)* @printf(i8* %..103)

;PRINT
  %..105 = icmp sle i32 2, 3
  %..106 = zext i1 %..105 to i32
  %..107 = getelementptr inbounds [2 x i8*]* @.printBool, i32 0, i32 %..106
  %..108 = load i8** %..107
  call i32 (i8*, ...)* @printf(i8* %..108)

;PRINT
  %..110 = icmp sle i32 1, 1
  %..111 = zext i1 %..110 to i32
  %..112 = getelementptr inbounds [2 x i8*]* @.printBool, i32 0, i32 %..111
  %..113 = load i8** %..112
  call i32 (i8*, ...)* @printf(i8* %..113)

;PRINT
  %..115 = mul i32 -1 , 3
  %..116 = icmp sle i32 %..115, 2
  %..117 = zext i1 %..116 to i32
  %..118 = getelementptr inbounds [2 x i8*]* @.printBool, i32 0, i32 %..117
  %..119 = load i8** %..118
  call i32 (i8*, ...)* @printf(i8* %..119)

;PRINT
  %..121 = mul i32 -1 , 2
  %..122 = mul i32 -1 , 3
  %..123 = icmp sle i32 %..121, %..122
  %..124 = zext i1 %..123 to i32
  %..125 = getelementptr inbounds [2 x i8*]* @.printBool, i32 0, i32 %..124
  %..126 = load i8** %..125
  call i32 (i8*, ...)* @printf(i8* %..126)

;PRINT
  %..128 = mul i32 -1 , 3
  %..129 = mul i32 -1 , 3
  %..130 = icmp sle i32 %..128, %..129
  %..131 = zext i1 %..130 to i32
  %..132 = getelementptr inbounds [2 x i8*]* @.printBool, i32 0, i32 %..131
  %..133 = load i8** %..132
  call i32 (i8*, ...)* @printf(i8* %..133)

;PRINT
  %..135 = icmp sgt i32 3, 2
  %..136 = zext i1 %..135 to i32
  %..137 = getelementptr inbounds [2 x i8*]* @.printBool, i32 0, i32 %..136
  %..138 = load i8** %..137
  call i32 (i8*, ...)* @printf(i8* %..138)

;PRINT
  %..140 = icmp sgt i32 2, 3
  %..141 = zext i1 %..140 to i32
  %..142 = getelementptr inbounds [2 x i8*]* @.printBool, i32 0, i32 %..141
  %..143 = load i8** %..142
  call i32 (i8*, ...)* @printf(i8* %..143)

;PRINT
  %..145 = icmp sgt i32 1, 1
  %..146 = zext i1 %..145 to i32
  %..147 = getelementptr inbounds [2 x i8*]* @.printBool, i32 0, i32 %..146
  %..148 = load i8** %..147
  call i32 (i8*, ...)* @printf(i8* %..148)

;PRINT
  %..150 = mul i32 -1 , 3
  %..151 = icmp sgt i32 %..150, 2
  %..152 = zext i1 %..151 to i32
  %..153 = getelementptr inbounds [2 x i8*]* @.printBool, i32 0, i32 %..152
  %..154 = load i8** %..153
  call i32 (i8*, ...)* @printf(i8* %..154)

;PRINT
  %..156 = mul i32 -1 , 2
  %..157 = mul i32 -1 , 3
  %..158 = icmp sgt i32 %..156, %..157
  %..159 = zext i1 %..158 to i32
  %..160 = getelementptr inbounds [2 x i8*]* @.printBool, i32 0, i32 %..159
  %..161 = load i8** %..160
  call i32 (i8*, ...)* @printf(i8* %..161)

;PRINT
  %..163 = mul i32 -1 , 3
  %..164 = mul i32 -1 , 3
  %..165 = icmp sgt i32 %..163, %..164
  %..166 = zext i1 %..165 to i32
  %..167 = getelementptr inbounds [2 x i8*]* @.printBool, i32 0, i32 %..166
  %..168 = load i8** %..167
  call i32 (i8*, ...)* @printf(i8* %..168)

;PRINT
  %..170 = icmp sge i32 3, 2
  %..171 = zext i1 %..170 to i32
  %..172 = getelementptr inbounds [2 x i8*]* @.printBool, i32 0, i32 %..171
  %..173 = load i8** %..172
  call i32 (i8*, ...)* @printf(i8* %..173)

;PRINT
  %..175 = icmp sge i32 2, 3
  %..176 = zext i1 %..175 to i32
  %..177 = getelementptr inbounds [2 x i8*]* @.printBool, i32 0, i32 %..176
  %..178 = load i8** %..177
  call i32 (i8*, ...)* @printf(i8* %..178)

;PRINT
  %..180 = icmp sge i32 1, 1
  %..181 = zext i1 %..180 to i32
  %..182 = getelementptr inbounds [2 x i8*]* @.printBool, i32 0, i32 %..181
  %..183 = load i8** %..182
  call i32 (i8*, ...)* @printf(i8* %..183)

;PRINT
  %..185 = mul i32 -1 , 3
  %..186 = icmp sge i32 %..185, 2
  %..187 = zext i1 %..186 to i32
  %..188 = getelementptr inbounds [2 x i8*]* @.printBool, i32 0, i32 %..187
  %..189 = load i8** %..188
  call i32 (i8*, ...)* @printf(i8* %..189)

;PRINT
  %..191 = mul i32 -1 , 2
  %..192 = mul i32 -1 , 3
  %..193 = icmp sge i32 %..191, %..192
  %..194 = zext i1 %..193 to i32
  %..195 = getelementptr inbounds [2 x i8*]* @.printBool, i32 0, i32 %..194
  %..196 = load i8** %..195
  call i32 (i8*, ...)* @printf(i8* %..196)

;PRINT
  %..198 = mul i32 -1 , 3
  %..199 = mul i32 -1 , 3
  %..200 = icmp sge i32 %..198, %..199
  %..201 = zext i1 %..200 to i32
  %..202 = getelementptr inbounds [2 x i8*]* @.printBool, i32 0, i32 %..201
  %..203 = load i8** %..202
  call i32 (i8*, ...)* @printf(i8* %..203)

;PRINT
  %..205 = icmp ne i32 3, 2
  %..206 = zext i1 %..205 to i32
  %..207 = getelementptr inbounds [2 x i8*]* @.printBool, i32 0, i32 %..206
  %..208 = load i8** %..207
  call i32 (i8*, ...)* @printf(i8* %..208)

;PRINT
  %..210 = icmp ne i32 2, 3
  %..211 = zext i1 %..210 to i32
  %..212 = getelementptr inbounds [2 x i8*]* @.printBool, i32 0, i32 %..211
  %..213 = load i8** %..212
  call i32 (i8*, ...)* @printf(i8* %..213)

;PRINT
  %..215 = icmp ne i32 1, 1
  %..216 = zext i1 %..215 to i32
  %..217 = getelementptr inbounds [2 x i8*]* @.printBool, i32 0, i32 %..216
  %..218 = load i8** %..217
  call i32 (i8*, ...)* @printf(i8* %..218)

;PRINT
  %..220 = mul i32 -1 , 3
  %..221 = icmp ne i32 %..220, 2
  %..222 = zext i1 %..221 to i32
  %..223 = getelementptr inbounds [2 x i8*]* @.printBool, i32 0, i32 %..222
  %..224 = load i8** %..223
  call i32 (i8*, ...)* @printf(i8* %..224)

;PRINT
  %..226 = mul i32 -1 , 2
  %..227 = mul i32 -1 , 3
  %..228 = icmp ne i32 %..226, %..227
  %..229 = zext i1 %..228 to i32
  %..230 = getelementptr inbounds [2 x i8*]* @.printBool, i32 0, i32 %..229
  %..231 = load i8** %..230
  call i32 (i8*, ...)* @printf(i8* %..231)

;PRINT
  %..233 = mul i32 -1 , 3
  %..234 = mul i32 -1 , 3
  %..235 = icmp ne i32 %..233, %..234
  %..236 = zext i1 %..235 to i32
  %..237 = getelementptr inbounds [2 x i8*]* @.printBool, i32 0, i32 %..236
  %..238 = load i8** %..237
  call i32 (i8*, ...)* @printf(i8* %..238)

;PRINT
  %..240 = icmp eq i32 3, 2
  %..241 = zext i1 %..240 to i32
  %..242 = getelementptr inbounds [2 x i8*]* @.printBool, i32 0, i32 %..241
  %..243 = load i8** %..242
  call i32 (i8*, ...)* @printf(i8* %..243)

;PRINT
  %..245 = icmp eq i32 2, 3
  %..246 = zext i1 %..245 to i32
  %..247 = getelementptr inbounds [2 x i8*]* @.printBool, i32 0, i32 %..246
  %..248 = load i8** %..247
  call i32 (i8*, ...)* @printf(i8* %..248)

;PRINT
  %..250 = icmp eq i32 1, 1
  %..251 = zext i1 %..250 to i32
  %..252 = getelementptr inbounds [2 x i8*]* @.printBool, i32 0, i32 %..251
  %..253 = load i8** %..252
  call i32 (i8*, ...)* @printf(i8* %..253)

;PRINT
  %..255 = mul i32 -1 , 3
  %..256 = icmp eq i32 %..255, 2
  %..257 = zext i1 %..256 to i32
  %..258 = getelementptr inbounds [2 x i8*]* @.printBool, i32 0, i32 %..257
  %..259 = load i8** %..258
  call i32 (i8*, ...)* @printf(i8* %..259)

;PRINT
  %..261 = mul i32 -1 , 2
  %..262 = mul i32 -1 , 3
  %..263 = icmp eq i32 %..261, %..262
  %..264 = zext i1 %..263 to i32
  %..265 = getelementptr inbounds [2 x i8*]* @.printBool, i32 0, i32 %..264
  %..266 = load i8** %..265
  call i32 (i8*, ...)* @printf(i8* %..266)

;PRINT
  %..268 = mul i32 -1 , 3
  %..269 = mul i32 -1 , 3
  %..270 = icmp eq i32 %..268, %..269
  %..271 = zext i1 %..270 to i32
  %..272 = getelementptr inbounds [2 x i8*]* @.printBool, i32 0, i32 %..271
  %..273 = load i8** %..272
  call i32 (i8*, ...)* @printf(i8* %..273)

;PRINT
  %..275 = alloca i1
  store i1 1, i1* %..275
  %..276 = icmp eq i1 1, 1
  br i1 %..276, label %and.do0, label %and.end0
and.do0:
  store i1 1, i1* %..275
  br label %and.end0
and.end0:
  %..277 = load i1* %..275
  %..278 = zext i1 %..277 to i32
  %..279 = getelementptr inbounds [2 x i8*]* @.printBool, i32 0, i32 %..278
  %..280 = load i8** %..279
  call i32 (i8*, ...)* @printf(i8* %..280)

;PRINT
  %..282 = alloca i1
  store i1 1, i1* %..282
  %..283 = icmp eq i1 1, 1
  br i1 %..283, label %and.do1, label %and.end1
and.do1:
  store i1 0, i1* %..282
  br label %and.end1
and.end1:
  %..284 = load i1* %..282
  %..285 = zext i1 %..284 to i32
  %..286 = getelementptr inbounds [2 x i8*]* @.printBool, i32 0, i32 %..285
  %..287 = load i8** %..286
  call i32 (i8*, ...)* @printf(i8* %..287)

;PRINT
  %..289 = alloca i1
  store i1 0, i1* %..289
  %..290 = icmp eq i1 1, 0
  br i1 %..290, label %and.do2, label %and.end2
and.do2:
  store i1 1, i1* %..289
  br label %and.end2
and.end2:
  %..291 = load i1* %..289
  %..292 = zext i1 %..291 to i32
  %..293 = getelementptr inbounds [2 x i8*]* @.printBool, i32 0, i32 %..292
  %..294 = load i8** %..293
  call i32 (i8*, ...)* @printf(i8* %..294)

;PRINT
  %..296 = alloca i1
  store i1 0, i1* %..296
  %..297 = icmp eq i1 1, 0
  br i1 %..297, label %and.do3, label %and.end3
and.do3:
  store i1 0, i1* %..296
  br label %and.end3
and.end3:
  %..298 = load i1* %..296
  %..299 = zext i1 %..298 to i32
  %..300 = getelementptr inbounds [2 x i8*]* @.printBool, i32 0, i32 %..299
  %..301 = load i8** %..300
  call i32 (i8*, ...)* @printf(i8* %..301)

;PRINT
  %..303 = alloca i1
  store i1 1, i1* %..303
  %..304 = icmp eq i1 0, 1
  br i1 %..304, label %and.do4, label %and.end4
and.do4:
  store i1 1, i1* %..303
  br label %and.end4
and.end4:
  %..305 = load i1* %..303
  %..306 = zext i1 %..305 to i32
  %..307 = getelementptr inbounds [2 x i8*]* @.printBool, i32 0, i32 %..306
  %..308 = load i8** %..307
  call i32 (i8*, ...)* @printf(i8* %..308)

;PRINT
  %..310 = alloca i1
  store i1 1, i1* %..310
  %..311 = icmp eq i1 0, 1
  br i1 %..311, label %and.do5, label %and.end5
and.do5:
  store i1 0, i1* %..310
  br label %and.end5
and.end5:
  %..312 = load i1* %..310
  %..313 = zext i1 %..312 to i32
  %..314 = getelementptr inbounds [2 x i8*]* @.printBool, i32 0, i32 %..313
  %..315 = load i8** %..314
  call i32 (i8*, ...)* @printf(i8* %..315)

;PRINT
  %..317 = alloca i1
  store i1 0, i1* %..317
  %..318 = icmp eq i1 0, 0
  br i1 %..318, label %and.do6, label %and.end6
and.do6:
  store i1 1, i1* %..317
  br label %and.end6
and.end6:
  %..319 = load i1* %..317
  %..320 = zext i1 %..319 to i32
  %..321 = getelementptr inbounds [2 x i8*]* @.printBool, i32 0, i32 %..320
  %..322 = load i8** %..321
  call i32 (i8*, ...)* @printf(i8* %..322)

;PRINT
  %..324 = alloca i1
  store i1 0, i1* %..324
  %..325 = icmp eq i1 0, 0
  br i1 %..325, label %and.do7, label %and.end7
and.do7:
  store i1 0, i1* %..324
  br label %and.end7
and.end7:
  %..326 = load i1* %..324
  %..327 = zext i1 %..326 to i32
  %..328 = getelementptr inbounds [2 x i8*]* @.printBool, i32 0, i32 %..327
  %..329 = load i8** %..328
  call i32 (i8*, ...)* @printf(i8* %..329)


  ret i32 0
}

