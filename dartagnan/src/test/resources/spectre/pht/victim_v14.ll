; ModuleID = '/Users/thomashaas/IdeaProjects/Dat3M/benchmarks/c/spectre/pht/victim_v14.c'
source_filename = "/Users/thomashaas/IdeaProjects/Dat3M/benchmarks/c/spectre/pht/victim_v14.c"
target datalayout = "e-m:o-i64:64-i128:128-n32:64-S128"
target triple = "arm64-apple-macosx13.0.0"

@A = dso_local global [16 x i8] zeroinitializer, align 1, !dbg !0
@B = dso_local global [16 x i8] zeroinitializer, align 1, !dbg !6
@secret = dso_local global i8 42, align 1, !dbg !15
@temp = dso_local global i8 0, align 1, !dbg !17

; Function Attrs: noinline nounwind ssp uwtable
define dso_local void @victim_v14(i32 %0) #0 !dbg !29 {
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  store i32 %0, i32* %2, align 4
  call void @llvm.dbg.declare(metadata i32* %2, metadata !33, metadata !DIExpression()), !dbg !34
  %4 = load i32, i32* %2, align 4, !dbg !35
  %5 = icmp slt i32 %4, 16, !dbg !37
  br i1 %5, label %6, label %25, !dbg !38

6:                                                ; preds = %1
  call void @llvm.dbg.declare(metadata i32* %3, metadata !39, metadata !DIExpression()), !dbg !41
  %7 = load i32, i32* %2, align 4, !dbg !42
  %8 = xor i32 %7, 255, !dbg !43
  %9 = sext i32 %8 to i64, !dbg !44
  %10 = getelementptr inbounds [16 x i8], [16 x i8]* @A, i64 0, i64 %9, !dbg !44
  %11 = load i8, i8* %10, align 1, !dbg !44
  %12 = zext i8 %11 to i32, !dbg !44
  store i32 %12, i32* %3, align 4, !dbg !41
  %13 = load i32, i32* %3, align 4, !dbg !45
  %14 = sext i32 %13 to i64, !dbg !46
  %15 = getelementptr inbounds [16 x i8], [16 x i8]* @B, i64 0, i64 %14, !dbg !46
  %16 = load i8, i8* %15, align 1, !dbg !46
  %17 = zext i8 %16 to i32, !dbg !46
  %18 = load volatile i8, i8* @temp, align 1, !dbg !47
  %19 = zext i8 %18 to i32, !dbg !47
  %20 = and i32 %19, %17, !dbg !47
  %21 = trunc i32 %20 to i8, !dbg !47
  store volatile i8 %21, i8* @temp, align 1, !dbg !47
  %22 = load i32, i32* %3, align 4, !dbg !48
  %23 = icmp ne i32 %22, 42, !dbg !49
  %24 = zext i1 %23 to i32, !dbg !49
  call void @__VERIFIER_assert(i32 %24), !dbg !50
  br label %25, !dbg !51

25:                                               ; preds = %6, %1
  ret void, !dbg !52
}

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare void @__VERIFIER_assert(i32) #2

; Function Attrs: noinline nounwind ssp uwtable
define dso_local i32 @main() #0 !dbg !53 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  store i32 0, i32* %1, align 4
  call void @llvm.dbg.declare(metadata i32* %2, metadata !56, metadata !DIExpression()), !dbg !57
  %3 = call i32 @__VERIFIER_nondet_int(), !dbg !58
  store i32 %3, i32* %2, align 4, !dbg !57
  %4 = load i32, i32* %2, align 4, !dbg !59
  %5 = icmp sge i32 %4, 0, !dbg !60
  %6 = zext i1 %5 to i32, !dbg !60
  call void @__VERIFIER_assume(i32 %6), !dbg !61
  %7 = load i32, i32* %2, align 4, !dbg !62
  call void @victim_v14(i32 %7), !dbg !63
  ret i32 0, !dbg !64
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
!3 = !DIFile(filename: "/Users/thomashaas/IdeaProjects/Dat3M/benchmarks/c/spectre/pht/victim_v14.c", directory: "/Users/thomashaas/IdeaProjects/Dat3M")
!4 = !{}
!5 = !{!0, !6, !15, !17}
!6 = !DIGlobalVariableExpression(var: !7, expr: !DIExpression())
!7 = distinct !DIGlobalVariable(name: "B", scope: !2, file: !8, line: 8, type: !9, isLocal: false, isDefinition: true)
!8 = !DIFile(filename: "benchmarks/c/spectre/pht/victim_v14.c", directory: "/Users/thomashaas/IdeaProjects/Dat3M")
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
!29 = distinct !DISubprogram(name: "victim_v14", scope: !8, file: !8, line: 13, type: !30, scopeLine: 13, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!30 = !DISubroutineType(types: !31)
!31 = !{null, !32}
!32 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!33 = !DILocalVariable(name: "idx", arg: 1, scope: !29, file: !8, line: 13, type: !32)
!34 = !DILocation(line: 13, column: 21, scope: !29)
!35 = !DILocation(line: 14, column: 9, scope: !36)
!36 = distinct !DILexicalBlock(scope: !29, file: !8, line: 14, column: 9)
!37 = !DILocation(line: 14, column: 13, scope: !36)
!38 = !DILocation(line: 14, column: 9, scope: !29)
!39 = !DILocalVariable(name: "var", scope: !40, file: !8, line: 15, type: !32)
!40 = distinct !DILexicalBlock(scope: !36, file: !8, line: 14, column: 21)
!41 = !DILocation(line: 15, column: 13, scope: !40)
!42 = !DILocation(line: 15, column: 21, scope: !40)
!43 = !DILocation(line: 15, column: 25, scope: !40)
!44 = !DILocation(line: 15, column: 19, scope: !40)
!45 = !DILocation(line: 16, column: 19, scope: !40)
!46 = !DILocation(line: 16, column: 17, scope: !40)
!47 = !DILocation(line: 16, column: 14, scope: !40)
!48 = !DILocation(line: 18, column: 27, scope: !40)
!49 = !DILocation(line: 18, column: 31, scope: !40)
!50 = !DILocation(line: 18, column: 9, scope: !40)
!51 = !DILocation(line: 19, column: 5, scope: !40)
!52 = !DILocation(line: 20, column: 1, scope: !29)
!53 = distinct !DISubprogram(name: "main", scope: !8, file: !8, line: 22, type: !54, scopeLine: 23, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!54 = !DISubroutineType(types: !55)
!55 = !{!32}
!56 = !DILocalVariable(name: "idx", scope: !53, file: !8, line: 24, type: !32)
!57 = !DILocation(line: 24, column: 9, scope: !53)
!58 = !DILocation(line: 24, column: 15, scope: !53)
!59 = !DILocation(line: 25, column: 23, scope: !53)
!60 = !DILocation(line: 25, column: 27, scope: !53)
!61 = !DILocation(line: 25, column: 5, scope: !53)
!62 = !DILocation(line: 26, column: 16, scope: !53)
!63 = !DILocation(line: 26, column: 5, scope: !53)
!64 = !DILocation(line: 27, column: 5, scope: !53)
