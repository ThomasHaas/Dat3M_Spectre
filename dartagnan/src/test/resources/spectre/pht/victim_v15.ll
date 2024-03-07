; ModuleID = '/Users/thomashaas/IdeaProjects/Dat3M/benchmarks/c/spectre/pht/victim_v15.c'
source_filename = "/Users/thomashaas/IdeaProjects/Dat3M/benchmarks/c/spectre/pht/victim_v15.c"
target datalayout = "e-m:o-i64:64-i128:128-n32:64-S128"
target triple = "arm64-apple-macosx13.0.0"

@A = dso_local global [16 x i8] zeroinitializer, align 1, !dbg !0
@B = dso_local global [16 x i8] zeroinitializer, align 1, !dbg !6
@secret = dso_local global i8 42, align 1, !dbg !15
@temp = dso_local global i8 0, align 1, !dbg !17

; Function Attrs: noinline nounwind ssp uwtable
define dso_local void @victim_v15(i32* %0) #0 !dbg !29 {
  %2 = alloca i32*, align 8
  %3 = alloca i32, align 4
  store i32* %0, i32** %2, align 8
  call void @llvm.dbg.declare(metadata i32** %2, metadata !34, metadata !DIExpression()), !dbg !35
  %4 = load i32*, i32** %2, align 8, !dbg !36
  %5 = load i32, i32* %4, align 4, !dbg !38
  %6 = icmp slt i32 %5, 16, !dbg !39
  br i1 %6, label %7, label %26, !dbg !40

7:                                                ; preds = %1
  call void @llvm.dbg.declare(metadata i32* %3, metadata !41, metadata !DIExpression()), !dbg !43
  %8 = load i32*, i32** %2, align 8, !dbg !44
  %9 = load i32, i32* %8, align 4, !dbg !45
  %10 = sext i32 %9 to i64, !dbg !46
  %11 = getelementptr inbounds [16 x i8], [16 x i8]* @A, i64 0, i64 %10, !dbg !46
  %12 = load i8, i8* %11, align 1, !dbg !46
  %13 = zext i8 %12 to i32, !dbg !46
  store i32 %13, i32* %3, align 4, !dbg !43
  %14 = load i32, i32* %3, align 4, !dbg !47
  %15 = sext i32 %14 to i64, !dbg !48
  %16 = getelementptr inbounds [16 x i8], [16 x i8]* @B, i64 0, i64 %15, !dbg !48
  %17 = load i8, i8* %16, align 1, !dbg !48
  %18 = zext i8 %17 to i32, !dbg !48
  %19 = load volatile i8, i8* @temp, align 1, !dbg !49
  %20 = zext i8 %19 to i32, !dbg !49
  %21 = and i32 %20, %18, !dbg !49
  %22 = trunc i32 %21 to i8, !dbg !49
  store volatile i8 %22, i8* @temp, align 1, !dbg !49
  %23 = load i32, i32* %3, align 4, !dbg !50
  %24 = icmp ne i32 %23, 42, !dbg !51
  %25 = zext i1 %24 to i32, !dbg !51
  call void @__VERIFIER_assert(i32 %25), !dbg !52
  br label %26, !dbg !53

26:                                               ; preds = %7, %1
  ret void, !dbg !54
}

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare void @__VERIFIER_assert(i32) #2

; Function Attrs: noinline nounwind ssp uwtable
define dso_local i32 @main() #0 !dbg !55 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  store i32 0, i32* %1, align 4
  call void @llvm.dbg.declare(metadata i32* %2, metadata !58, metadata !DIExpression()), !dbg !59
  %3 = call i32 @__VERIFIER_nondet_int(), !dbg !60
  store i32 %3, i32* %2, align 4, !dbg !59
  %4 = load i32, i32* %2, align 4, !dbg !61
  %5 = icmp sge i32 %4, 0, !dbg !62
  %6 = zext i1 %5 to i32, !dbg !62
  call void @__VERIFIER_assume(i32 %6), !dbg !63
  call void @victim_v15(i32* %2), !dbg !64
  ret i32 0, !dbg !65
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
!3 = !DIFile(filename: "/Users/thomashaas/IdeaProjects/Dat3M/benchmarks/c/spectre/pht/victim_v15.c", directory: "/Users/thomashaas/IdeaProjects/Dat3M")
!4 = !{}
!5 = !{!0, !6, !15, !17}
!6 = !DIGlobalVariableExpression(var: !7, expr: !DIExpression())
!7 = distinct !DIGlobalVariable(name: "B", scope: !2, file: !8, line: 8, type: !9, isLocal: false, isDefinition: true)
!8 = !DIFile(filename: "benchmarks/c/spectre/pht/victim_v15.c", directory: "/Users/thomashaas/IdeaProjects/Dat3M")
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
!29 = distinct !DISubprogram(name: "victim_v15", scope: !8, file: !8, line: 13, type: !30, scopeLine: 13, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!30 = !DISubroutineType(types: !31)
!31 = !{null, !32}
!32 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !33, size: 64)
!33 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!34 = !DILocalVariable(name: "idx", arg: 1, scope: !29, file: !8, line: 13, type: !32)
!35 = !DILocation(line: 13, column: 22, scope: !29)
!36 = !DILocation(line: 14, column: 10, scope: !37)
!37 = distinct !DILexicalBlock(scope: !29, file: !8, line: 14, column: 9)
!38 = !DILocation(line: 14, column: 9, scope: !37)
!39 = !DILocation(line: 14, column: 14, scope: !37)
!40 = !DILocation(line: 14, column: 9, scope: !29)
!41 = !DILocalVariable(name: "var", scope: !42, file: !8, line: 15, type: !33)
!42 = distinct !DILexicalBlock(scope: !37, file: !8, line: 14, column: 22)
!43 = !DILocation(line: 15, column: 13, scope: !42)
!44 = !DILocation(line: 15, column: 22, scope: !42)
!45 = !DILocation(line: 15, column: 21, scope: !42)
!46 = !DILocation(line: 15, column: 19, scope: !42)
!47 = !DILocation(line: 16, column: 19, scope: !42)
!48 = !DILocation(line: 16, column: 17, scope: !42)
!49 = !DILocation(line: 16, column: 14, scope: !42)
!50 = !DILocation(line: 17, column: 27, scope: !42)
!51 = !DILocation(line: 17, column: 31, scope: !42)
!52 = !DILocation(line: 17, column: 9, scope: !42)
!53 = !DILocation(line: 18, column: 5, scope: !42)
!54 = !DILocation(line: 19, column: 1, scope: !29)
!55 = distinct !DISubprogram(name: "main", scope: !8, file: !8, line: 21, type: !56, scopeLine: 22, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!56 = !DISubroutineType(types: !57)
!57 = !{!33}
!58 = !DILocalVariable(name: "idx", scope: !55, file: !8, line: 23, type: !33)
!59 = !DILocation(line: 23, column: 9, scope: !55)
!60 = !DILocation(line: 23, column: 15, scope: !55)
!61 = !DILocation(line: 24, column: 23, scope: !55)
!62 = !DILocation(line: 24, column: 27, scope: !55)
!63 = !DILocation(line: 24, column: 5, scope: !55)
!64 = !DILocation(line: 25, column: 5, scope: !55)
!65 = !DILocation(line: 26, column: 5, scope: !55)
