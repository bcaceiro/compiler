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
;PARSEARGS
  %..1 = add i32 1 , 0
  %..2 = getelementptr inbounds i8** %args, i32 %..1
  %..3 = load i8** %..2
  %..4 = call i32 @atoi(i8* %..3) nounwind readonly
  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 %..4)

;PRINT
;PARSEARGS
  %..6 = add i32 1 , 1
  %..7 = getelementptr inbounds i8** %args, i32 %..6
  %..8 = load i8** %..7
  %..9 = call i32 @atoi(i8* %..8) nounwind readonly
  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 %..9)

;PRINT
;PARSEARGS
  %..11 = add i32 1 , 2
  %..12 = getelementptr inbounds i8** %args, i32 %..11
  %..13 = load i8** %..12
  %..14 = call i32 @atoi(i8* %..13) nounwind readonly
  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 %..14)

;PRINT
;PARSEARGS
  %..16 = add i32 1 , 3
  %..17 = getelementptr inbounds i8** %args, i32 %..16
  %..18 = load i8** %..17
  %..19 = call i32 @atoi(i8* %..18) nounwind readonly
  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 %..19)

;PRINT
;PARSEARGS
  %..21 = add i32 1 , 4
  %..22 = getelementptr inbounds i8** %args, i32 %..21
  %..23 = load i8** %..22
  %..24 = call i32 @atoi(i8* %..23) nounwind readonly
  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 %..24)

;PRINT
;PARSEARGS
  %..26 = add i32 1 , 5
  %..27 = getelementptr inbounds i8** %args, i32 %..26
  %..28 = load i8** %..27
  %..29 = call i32 @atoi(i8* %..28) nounwind readonly
  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 %..29)

;PRINT
;PARSEARGS
  %..31 = add i32 1 , 6
  %..32 = getelementptr inbounds i8** %args, i32 %..31
  %..33 = load i8** %..32
  %..34 = call i32 @atoi(i8* %..33) nounwind readonly
  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 %..34)

;PRINT
;PARSEARGS
  %..36 = add i32 1 , 7
  %..37 = getelementptr inbounds i8** %args, i32 %..36
  %..38 = load i8** %..37
  %..39 = call i32 @atoi(i8* %..38) nounwind readonly
  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 %..39)

;PRINT
;PARSEARGS
  %..41 = add i32 1 , 8
  %..42 = getelementptr inbounds i8** %args, i32 %..41
  %..43 = load i8** %..42
  %..44 = call i32 @atoi(i8* %..43) nounwind readonly
  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 %..44)

;PRINT
;PARSEARGS
  %..46 = add i32 1 , 9
  %..47 = getelementptr inbounds i8** %args, i32 %..46
  %..48 = load i8** %..47
  %..49 = call i32 @atoi(i8* %..48) nounwind readonly
  call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.printInt, i32 0, i32 0), i32 %..49)


  ret i32 0
}

