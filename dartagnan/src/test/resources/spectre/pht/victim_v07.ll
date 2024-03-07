; ModuleID = '/Users/thomashaas/IdeaProjects/Dat3M/benchmarks/c/spectre/pht/victim_v07.c'
source_filename = "/Users/thomashaas/IdeaProjects/Dat3M/benchmarks/c/spectre/pht/victim_v07.c"
target datalayout = "e-m:o-i64:64-i128:128-n32:64-S128"
target triple = "arm64-apple-macosx13.0.0"

@A = dso_local global [16 x i8] zeroinitializer, align 1, !dbg !0
@B = dso_local global [16 x i8] zeroinitializer, align 1, !dbg !6
@secret = dso_local global i8 42, align 1, !dbg !15
@temp = dso_local global i8 0, align 1, !dbg !17
@victim_v7.last_idx = internal global i32 0, align 4, !dbg !20

; Function Attrs: noinline nounwind ssp uwtable
define dso_local void @victim_v7(i32 %0) #0 !dbg !22 {
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  store i32 %0, i32* %2, align 4
  call void @llvm.dbg.declare(metadata i32* %2, metadata !35, metadata !DIExpression()), !dbg !36
  %4 = load i32, i32* %2, align 4, !dbg !37
  %5 = load i32, i32* @victim_v7.last_idx, align 4, !dbg !39
  %6 = icmp eq i32 %4, %5, !dbg !40
  br i1 %6, label %7, label %25, !dbg !41

7:                                                ; preds = %1
  call void @llvm.dbg.declare(metadata i32* %3, metadata !42, metadata !DIExpression()), !dbg !44
  %8 = load i32, i32* %2, align 4, !dbg !45
  %9 = sext i32 %8 to i64, !dbg !46
  %10 = getelementptr inbounds [16 x i8], [16 x i8]* @A, i64 0, i64 %9, !dbg !46
  %11 = load i8, i8* %10, align 1, !dbg !46
  %12 = zext i8 %11 to i32, !dbg !46
  store i32 %12, i32* %3, align 4, !dbg !44
  %13 = load i32, i32* %3, align 4, !dbg !47
  %14 = sext i32 %13 to i64, !dbg !48
  %15 = getelementptr inbounds [16 x i8], [16 x i8]* @B, i64 0, i64 %14, !dbg !48
  %16 = load i8, i8* %15, align 1, !dbg !48
  %17 = zext i8 %16 to i32, !dbg !48
  %18 = load volatile i8, i8* @temp, align 1, !dbg !49
  %19 = zext i8 %18 to i32, !dbg !49
  %20 = and i32 %19, %17, !dbg !49
  %21 = trunc i32 %20 to i8, !dbg !49
  store volatile i8 %21, i8* @temp, align 1, !dbg !49
  %22 = load i32, i32* %3, align 4, !dbg !50
  %23 = icmp ne i32 %22, 42, !dbg !51
  %24 = zext i1 %23 to i32, !dbg !51
  call void @__VERIFIER_assert(i32 %24), !dbg !52
  br label %25, !dbg !53

25:                                               ; preds = %7, %1
  %26 = load i32, i32* %2, align 4, !dbg !54
  %27 = icmp slt i32 %26, 16, !dbg !56
  br i1 %27, label %28, label %30, !dbg !57

28:                                               ; preds = %25
  %29 = load i32, i32* %2, align 4, !dbg !58
  store i32 %29, i32* @victim_v7.last_idx, align 4, !dbg !60
  br label %30, !dbg !61

30:                                               ; preds = %28, %25
  ret void, !dbg !62
}

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare void @__VERIFIER_assert(i32) #2

; Function Attrs: noinline nounwind ssp uwtable
define dso_local i32 @main() #0 !dbg !63 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  store i32 0, i32* %1, align 4
  call void @llvm.dbg.declare(metadata i32* %2, metadata !66, metadata !DIExpression()), !dbg !67
  %3 = call i32 @__VERIFIER_nondet_int(), !dbg !68
  store i32 %3, i32* %2, align 4, !dbg !67
  %4 = load i32, i32* %2, align 4, !dbg !69
  %5 = icmp sge i32 %4, 0, !dbg !70
  %6 = zext i1 %5 to i32, !dbg !70
  call void @__VERIFIER_assume(i32 %6), !dbg !71
  %7 = load i32, i32* %2, align 4, !dbg !72
  call void @victim_v7(i32 %7), !dbg !73
  ret i32 0, !dbg !74
}

declare i32 @__VERIFIER_nondet_int() #2

declare void @__VERIFIER_assume(i32) #2

