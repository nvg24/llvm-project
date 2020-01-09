; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -lower-matrix-intrinsics -S < %s | FileCheck %s
; RUN: opt -passes='lower-matrix-intrinsics' -S < %s | FileCheck %s


; Make sure we propagate in multiple iterations. First, we back-propagate the
; shape information from the transpose to %A, in the next iteration we
; forward-propagate it to %Mul, and then back to %B.
define <16 x double> @backpropagation_iterations(<16 x double>* %A.Ptr, <16 x double>* %B.Ptr) {
; CHECK-LABEL: @backpropagation_iterations(
; CHECK-NEXT:    [[TMP1:%.*]] = bitcast <16 x double>* [[A_PTR:%.*]] to double*
; CHECK-NEXT:    [[TMP2:%.*]] = bitcast double* [[TMP1]] to <4 x double>*
; CHECK-NEXT:    [[TMP3:%.*]] = load <4 x double>, <4 x double>* [[TMP2]], align 8
; CHECK-NEXT:    [[TMP5:%.*]] = getelementptr double, double* [[TMP1]], i32 4
; CHECK-NEXT:    [[TMP6:%.*]] = bitcast double* [[TMP5]] to <4 x double>*
; CHECK-NEXT:    [[TMP7:%.*]] = load <4 x double>, <4 x double>* [[TMP6]], align 8
; CHECK-NEXT:    [[TMP9:%.*]] = getelementptr double, double* [[TMP1]], i32 8
; CHECK-NEXT:    [[TMP10:%.*]] = bitcast double* [[TMP9]] to <4 x double>*
; CHECK-NEXT:    [[TMP11:%.*]] = load <4 x double>, <4 x double>* [[TMP10]], align 8
; CHECK-NEXT:    [[TMP13:%.*]] = getelementptr double, double* [[TMP1]], i32 12
; CHECK-NEXT:    [[TMP14:%.*]] = bitcast double* [[TMP13]] to <4 x double>*
; CHECK-NEXT:    [[TMP15:%.*]] = load <4 x double>, <4 x double>* [[TMP14]], align 8
; CHECK-NEXT:    [[TMP16:%.*]] = extractelement <4 x double> [[TMP3]], i64 0
; CHECK-NEXT:    [[TMP17:%.*]] = insertelement <4 x double> undef, double [[TMP16]], i64 0
; CHECK-NEXT:    [[TMP18:%.*]] = extractelement <4 x double> [[TMP7]], i64 0
; CHECK-NEXT:    [[TMP19:%.*]] = insertelement <4 x double> [[TMP17]], double [[TMP18]], i64 1
; CHECK-NEXT:    [[TMP20:%.*]] = extractelement <4 x double> [[TMP11]], i64 0
; CHECK-NEXT:    [[TMP21:%.*]] = insertelement <4 x double> [[TMP19]], double [[TMP20]], i64 2
; CHECK-NEXT:    [[TMP22:%.*]] = extractelement <4 x double> [[TMP15]], i64 0
; CHECK-NEXT:    [[TMP23:%.*]] = insertelement <4 x double> [[TMP21]], double [[TMP22]], i64 3
; CHECK-NEXT:    [[TMP24:%.*]] = extractelement <4 x double> [[TMP3]], i64 1
; CHECK-NEXT:    [[TMP25:%.*]] = insertelement <4 x double> undef, double [[TMP24]], i64 0
; CHECK-NEXT:    [[TMP26:%.*]] = extractelement <4 x double> [[TMP7]], i64 1
; CHECK-NEXT:    [[TMP27:%.*]] = insertelement <4 x double> [[TMP25]], double [[TMP26]], i64 1
; CHECK-NEXT:    [[TMP28:%.*]] = extractelement <4 x double> [[TMP11]], i64 1
; CHECK-NEXT:    [[TMP29:%.*]] = insertelement <4 x double> [[TMP27]], double [[TMP28]], i64 2
; CHECK-NEXT:    [[TMP30:%.*]] = extractelement <4 x double> [[TMP15]], i64 1
; CHECK-NEXT:    [[TMP31:%.*]] = insertelement <4 x double> [[TMP29]], double [[TMP30]], i64 3
; CHECK-NEXT:    [[TMP32:%.*]] = extractelement <4 x double> [[TMP3]], i64 2
; CHECK-NEXT:    [[TMP33:%.*]] = insertelement <4 x double> undef, double [[TMP32]], i64 0
; CHECK-NEXT:    [[TMP34:%.*]] = extractelement <4 x double> [[TMP7]], i64 2
; CHECK-NEXT:    [[TMP35:%.*]] = insertelement <4 x double> [[TMP33]], double [[TMP34]], i64 1
; CHECK-NEXT:    [[TMP36:%.*]] = extractelement <4 x double> [[TMP11]], i64 2
; CHECK-NEXT:    [[TMP37:%.*]] = insertelement <4 x double> [[TMP35]], double [[TMP36]], i64 2
; CHECK-NEXT:    [[TMP38:%.*]] = extractelement <4 x double> [[TMP15]], i64 2
; CHECK-NEXT:    [[TMP39:%.*]] = insertelement <4 x double> [[TMP37]], double [[TMP38]], i64 3
; CHECK-NEXT:    [[TMP40:%.*]] = extractelement <4 x double> [[TMP3]], i64 3
; CHECK-NEXT:    [[TMP41:%.*]] = insertelement <4 x double> undef, double [[TMP40]], i64 0
; CHECK-NEXT:    [[TMP42:%.*]] = extractelement <4 x double> [[TMP7]], i64 3
; CHECK-NEXT:    [[TMP43:%.*]] = insertelement <4 x double> [[TMP41]], double [[TMP42]], i64 1
; CHECK-NEXT:    [[TMP44:%.*]] = extractelement <4 x double> [[TMP11]], i64 3
; CHECK-NEXT:    [[TMP45:%.*]] = insertelement <4 x double> [[TMP43]], double [[TMP44]], i64 2
; CHECK-NEXT:    [[TMP46:%.*]] = extractelement <4 x double> [[TMP15]], i64 3
; CHECK-NEXT:    [[TMP47:%.*]] = insertelement <4 x double> [[TMP45]], double [[TMP46]], i64 3
; CHECK-NEXT:    [[TMP48:%.*]] = bitcast <16 x double>* [[B_PTR:%.*]] to double*
; CHECK-NEXT:    [[TMP49:%.*]] = bitcast double* [[TMP48]] to <4 x double>*
; CHECK-NEXT:    [[TMP50:%.*]] = load <4 x double>, <4 x double>* [[TMP49]], align 8
; CHECK-NEXT:    [[TMP52:%.*]] = getelementptr double, double* [[TMP48]], i32 4
; CHECK-NEXT:    [[TMP53:%.*]] = bitcast double* [[TMP52]] to <4 x double>*
; CHECK-NEXT:    [[TMP54:%.*]] = load <4 x double>, <4 x double>* [[TMP53]], align 8
; CHECK-NEXT:    [[TMP56:%.*]] = getelementptr double, double* [[TMP48]], i32 8
; CHECK-NEXT:    [[TMP57:%.*]] = bitcast double* [[TMP56]] to <4 x double>*
; CHECK-NEXT:    [[TMP58:%.*]] = load <4 x double>, <4 x double>* [[TMP57]], align 8
; CHECK-NEXT:    [[TMP60:%.*]] = getelementptr double, double* [[TMP48]], i32 12
; CHECK-NEXT:    [[TMP61:%.*]] = bitcast double* [[TMP60]] to <4 x double>*
; CHECK-NEXT:    [[TMP62:%.*]] = load <4 x double>, <4 x double>* [[TMP61]], align 8
; CHECK-NEXT:    [[TMP63:%.*]] = fmul <4 x double> [[TMP3]], [[TMP50]]
; CHECK-NEXT:    [[TMP64:%.*]] = fmul <4 x double> [[TMP7]], [[TMP54]]
; CHECK-NEXT:    [[TMP65:%.*]] = fmul <4 x double> [[TMP11]], [[TMP58]]
; CHECK-NEXT:    [[TMP66:%.*]] = fmul <4 x double> [[TMP15]], [[TMP62]]
; CHECK-NEXT:    [[TMP67:%.*]] = shufflevector <4 x double> [[TMP63]], <4 x double> [[TMP64]], <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
; CHECK-NEXT:    [[TMP68:%.*]] = shufflevector <4 x double> [[TMP65]], <4 x double> [[TMP66]], <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
; CHECK-NEXT:    [[TMP69:%.*]] = shufflevector <8 x double> [[TMP67]], <8 x double> [[TMP68]], <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15>
; CHECK-NEXT:    ret <16 x double> [[TMP69]]
;
  %A = load <16 x double>, <16 x double>* %A.Ptr
  %A.trans = tail call <16 x double> @llvm.matrix.transpose.v16f64(<16 x double> %A, i32 4, i32 4)
  %B = load <16 x double>, <16 x double>* %B.Ptr
  %Mul = fmul <16 x double> %A, %B
  ret <16 x double> %Mul
}

declare <16 x double> @llvm.matrix.multiply.v16f64.v16f64.v16f64(<16 x double>, <16 x double>, i32 immarg, i32 immarg, i32 immarg)
declare <16 x double> @llvm.matrix.transpose.v16f64(<16 x double>, i32 immarg, i32 immarg)