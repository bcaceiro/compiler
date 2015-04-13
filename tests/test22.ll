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
@a2 = global %.ArrayInt {i32 0, i32* null}
@b1 = global %.ArrayBool {i32 0, i1* null}
@b2 = global %.ArrayBool {i32 0, i1* null}


define i32 @main(i32 %argc, i8** %args){

;STORE
  %..1 = load %.ArrayInt* @a2
  store %.ArrayInt %..1, %.ArrayInt* @a1

;STORE
  %..2 = load %.ArrayInt* @a1
  store %.ArrayInt %..2, %.ArrayInt* @a2

;STORE
  %..3 = load %.ArrayBool* @b2
  store %.ArrayBool %..3, %.ArrayBool* @b1

;STORE
  %..4 = load %.ArrayBool* @b1
  store %.ArrayBool %..4, %.ArrayBool* @b2


  ret i32 0
}

