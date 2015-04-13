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
  %a = alloca i1

  %..1 = icmp eq i1 1, 1
  br i1 %..1, label %if.do0, label %if.else0
if.do0:
    %..2 = icmp eq i1 1, 0
    br i1 %..2, label %if.do1, label %if.else1
if.do1:
      %..3 = alloca i1
      store i1 0, i1* %..3
      %..4 = icmp eq i1 1, 0
      br i1 %..4, label %and.do2, label %and.end2
and.do2:
      store i1 1, i1* %..3
      br label %and.end2
and.end2:
      %..5 = load i1* %..3
      %..6 = alloca i1
      store i1 %..5, i1* %..6
      %..7 = icmp eq i1 0, %..5
      br i1 %..7, label %and.do3, label %and.end3
and.do3:
      store i1 0, i1* %..6
      br label %and.end3
and.end3:
      %..8 = load i1* %..6
      %..9 = icmp eq i1 1, %..8
      br i1 %..9, label %if.do4, label %if.else4
if.do4:
;STORE
        %..10 = icmp slt i32 1, 3
        %..11 = alloca i1
        store i1 %..10, i1* %..11
        %..12 = icmp eq i1 1, %..10
        br i1 %..12, label %and.do5, label %and.end5
and.do5:
        %..13 = icmp sgt i32 1, 3
        store i1 %..13, i1* %..11
        br label %and.end5
and.end5:
        %..14 = load i1* %..11
        store i1 %..14, i1* %a

        br label %if.end4
if.else4:
      br label %if.end4
if.end4:
      br label %if.end1
if.else1:
    br label %if.end1
if.end1:
    br label %if.end0
if.else0:
  br label %if.end0
if.end0:
;RETURN
ret i32 0

  ret i32 0
}


define i32 @sum(){

;RETURN
  ret i32 2

  ret i32 0
}


define void @maxi(){
  %o_maxi_chupa_pilas = alloca i1

;STORE
  store i1 0, i1* %o_maxi_chupa_pilas


  ret void
}

