; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -opaque-pointers -passes='instcombine' -S %s | FileCheck %s

define <4 x i8> @splat_binop_non_splat_x(<4 x i8> %x, <4 x i8> %y) {
; CHECK-LABEL: @splat_binop_non_splat_x(
; CHECK-NEXT:    [[XSPLAT:%.*]] = shufflevector <4 x i8> [[X:%.*]], <4 x i8> poison, <4 x i32> <i32 0, i32 2, i32 undef, i32 undef>
; CHECK-NEXT:    call void @use(<4 x i8> [[XSPLAT]])
; CHECK-NEXT:    [[B:%.*]] = add <4 x i8> [[XSPLAT]], [[Y:%.*]]
; CHECK-NEXT:    [[BSPLAT:%.*]] = shufflevector <4 x i8> [[B]], <4 x i8> poison, <4 x i32> zeroinitializer
; CHECK-NEXT:    ret <4 x i8> [[BSPLAT]]
;
  %xsplat = shufflevector <4 x i8> %x, <4 x i8> poison, <4 x i32> <i32 0, i32 2, i32 4, i32 6>
  call void @use(<4 x i8> %xsplat)
  %b = add <4 x i8> %xsplat, %y
  %bsplat = shufflevector <4 x i8> %b, <4 x i8> poison, <4 x i32> zeroinitializer
  ret <4 x i8> %bsplat
}

define <4 x i8> @non_splat_binop_splat_x(<4 x i8> %x, <4 x i8> %y) {
; CHECK-LABEL: @non_splat_binop_splat_x(
; CHECK-NEXT:    [[XSPLAT:%.*]] = shufflevector <4 x i8> [[X:%.*]], <4 x i8> poison, <4 x i32> zeroinitializer
; CHECK-NEXT:    call void @use(<4 x i8> [[XSPLAT]])
; CHECK-NEXT:    [[B:%.*]] = sub <4 x i8> [[XSPLAT]], [[Y:%.*]]
; CHECK-NEXT:    [[BSPLAT:%.*]] = shufflevector <4 x i8> [[B]], <4 x i8> poison, <4 x i32> <i32 0, i32 2, i32 undef, i32 undef>
; CHECK-NEXT:    ret <4 x i8> [[BSPLAT]]
;
  %xsplat = shufflevector <4 x i8> %x, <4 x i8> poison, <4 x i32> zeroinitializer
  call void @use(<4 x i8> %xsplat)
  %b = sub <4 x i8> %xsplat, %y
  %bsplat = shufflevector <4 x i8> %b, <4 x i8> poison, <4 x i32> <i32 0, i32 2, i32 4, i32 6>
  ret <4 x i8> %bsplat
}

define <4 x i32> @splat_binop_splat_changes_x_length(<8 x i32> %x, <4 x i32> %y) {
; CHECK-LABEL: @splat_binop_splat_changes_x_length(
; CHECK-NEXT:    [[XSPLAT:%.*]] = shufflevector <8 x i32> [[X:%.*]], <8 x i32> poison, <4 x i32> zeroinitializer
; CHECK-NEXT:    call void @use(<4 x i32> [[XSPLAT]])
; CHECK-NEXT:    [[B:%.*]] = mul <4 x i32> [[XSPLAT]], [[Y:%.*]]
; CHECK-NEXT:    [[BSPLAT:%.*]] = shufflevector <4 x i32> [[B]], <4 x i32> poison, <4 x i32> zeroinitializer
; CHECK-NEXT:    ret <4 x i32> [[BSPLAT]]
;
  %xsplat = shufflevector <8 x i32> %x, <8 x i32> poison, <4 x i32> zeroinitializer
  call void @use(<4 x i32> %xsplat)
  %b = mul <4 x i32> %xsplat, %y
  %bsplat = shufflevector <4 x i32> %b, <4 x i32> poison, <4 x i32> zeroinitializer
  ret <4 x i32> %bsplat
}

define <4 x i8> @splat_binop_splat_x(<4 x i8> %x, <4 x i8> %y) {
; CHECK-LABEL: @splat_binop_splat_x(
; CHECK-NEXT:    [[XSPLAT:%.*]] = shufflevector <4 x i8> [[X:%.*]], <4 x i8> poison, <4 x i32> zeroinitializer
; CHECK-NEXT:    call void @use(<4 x i8> [[XSPLAT]])
; CHECK-NEXT:    [[TMP1:%.*]] = add nsw <4 x i8> [[X]], [[Y:%.*]]
; CHECK-NEXT:    [[BSPLAT:%.*]] = shufflevector <4 x i8> [[TMP1]], <4 x i8> poison, <4 x i32> zeroinitializer
; CHECK-NEXT:    ret <4 x i8> [[BSPLAT]]
;
  %xsplat = shufflevector <4 x i8> %x, <4 x i8> poison, <4 x i32> zeroinitializer
  call void @use(<4 x i8> %xsplat)
  %b = add nsw <4 x i8> %xsplat, %y
  %bsplat = shufflevector <4 x i8> %b, <4 x i8> poison, <4 x i32> zeroinitializer
  ret <4 x i8> %bsplat
}

define <4 x i8> @splat_binop_splat_y(<4 x i8> %x, <4 x i8> %y) {
; CHECK-LABEL: @splat_binop_splat_y(
; CHECK-NEXT:    [[YSPLAT:%.*]] = shufflevector <4 x i8> [[Y:%.*]], <4 x i8> poison, <4 x i32> zeroinitializer
; CHECK-NEXT:    call void @use(<4 x i8> [[YSPLAT]])
; CHECK-NEXT:    [[TMP1:%.*]] = sub <4 x i8> [[X:%.*]], [[Y]]
; CHECK-NEXT:    [[BSPLAT:%.*]] = shufflevector <4 x i8> [[TMP1]], <4 x i8> poison, <4 x i32> <i32 undef, i32 0, i32 0, i32 0>
; CHECK-NEXT:    ret <4 x i8> [[BSPLAT]]
;
  %ysplat = shufflevector <4 x i8> %y, <4 x i8> poison, <4 x i32> zeroinitializer
  call void @use(<4 x i8> %ysplat)
  %b = sub <4 x i8> %x, %ysplat
  %bsplat = shufflevector <4 x i8> %b, <4 x i8> poison, <4 x i32><i32 poison, i32 0, i32 0, i32 0>
  ret <4 x i8> %bsplat
}

define <4 x i8> @splat_binop_splat_x_splat_y(<4 x i8> %x, <4 x i8> %y) {
; CHECK-LABEL: @splat_binop_splat_x_splat_y(
; CHECK-NEXT:    [[XSPLAT:%.*]] = shufflevector <4 x i8> [[X:%.*]], <4 x i8> poison, <4 x i32> zeroinitializer
; CHECK-NEXT:    call void @use(<4 x i8> [[XSPLAT]])
; CHECK-NEXT:    [[YSPLAT:%.*]] = shufflevector <4 x i8> [[Y:%.*]], <4 x i8> poison, <4 x i32> zeroinitializer
; CHECK-NEXT:    call void @use(<4 x i8> [[YSPLAT]])
; CHECK-NEXT:    [[TMP1:%.*]] = mul nuw <4 x i8> [[Y]], [[X]]
; CHECK-NEXT:    [[BSPLAT:%.*]] = shufflevector <4 x i8> [[TMP1]], <4 x i8> poison, <4 x i32> zeroinitializer
; CHECK-NEXT:    ret <4 x i8> [[BSPLAT]]
;
  %xsplat = shufflevector <4 x i8> %x, <4 x i8> poison, <4 x i32> zeroinitializer
  call void @use(<4 x i8> %xsplat)
  %ysplat = shufflevector <4 x i8> %y, <4 x i8> poison, <4 x i32> zeroinitializer
  call void @use(<4 x i8> %ysplat)
  %b = mul nuw <4 x i8> %xsplat, %ysplat
  %bsplat = shufflevector <4 x i8> %b, <4 x i8> poison, <4 x i32> zeroinitializer
  ret <4 x i8> %bsplat
}

define <4 x float> @splat_binop_splat_x_splat_y_fmath_flags(<4 x float> %x, <4 x float> %y) {
; CHECK-LABEL: @splat_binop_splat_x_splat_y_fmath_flags(
; CHECK-NEXT:    [[XSPLAT:%.*]] = shufflevector <4 x float> [[X:%.*]], <4 x float> poison, <4 x i32> zeroinitializer
; CHECK-NEXT:    call void @use(<4 x float> [[XSPLAT]])
; CHECK-NEXT:    [[YSPLAT:%.*]] = shufflevector <4 x float> [[Y:%.*]], <4 x float> poison, <4 x i32> zeroinitializer
; CHECK-NEXT:    call void @use(<4 x float> [[YSPLAT]])
; CHECK-NEXT:    [[TMP1:%.*]] = fmul fast <4 x float> [[Y]], [[X]]
; CHECK-NEXT:    [[BSPLAT:%.*]] = shufflevector <4 x float> [[TMP1]], <4 x float> poison, <4 x i32> zeroinitializer
; CHECK-NEXT:    ret <4 x float> [[BSPLAT]]
;
  %xsplat = shufflevector <4 x float> %x, <4 x float> poison, <4 x i32> zeroinitializer
  call void @use(<4 x float> %xsplat)
  %ysplat = shufflevector <4 x float> %y, <4 x float> poison, <4 x i32> zeroinitializer
  call void @use(<4 x float> %ysplat)
  %b = fmul fast <4 x float> %xsplat, %ysplat
  %bsplat = shufflevector <4 x float> %b, <4 x float> poison, <4 x i32> zeroinitializer
  ret <4 x float> %bsplat
}

define <vscale x 4 x i32> @vscale_splat_udiv_splat_x(<vscale x 4 x i32> %x, <vscale x 4 x i32> %y) {
; CHECK-LABEL: @vscale_splat_udiv_splat_x(
; CHECK-NEXT:    [[XSPLAT:%.*]] = shufflevector <vscale x 4 x i32> [[X:%.*]], <vscale x 4 x i32> poison, <vscale x 4 x i32> zeroinitializer
; CHECK-NEXT:    [[B:%.*]] = udiv <vscale x 4 x i32> [[XSPLAT]], [[Y:%.*]]
; CHECK-NEXT:    [[BSPLAT:%.*]] = shufflevector <vscale x 4 x i32> [[B]], <vscale x 4 x i32> poison, <vscale x 4 x i32> zeroinitializer
; CHECK-NEXT:    ret <vscale x 4 x i32> [[BSPLAT]]
;
  %xsplat = shufflevector <vscale x 4 x i32> %x, <vscale x 4 x i32> poison, <vscale x 4 x i32> zeroinitializer
  %b = udiv <vscale x 4 x i32> %xsplat, %y
  %bsplat = shufflevector <vscale x 4 x i32> %b, <vscale x 4 x i32> poison, <vscale x 4 x i32> zeroinitializer
  ret <vscale x 4 x i32> %bsplat
}

define <vscale x 4 x i32> @vscale_splat_urem_splat_x(<vscale x 4 x i32> %x, <vscale x 4 x i32> %y) {
; CHECK-LABEL: @vscale_splat_urem_splat_x(
; CHECK-NEXT:    [[XSPLAT:%.*]] = shufflevector <vscale x 4 x i32> [[X:%.*]], <vscale x 4 x i32> poison, <vscale x 4 x i32> zeroinitializer
; CHECK-NEXT:    [[B:%.*]] = urem <vscale x 4 x i32> [[XSPLAT]], [[Y:%.*]]
; CHECK-NEXT:    [[BSPLAT:%.*]] = shufflevector <vscale x 4 x i32> [[B]], <vscale x 4 x i32> poison, <vscale x 4 x i32> zeroinitializer
; CHECK-NEXT:    ret <vscale x 4 x i32> [[BSPLAT]]
;
  %xsplat = shufflevector <vscale x 4 x i32> %x, <vscale x 4 x i32> poison, <vscale x 4 x i32> zeroinitializer
  %b = urem <vscale x 4 x i32> %xsplat, %y
  %bsplat = shufflevector <vscale x 4 x i32> %b, <vscale x 4 x i32> poison, <vscale x 4 x i32> zeroinitializer
  ret <vscale x 4 x i32> %bsplat
}

define <vscale x 4 x i32> @vscale_splat_binop_splat_y(<vscale x 4 x i32> %x, <vscale x 4 x i32> %y) {
; CHECK-LABEL: @vscale_splat_binop_splat_y(
; CHECK-NEXT:    [[YSPLAT:%.*]] = shufflevector <vscale x 4 x i32> [[Y:%.*]], <vscale x 4 x i32> poison, <vscale x 4 x i32> zeroinitializer
; CHECK-NEXT:    [[B:%.*]] = sdiv <vscale x 4 x i32> [[X:%.*]], [[YSPLAT]]
; CHECK-NEXT:    [[BSPLAT:%.*]] = shufflevector <vscale x 4 x i32> [[B]], <vscale x 4 x i32> poison, <vscale x 4 x i32> zeroinitializer
; CHECK-NEXT:    ret <vscale x 4 x i32> [[BSPLAT]]
;
  %ysplat = shufflevector <vscale x 4 x i32> %y, <vscale x 4 x i32> poison, <vscale x 4 x i32> zeroinitializer
  %b = sdiv <vscale x 4 x i32> %x, %ysplat
  %bsplat = shufflevector <vscale x 4 x i32> %b, <vscale x 4 x i32> poison, <vscale x 4 x i32> zeroinitializer
  ret <vscale x 4 x i32> %bsplat
}

define <vscale x 4 x i32> @vscale_splat_binop_splat_x_splat_y(<vscale x 4 x i32> %x, <vscale x 4 x i32> %y) {
; CHECK-LABEL: @vscale_splat_binop_splat_x_splat_y(
; CHECK-NEXT:    [[TMP1:%.*]] = ashr <vscale x 4 x i32> [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    [[B:%.*]] = shufflevector <vscale x 4 x i32> [[TMP1]], <vscale x 4 x i32> poison, <vscale x 4 x i32> zeroinitializer
; CHECK-NEXT:    ret <vscale x 4 x i32> [[B]]
;
  %xsplat = shufflevector <vscale x 4 x i32> %x, <vscale x 4 x i32> poison, <vscale x 4 x i32> zeroinitializer
  %ysplat = shufflevector <vscale x 4 x i32> %y, <vscale x 4 x i32> poison, <vscale x 4 x i32> zeroinitializer
  %b = ashr <vscale x 4 x i32> %xsplat, %ysplat
  %bsplat = shufflevector <vscale x 4 x i32> %b, <vscale x 4 x i32> poison, <vscale x 4 x i32> zeroinitializer
  ret <vscale x 4 x i32> %bsplat
}

define <vscale x 4 x i32> @vscale_splat_binop_splat_x_splat_y_calls(<vscale x 4 x i32> %x, <vscale x 4 x i32> %y) {
; CHECK-LABEL: @vscale_splat_binop_splat_x_splat_y_calls(
; CHECK-NEXT:    [[XSPLAT:%.*]] = shufflevector <vscale x 4 x i32> [[X:%.*]], <vscale x 4 x i32> poison, <vscale x 4 x i32> zeroinitializer
; CHECK-NEXT:    call void @use_v(<vscale x 4 x i32> [[XSPLAT]])
; CHECK-NEXT:    [[YSPLAT:%.*]] = shufflevector <vscale x 4 x i32> [[Y:%.*]], <vscale x 4 x i32> poison, <vscale x 4 x i32> zeroinitializer
; CHECK-NEXT:    call void @use_v(<vscale x 4 x i32> [[YSPLAT]])
; CHECK-NEXT:    [[TMP1:%.*]] = lshr <vscale x 4 x i32> [[X]], [[Y]]
; CHECK-NEXT:    [[BSPLAT:%.*]] = shufflevector <vscale x 4 x i32> [[TMP1]], <vscale x 4 x i32> poison, <vscale x 4 x i32> zeroinitializer
; CHECK-NEXT:    ret <vscale x 4 x i32> [[BSPLAT]]
;
  %xsplat = shufflevector <vscale x 4 x i32> %x, <vscale x 4 x i32> poison, <vscale x 4 x i32> zeroinitializer
  call void @use_v(<vscale x 4 x i32> %xsplat)
  %ysplat = shufflevector <vscale x 4 x i32> %y, <vscale x 4 x i32> poison, <vscale x 4 x i32> zeroinitializer
  call void @use_v(<vscale x 4 x i32> %ysplat)
  %b = lshr <vscale x 4 x i32> %xsplat, %ysplat
  %bsplat = shufflevector <vscale x 4 x i32> %b, <vscale x 4 x i32> poison, <vscale x 4 x i32> zeroinitializer
  ret <vscale x 4 x i32> %bsplat
}

define <2 x double> @shuffle_op2_0th_element_mask(ptr %a, ptr %b) {
; CHECK-LABEL: @shuffle_op2_0th_element_mask(
; CHECK-NEXT:    [[TMP1:%.*]] = load <2 x double>, ptr [[A:%.*]], align 16
; CHECK-NEXT:    [[TMP2:%.*]] = load <2 x double>, ptr [[B:%.*]], align 16
; CHECK-NEXT:    [[TMP3:%.*]] = fsub <2 x double> [[TMP2]], [[TMP1]]
; CHECK-NEXT:    [[SHUFFLE:%.*]] = shufflevector <2 x double> [[TMP3]], <2 x double> poison, <2 x i32> zeroinitializer
; CHECK-NEXT:    ret <2 x double> [[SHUFFLE]]
;
  %1 = load <2 x double>, ptr %a, align 16
  %2 = shufflevector <2 x double> %1, <2 x double> poison, <2 x i32> zeroinitializer
  %3 = load <2 x double>, ptr %b, align 16
  %sub = fsub <2 x double> %3, %2
  %shuffle = shufflevector <2 x double> %sub, <2 x double> %sub, <2 x i32> <i32 2, i32 2>
  ret <2 x double> %shuffle
}

; This should not create an extra binop.

define <2 x i4> @splat_binop_splat_uses(<2 x i4> %x, <2 x i4> %y) {
; CHECK-LABEL: @splat_binop_splat_uses(
; CHECK-NEXT:    [[XSPLAT:%.*]] = shufflevector <2 x i4> [[X:%.*]], <2 x i4> poison, <2 x i32> zeroinitializer
; CHECK-NEXT:    [[XY:%.*]] = mul <2 x i4> [[XSPLAT]], [[Y:%.*]]
; CHECK-NEXT:    [[MSPLAT:%.*]] = shufflevector <2 x i4> [[XY]], <2 x i4> poison, <2 x i32> zeroinitializer
; CHECK-NEXT:    [[RES:%.*]] = add <2 x i4> [[XY]], [[MSPLAT]]
; CHECK-NEXT:    ret <2 x i4> [[RES]]
;
  %xsplat = shufflevector <2 x i4> %x, <2 x i4> poison, <2 x i32> zeroinitializer
  %xy = mul <2 x i4> %xsplat, %y
  %msplat = shufflevector <2 x i4> %xy, <2 x i4> poison, <2 x i32> zeroinitializer
  %res = add <2 x i4> %xy, %msplat
  ret <2 x i4> %res
}

declare void @use(<4 x i8>)
declare void @use_v(<vscale x 4 x i32>)
