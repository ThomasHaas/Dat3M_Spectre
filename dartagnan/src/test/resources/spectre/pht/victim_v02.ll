; ModuleID = '/Users/thomashaas/IdeaProjects/Dat3M/benchmarks/c/spectre/pht/victim_v02.c'
source_filename = "/Users/thomashaas/IdeaProjects/Dat3M/benchmarks/c/spectre/pht/victim_v02.c"
target datalayout = "e-m:o-i64:64-i128:128-n32:64-S128"
target triple = "arm64-apple-macosx13.0.0"

@A = dso_local global [16 x i8] zeroinitializer, align 1, !dbg !0
@B = dso_local global [16 x i8] zeroinitializer, align 1, !dbg !6
@secret = dso_local global i8 42, align 1, !dbg !15
@temp = dso_local global i8 0, align 1, !dbg !17

; Function Attrs: noinline nounwind ssp uwtable
define dso_local void @leakByteLocalFunction(i8 zeroext %0) #0 !dbg !29 {
  %2 = alloca i8, align 1
  store i8 %0, i8* %2, align 1
  call void @llvm.dbg.declare(metadata i8* %2, metadata !32, metadata !DIExpression()), !dbg !33
  %3 = load i8, i8* %2, align 1, !dbg !34
  %4 = zext i8 %3 to i64, !dbg !35
  %5 = getelementptr inbounds [16 x i8], [16 x i8]* @B, i64 0, i64 %4, !dbg !35
  %6 = load i8, i8* %5, align 1, !dbg !35
  %7 = zext i8 %6 to i32, !dbg !35
  %8 = load volatile i8, i8* @temp, align 1, !dbg !36
  %9 = zext i8 %8 to i32, !dbg !36
  %10 = and i32 %9, %7, !dbg !36
  %11 = trunc i32 %10 to i8, !dbg !36
  store volatile i8 %11, i8* @temp, align 1, !dbg !36
  %12 = load i8, i8* %2, align 1, !dbg !37
  %13 = zext i8 %12 to i32, !dbg !37
  %14 = icmp ne i32 %13, 42, !dbg !38
  %15 = zext i1 %14 to i32, !dbg !38
  call void @__VERIFIER_assert(i32 %15), !dbg !39
  ret void, !dbg !40
}

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare void @__VERIFIER_assert(i32) #2

; Function Attrs: noinline nounwind ssp uwtable
define dso_local void @victim_v2(i32 %0) #0 !dbg !41 {
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  store i32 %0, i32* %2, align 4
  call void @llvm.dbg.declare(metadata i32* %2, metadata !45, metadata !DIExpression()), !dbg !46
  %4 = load i32, i32* %2, align 4, !dbg !47
  %5 = icmp slt i32 %4, 16, !dbg !49
  br i1 %5, label %6, label %14, !dbg !50

6:                                                ; preds = %1
  call void @llvm.dbg.declare(metadata i32* %3, metadata !51, metadata !DIExpression()), !dbg !53
  %7 = load i32, i32* %2, align 4, !dbg !54
  %8 = sext i32 %7 to i64, !dbg !55
  %9 = getelementptr inbounds [16 x i8], [16 x i8]* @A, i64 0, i64 %8, !dbg !55
  %10 = load i8, i8* %9, align 1, !dbg !55
  %11 = zext i8 %10 to i32, !dbg !55
  store i32 %11, i32* %3, align 4, !dbg !53
  %12 = load i32, i32* %3, align 4, !dbg !56
  %13 = trunc i32 %12 to i8, !dbg !56
  call void @leakByteLocalFunction(i8 zeroext %13), !dbg !57
  br label %14, !dbg !58

14:                                               ; preds = %6, %1
  ret void, !dbg !59
}

; Function Attrs: noinline nounwind ssp uwtable
define dso_local i32 @main() #0 !dbg !60 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  store i32 0, i32* %1, align 4
  call void @llvm.dbg.declare(metadata i32* %2, metadata !63, metadata !DIExpression()), !dbg !64
  %3 = call i32 @__VERIFIER_nondet_int(), !dbg !65
  store i32 %3, i32* %2, align 4, !dbg !64
  %4 = load i32, i32* %2, align 4, !dbg !66
  %5 = icmp sge i32 %4, 0, !dbg !67
  %6 = zext i1 %5 to i32, !dbg !67
  call void @__VERIFIER_assume(i32 %6), !dbg !68
  %7 = load i32, i32* %2, align 4, !dbg !69
  call void @victim_v2(i32 %7), !dbg !70
  ret i32 0, !dbg !71
}

declare i32 @__VERIFIER_nondet_int() #2

declare void @__VERIFIER_assume(i32) #2

