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
  %b = alloca i32
  %c = alloca i32
  %d = alloca i32
  %e = alloca i1
  %f = alloca i1
  %g = alloca i1
  %h = alloca i1
  %i = alloca i1
  %j = alloca %.ArrayInt
  %k = alloca %.ArrayInt
  %l = alloca %.ArrayInt
  %m = alloca %.ArrayInt
  %n = alloca %.ArrayBool
  %o = alloca %.ArrayBool
  %p = alloca %.ArrayBool
  %q = alloca %.ArrayBool


  ret i32 0
}

