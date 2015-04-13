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
@e = global i1 0
@f = global i1 0
@g = global i1 0
@h = global i1 0
@i = global i1 0
@j = global %.ArrayInt {i32 0, i32* null}
@k = global %.ArrayInt {i32 0, i32* null}
@l = global %.ArrayInt {i32 0, i32* null}
@m = global %.ArrayInt {i32 0, i32* null}
@n = global %.ArrayBool {i32 0, i1* null}
@o = global %.ArrayBool {i32 0, i1* null}
@p = global %.ArrayBool {i32 0, i1* null}
@q = global %.ArrayBool {i32 0, i1* null}


define i32 @main(i32 %argc, i8** %args){


  ret i32 0
}