attributes #0 = { noinline nounwind ssp uwtable "disable-tail-calls"="false" "frame-pointer"="non-leaf" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-a12" "target-features"="+aes,+crc,+crypto,+fp-armv8,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+v8.3a,+zcm,+zcz" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nofree nosync nounwind readnone speculatable willreturn }
attributes #2 = { "disable-tail-calls"="false" "frame-pointer"="non-leaf" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-a12" "target-features"="+aes,+crc,+crypto,+fp-armv8,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+v8.3a,+zcm,+zcz" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!20, !21, !22, !23, !24, !25, !26, !27}
!llvm.ident = !{!28}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "A", scope: !2, file: !8, line: 7, type: !9, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "Homebrew clang version 12.0.1", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, globals: !5, nameTableKind: None, sysroot: "/Library/Developer/CommandLineTools/SDKs/MacOSX13.sdk", sdk: "MacOSX13.sdk")
!3 = !DIFile(filename: "/Users/thomashaas/IdeaProjects/Dat3M/benchmarks/c/spectre/pht/victim_v02.c", directory: "/Users/thomashaas/IdeaProjects/Dat3M")
!4 = !{}
!5 = !{!0, !6, !15, !17}
!6 = !DIGlobalVariableExpression(var: !7, expr: !DIExpression())
!7 = distinct !DIGlobalVariable(name: "B", scope: !2, file: !8, line: 8, type: !9, isLocal: false, isDefinition: true)
!8 = !DIFile(filename: "benchmarks/c/spectre/pht/victim_v02.c", directory: "/Users/thomashaas/IdeaProjects/Dat3M")
!9 = !DICompositeType(tag: DW_TAG_array_type, baseType: !10, size: 128, elements: !13)
!10 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint8_t", file: !11, line: 31, baseType: !12)
!11 = !DIFile(filename: "/Library/Developer/CommandLineTools/SDKs/MacOSX13.sdk/usr/include/_types/_uint8_t.h", directory: "")
!12 = !DIBasicType(name: "unsigned char", size: 8, encoding: DW_ATE_unsigned_char)
!13 = !{!14}
!14 = !DISubrange(count: 16)
!15 = !DIGlobalVariableExpression(var: !16, expr: !DIExpression())
!16 = distinct !DIGlobalVariable(name: "secret", scope: !2, file: !8, line: 9, type: !10, isLocal: false, isDefinition: true)
!17 = !DIGlobalVariableExpression(var: !18, expr: !DIExpression())
!18 = distinct !DIGlobalVariable(name: "temp", scope: !2, file: !8, line: 11, type: !19, isLocal: false, isDefinition: true)
!19 = !DIDerivedType(tag: DW_TAG_volatile_type, baseType: !10)
!20 = !{i32 7, !"Dwarf Version", i32 4}
!21 = !{i32 2, !"Debug Info Version", i32 3}
!22 = !{i32 1, !"wchar_size", i32 4}
!23 = !{i32 1, !"branch-target-enforcement", i32 0}
!24 = !{i32 1, !"sign-return-address", i32 0}
!25 = !{i32 1, !"sign-return-address-all", i32 0}
!26 = !{i32 1, !"sign-return-address-with-bkey", i32 0}
!27 = !{i32 7, !"PIC Level", i32 2}
!28 = !{!"Homebrew clang version 12.0.1"}
!29 = distinct !DISubprogram(name: "leakByteLocalFunction", scope: !8, file: !8, line: 13, type: !30, scopeLine: 13, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!30 = !DISubroutineType(types: !31)
!31 = !{null, !10}
!32 = !DILocalVariable(name: "k", arg: 1, scope: !29, file: !8, line: 13, type: !10)
!33 = !DILocation(line: 13, column: 36, scope: !29)
!34 = !DILocation(line: 14, column: 16, scope: !29)
!35 = !DILocation(line: 14, column: 13, scope: !29)
!36 = !DILocation(line: 14, column: 10, scope: !29)
!37 = !DILocation(line: 15, column: 23, scope: !29)
!38 = !DILocation(line: 15, column: 25, scope: !29)
!39 = !DILocation(line: 15, column: 5, scope: !29)
!40 = !DILocation(line: 16, column: 1, scope: !29)
!41 = distinct !DISubprogram(name: "victim_v2", scope: !8, file: !8, line: 17, type: !42, scopeLine: 17, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!42 = !DISubroutineType(types: !43)
!43 = !{null, !44}
!44 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!45 = !DILocalVariable(name: "idx", arg: 1, scope: !41, file: !8, line: 17, type: !44)
!46 = !DILocation(line: 17, column: 20, scope: !41)
!47 = !DILocation(line: 18, column: 9, scope: !48)
!48 = distinct !DILexicalBlock(scope: !41, file: !8, line: 18, column: 9)
!49 = !DILocation(line: 18, column: 13, scope: !48)
!50 = !DILocation(line: 18, column: 9, scope: !41)
!51 = !DILocalVariable(name: "var", scope: !52, file: !8, line: 19, type: !44)
!52 = distinct !DILexicalBlock(scope: !48, file: !8, line: 18, column: 21)
!53 = !DILocation(line: 19, column: 13, scope: !52)
!54 = !DILocation(line: 19, column: 21, scope: !52)
!55 = !DILocation(line: 19, column: 19, scope: !52)
!56 = !DILocation(line: 20, column: 31, scope: !52)
!57 = !DILocation(line: 20, column: 9, scope: !52)
!58 = !DILocation(line: 21, column: 5, scope: !52)
!59 = !DILocation(line: 22, column: 1, scope: !41)
!60 = distinct !DISubprogram(name: "main", scope: !8, file: !8, line: 24, type: !61, scopeLine: 25, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!61 = !DISubroutineType(types: !62)
!62 = !{!44}
!63 = !DILocalVariable(name: "idx", scope: !60, file: !8, line: 26, type: !44)
!64 = !DILocation(line: 26, column: 9, scope: !60)
!65 = !DILocation(line: 26, column: 15, scope: !60)
!66 = !DILocation(line: 27, column: 23, scope: !60)
!67 = !DILocation(line: 27, column: 27, scope: !60)
!68 = !DILocation(line: 27, column: 5, scope: !60)
!69 = !DILocation(line: 28, column: 15, scope: !60)
!70 = !DILocation(line: 28, column: 5, scope: !60)
!71 = !DILocation(line: 29, column: 5, scope: !60)
