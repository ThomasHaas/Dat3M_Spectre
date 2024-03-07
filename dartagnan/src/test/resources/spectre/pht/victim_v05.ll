; ModuleID = '/Users/thomashaas/IdeaProjects/Dat3M/benchmarks/c/spectre/pht/victim_v05.c'
source_filename = "/Users/thomashaas/IdeaProjects/Dat3M/benchmarks/c/spectre/pht/victim_v05.c"
target datalayout = "e-m:o-i64:64-i128:128-n32:64-S128"
target triple = "arm64-apple-macosx13.0.0"

@A = dso_local global [16 x i8] zeroinitializer, align 1, !dbg !0
@B = dso_local global [16 x i8] zeroinitializer, align 1, !dbg !6
@secret = dso_local global i8 42, align 1, !dbg !15
@temp = dso_local global i8 0, align 1, !dbg !17

; Function Attrs: noinline nounwind ssp uwtable
define dso_local void @victim_v5(i32 %0) #0 !dbg !29 {
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i32 %0, i32* %2, align 4
  call void @llvm.dbg.declare(metadata i32* %2, metadata !33, metadata !DIExpression()), !dbg !34
  call void @llvm.dbg.declare(metadata i32* %3, metadata !35, metadata !DIExpression()), !dbg !36
  %5 = load i32, i32* %2, align 4, !dbg !37
  %6 = icmp slt i32 %5, 16, !dbg !39
  br i1 %6, label %7, label %35, !dbg !40

7:                                                ; preds = %1
  %8 = load i32, i32* %2, align 4, !dbg !41
  %9 = sub nsw i32 %8, 1, !dbg !44
  store i32 %9, i32* %3, align 4, !dbg !45
  br label %10, !dbg !46

10:                                               ; preds = %31, %7
  %11 = load i32, i32* %3, align 4, !dbg !47
  %12 = icmp sge i32 %11, 0, !dbg !49
  br i1 %12, label %13, label %34, !dbg !50

13:                                               ; preds = %10
  call void @llvm.dbg.declare(metadata i32* %4, metadata !51, metadata !DIExpression()), !dbg !53
  %14 = load i32, i32* %2, align 4, !dbg !54
  %15 = sext i32 %14 to i64, !dbg !55
  %16 = getelementptr inbounds [16 x i8], [16 x i8]* @A, i64 0, i64 %15, !dbg !55
  %17 = load i8, i8* %16, align 1, !dbg !55
  %18 = zext i8 %17 to i32, !dbg !55
  store i32 %18, i32* %4, align 4, !dbg !53
  %19 = load i32, i32* %4, align 4, !dbg !56
  %20 = sext i32 %19 to i64, !dbg !57
  %21 = getelementptr inbounds [16 x i8], [16 x i8]* @B, i64 0, i64 %20, !dbg !57
  %22 = load i8, i8* %21, align 1, !dbg !57
  %23 = zext i8 %22 to i32, !dbg !57
  %24 = load volatile i8, i8* @temp, align 1, !dbg !58
  %25 = zext i8 %24 to i32, !dbg !58
  %26 = and i32 %25, %23, !dbg !58
  %27 = trunc i32 %26 to i8, !dbg !58
  store volatile i8 %27, i8* @temp, align 1, !dbg !58
  %28 = load i32, i32* %4, align 4, !dbg !59
  %29 = icmp ne i32 %28, 42, !dbg !60
  %30 = zext i1 %29 to i32, !dbg !60
  call void @__VERIFIER_assert(i32 %30), !dbg !61
  br label %31, !dbg !62

31:                                               ; preds = %13
  %32 = load i32, i32* %3, align 4, !dbg !63
  %33 = add nsw i32 %32, -1, !dbg !63
  store i32 %33, i32* %3, align 4, !dbg !63
  br label %10, !dbg !64, !llvm.loop !65

34:                                               ; preds = %10
  br label %35, !dbg !68

35:                                               ; preds = %34, %1
  ret void, !dbg !69
}

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare void @__VERIFIER_assert(i32) #2