attributes #0 = { noinline nounwind ssp uwtable "disable-tail-calls"="false" "frame-pointer"="non-leaf" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-a12" "target-features"="+aes,+crc,+crypto,+fp-armv8,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+v8.3a,+zcm,+zcz" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nofree nosync nounwind readnone speculatable willreturn }
attributes #2 = { "disable-tail-calls"="false" "frame-pointer"="non-leaf" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="apple-a12" "target-features"="+aes,+crc,+crypto,+fp-armv8,+fullfp16,+lse,+neon,+ras,+rcpc,+rdm,+sha2,+v8.3a,+zcm,+zcz" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!26, !27, !28, !29, !30, !31, !32, !33}
!llvm.ident = !{!34}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "A", scope: !2, file: !8, line: 7, type: !9, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "Homebrew clang version 12.0.1", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, globals: !5, nameTableKind: None, sysroot: "/Library/Developer/CommandLineTools/SDKs/MacOSX13.sdk", sdk: "MacOSX13.sdk")
!3 = !DIFile(filename: "/Users/thomashaas/IdeaProjects/Dat3M/benchmarks/c/spectre/pht/victim_v07.c", directory: "/Users/thomashaas/IdeaProjects/Dat3M")
!4 = !{}
!5 = !{!0, !6, !15, !17, !20}
!6 = !DIGlobalVariableExpression(var: !7, expr: !DIExpression())
!7 = distinct !DIGlobalVariable(name: "B", scope: !2, file: !8, line: 8, type: !9, isLocal: false, isDefinition: true)
!8 = !DIFile(filename: "benchmarks/c/spectre/pht/victim_v07.c", directory: "/Users/thomashaas/IdeaProjects/Dat3M")
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
!20 = !DIGlobalVariableExpression(var: !21, expr: !DIExpression())
!21 = distinct !DIGlobalVariable(name: "last_idx", scope: !22, file: !8, line: 14, type: !25, isLocal: true, isDefinition: true)
!22 = distinct !DISubprogram(name: "victim_v7", scope: !8, file: !8, line: 13, type: !23, scopeLine: 13, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!23 = !DISubroutineType(types: !24)
!24 = !{null, !25}
!25 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!26 = !{i32 7, !"Dwarf Version", i32 4}
!27 = !{i32 2, !"Debug Info Version", i32 3}
!28 = !{i32 1, !"wchar_size", i32 4}
!29 = !{i32 1, !"branch-target-enforcement", i32 0}
!30 = !{i32 1, !"sign-return-address", i32 0}
!31 = !{i32 1, !"sign-return-address-all", i32 0}
!32 = !{i32 1, !"sign-return-address-with-bkey", i32 0}
!33 = !{i32 7, !"PIC Level", i32 2}
!34 = !{!"Homebrew clang version 12.0.1"}
!35 = !DILocalVariable(name: "idx", arg: 1, scope: !22, file: !8, line: 13, type: !25)
!36 = !DILocation(line: 13, column: 20, scope: !22)
!37 = !DILocation(line: 15, column: 9, scope: !38)
!38 = distinct !DILexicalBlock(scope: !22, file: !8, line: 15, column: 9)
!39 = !DILocation(line: 15, column: 16, scope: !38)
!40 = !DILocation(line: 15, column: 13, scope: !38)
!41 = !DILocation(line: 15, column: 9, scope: !22)
!42 = !DILocalVariable(name: "var", scope: !43, file: !8, line: 16, type: !25)
!43 = distinct !DILexicalBlock(scope: !38, file: !8, line: 15, column: 26)
!44 = !DILocation(line: 16, column: 13, scope: !43)
!45 = !DILocation(line: 16, column: 21, scope: !43)
!46 = !DILocation(line: 16, column: 19, scope: !43)
!47 = !DILocation(line: 17, column: 19, scope: !43)
!48 = !DILocation(line: 17, column: 17, scope: !43)
!49 = !DILocation(line: 17, column: 14, scope: !43)
!50 = !DILocation(line: 18, column: 27, scope: !43)
!51 = !DILocation(line: 18, column: 31, scope: !43)
!52 = !DILocation(line: 18, column: 9, scope: !43)
!53 = !DILocation(line: 19, column: 5, scope: !43)
!54 = !DILocation(line: 20, column: 9, scope: !55)
!55 = distinct !DILexicalBlock(scope: !22, file: !8, line: 20, column: 9)
!56 = !DILocation(line: 20, column: 13, scope: !55)
!57 = !DILocation(line: 20, column: 9, scope: !22)
!58 = !DILocation(line: 21, column: 20, scope: !59)
!59 = distinct !DILexicalBlock(scope: !55, file: !8, line: 20, column: 21)
!60 = !DILocation(line: 21, column: 18, scope: !59)
!61 = !DILocation(line: 22, column: 5, scope: !59)
!62 = !DILocation(line: 23, column: 1, scope: !22)
!63 = distinct !DISubprogram(name: "main", scope: !8, file: !8, line: 25, type: !64, scopeLine: 26, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!64 = !DISubroutineType(types: !65)
!65 = !{!25}
!66 = !DILocalVariable(name: "idx", scope: !63, file: !8, line: 27, type: !25)
!67 = !DILocation(line: 27, column: 9, scope: !63)
!68 = !DILocation(line: 27, column: 15, scope: !63)
!69 = !DILocation(line: 28, column: 23, scope: !63)
!70 = !DILocation(line: 28, column: 27, scope: !63)
!71 = !DILocation(line: 28, column: 5, scope: !63)
!72 = !DILocation(line: 29, column: 15, scope: !63)
!73 = !DILocation(line: 29, column: 5, scope: !63)
!74 = !DILocation(line: 30, column: 5, scope: !63)