; Function Attrs: noinline nounwind ssp uwtable
define dso_local i32 @main() #0 !dbg !70 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  store i32 0, i32* %1, align 4
  call void @llvm.dbg.declare(metadata i32* %2, metadata !73, metadata !DIExpression()), !dbg !74
  %3 = call i32 @__VERIFIER_nondet_int(), !dbg !75
  store i32 %3, i32* %2, align 4, !dbg !74
  %4 = load i32, i32* %2, align 4, !dbg !76
  %5 = icmp sge i32 %4, 0, !dbg !77
  %6 = zext i1 %5 to i32, !dbg !77
  call void @__VERIFIER_assume(i32 %6), !dbg !78
  %7 = load i32, i32* %2, align 4, !dbg !79
  call void @victim_v5(i32 %7), !dbg !80
  ret i32 0, !dbg !81
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
!3 = !DIFile(filename: "/Users/thomashaas/IdeaProjects/Dat3M/benchmarks/c/spectre/pht/victim_v05.c", directory: "/Users/thomashaas/IdeaProjects/Dat3M")
!4 = !{}
!5 = !{!0, !6, !15, !17}
!6 = !DIGlobalVariableExpression(var: !7, expr: !DIExpression())
!7 = distinct !DIGlobalVariable(name: "B", scope: !2, file: !8, line: 8, type: !9, isLocal: false, isDefinition: true)
!8 = !DIFile(filename: "benchmarks/c/spectre/pht/victim_v05.c", directory: "/Users/thomashaas/IdeaProjects/Dat3M")
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
!29 = distinct !DISubprogram(name: "victim_v5", scope: !8, file: !8, line: 13, type: !30, scopeLine: 13, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!30 = !DISubroutineType(types: !31)
!31 = !{null, !32}
!32 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!33 = !DILocalVariable(name: "idx", arg: 1, scope: !29, file: !8, line: 13, type: !32)
!34 = !DILocation(line: 13, column: 20, scope: !29)
!35 = !DILocalVariable(name: "i", scope: !29, file: !8, line: 14, type: !32)
!36 = !DILocation(line: 14, column: 9, scope: !29)
!37 = !DILocation(line: 15, column: 9, scope: !38)
!38 = distinct !DILexicalBlock(scope: !29, file: !8, line: 15, column: 9)
!39 = !DILocation(line: 15, column: 13, scope: !38)
!40 = !DILocation(line: 15, column: 9, scope: !29)
!41 = !DILocation(line: 16, column: 18, scope: !42)
!42 = distinct !DILexicalBlock(scope: !43, file: !8, line: 16, column: 9)
!43 = distinct !DILexicalBlock(scope: !38, file: !8, line: 15, column: 21)
!44 = !DILocation(line: 16, column: 22, scope: !42)
!45 = !DILocation(line: 16, column: 16, scope: !42)
!46 = !DILocation(line: 16, column: 14, scope: !42)
!47 = !DILocation(line: 16, column: 27, scope: !48)
!48 = distinct !DILexicalBlock(scope: !42, file: !8, line: 16, column: 9)
!49 = !DILocation(line: 16, column: 29, scope: !48)
!50 = !DILocation(line: 16, column: 9, scope: !42)
!51 = !DILocalVariable(name: "var", scope: !52, file: !8, line: 17, type: !32)
!52 = distinct !DILexicalBlock(scope: !48, file: !8, line: 16, column: 40)
!53 = !DILocation(line: 17, column: 17, scope: !52)
!54 = !DILocation(line: 17, column: 25, scope: !52)
!55 = !DILocation(line: 17, column: 23, scope: !52)
!56 = !DILocation(line: 18, column: 23, scope: !52)
!57 = !DILocation(line: 18, column: 21, scope: !52)
!58 = !DILocation(line: 18, column: 18, scope: !52)
!59 = !DILocation(line: 19, column: 31, scope: !52)
!60 = !DILocation(line: 19, column: 35, scope: !52)
!61 = !DILocation(line: 19, column: 13, scope: !52)
!62 = !DILocation(line: 20, column: 9, scope: !52)
!63 = !DILocation(line: 16, column: 36, scope: !48)
!64 = !DILocation(line: 16, column: 9, scope: !48)
!65 = distinct !{!65, !50, !66, !67}
!66 = !DILocation(line: 20, column: 9, scope: !42)
!67 = !{!"llvm.loop.mustprogress"}
!68 = !DILocation(line: 21, column: 5, scope: !43)
!69 = !DILocation(line: 22, column: 1, scope: !29)
!70 = distinct !DISubprogram(name: "main", scope: !8, file: !8, line: 24, type: !71, scopeLine: 25, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!71 = !DISubroutineType(types: !72)
!72 = !{!32}
!73 = !DILocalVariable(name: "idx", scope: !70, file: !8, line: 26, type: !32)
!74 = !DILocation(line: 26, column: 9, scope: !70)
!75 = !DILocation(line: 26, column: 15, scope: !70)
!76 = !DILocation(line: 27, column: 23, scope: !70)
!77 = !DILocation(line: 27, column: 27, scope: !70)
!78 = !DILocation(line: 27, column: 5, scope: !70)
!79 = !DILocation(line: 28, column: 15, scope: !70)
!80 = !DILocation(line: 28, column: 5, scope: !70)
!81 = !DILocation(line: 29, column: 5, scope: !70)
