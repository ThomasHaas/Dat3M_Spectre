; ModuleID = '/Users/thomashaas/IdeaProjects/Dat3M/benchmarks/c/spectre/pht/victim_v12.c'
source_filename = "/Users/thomashaas/IdeaProjects/Dat3M/benchmarks/c/spectre/pht/victim_v12.c"
target datalayout = "e-m:o-i64:64-i128:128-n32:64-S128"
target triple = "arm64-apple-macosx13.0.0"

@A = dso_local global [16 x i8] zeroinitializer, align 1, !dbg !0
@B = dso_local global [16 x i8] zeroinitializer, align 1, !dbg !6
@secret = dso_local global i8 42, align 1, !dbg !15
@temp = dso_local global i8 0, align 1, !dbg !17

; Function Attrs: noinline nounwind ssp uwtable
define dso_local void @victim_v12(i32 %0, i32 %1) #0 !dbg !29 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  store i32 %0, i32* %3, align 4
  call void @llvm.dbg.declare(metadata i32* %3, metadata !33, metadata !DIExpression()), !dbg !34
  store i32 %1, i32* %4, align 4
  call void @llvm.dbg.declare(metadata i32* %4, metadata !35, metadata !DIExpression()), !dbg !36
  %6 = load i32, i32* %3, align 4, !dbg !37
  %7 = load i32, i32* %4, align 4, !dbg !39
  %8 = add nsw i32 %6, %7, !dbg !40
  %9 = icmp slt i32 %8, 16, !dbg !41
  br i1 %9, label %10, label %30, !dbg !42

10:                                               ; preds = %2
  call void @llvm.dbg.declare(metadata i32* %5, metadata !43, metadata !DIExpression()), !dbg !45
  %11 = load i32, i32* %3, align 4, !dbg !46
  %12 = load i32, i32* %4, align 4, !dbg !47
  %13 = add nsw i32 %11, %12, !dbg !48
  %14 = sext i32 %13 to i64, !dbg !49
  %15 = getelementptr inbounds [16 x i8], [16 x i8]* @A, i64 0, i64 %14, !dbg !49
  %16 = load i8, i8* %15, align 1, !dbg !49
  %17 = zext i8 %16 to i32, !dbg !49
  store i32 %17, i32* %5, align 4, !dbg !45
  %18 = load i32, i32* %5, align 4, !dbg !50
  %19 = sext i32 %18 to i64, !dbg !51
  %20 = getelementptr inbounds [16 x i8], [16 x i8]* @B, i64 0, i64 %19, !dbg !51
  %21 = load i8, i8* %20, align 1, !dbg !51
  %22 = zext i8 %21 to i32, !dbg !51
  %23 = load volatile i8, i8* @temp, align 1, !dbg !52
  %24 = zext i8 %23 to i32, !dbg !52
  %25 = and i32 %24, %22, !dbg !52
  %26 = trunc i32 %25 to i8, !dbg !52
  store volatile i8 %26, i8* @temp, align 1, !dbg !52
  %27 = load i32, i32* %5, align 4, !dbg !53
  %28 = icmp ne i32 %27, 42, !dbg !54
  %29 = zext i1 %28 to i32, !dbg !54
  call void @__VERIFIER_assert(i32 %29), !dbg !55
  br label %30, !dbg !56

30:                                               ; preds = %10, %2
  ret void, !dbg !57
}

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare void @__VERIFIER_assert(i32) #2

; Function Attrs: noinline nounwind ssp uwtable
define dso_local i32 @main() #0 !dbg !58 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  store i32 0, i32* %1, align 4
  call void @llvm.dbg.declare(metadata i32* %2, metadata !61, metadata !DIExpression()), !dbg !62
  %4 = call i32 @__VERIFIER_nondet_int(), !dbg !63
  store i32 %4, i32* %2, align 4, !dbg !62
  call void @llvm.dbg.declare(metadata i32* %3, metadata !64, metadata !DIExpression()), !dbg !65
  %5 = call i32 @__VERIFIER_nondet_int(), !dbg !66
  store i32 %5, i32* %3, align 4, !dbg !65
  %6 = load i32, i32* %2, align 4, !dbg !67
  %7 = load i32, i32* %3, align 4, !dbg !68
  %8 = add nsw i32 %6, %7, !dbg !69
  %9 = icmp sge i32 %8, 0, !dbg !70
  %10 = zext i1 %9 to i32, !dbg !70
  call void @__VERIFIER_assume(i32 %10), !dbg !71
  %11 = load i32, i32* %2, align 4, !dbg !72
  %12 = load i32, i32* %3, align 4, !dbg !73
  call void @victim_v12(i32 %11, i32 %12), !dbg !74
  ret i32 0, !dbg !75
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
!3 = !DIFile(filename: "/Users/thomashaas/IdeaProjects/Dat3M/benchmarks/c/spectre/pht/victim_v12.c", directory: "/Users/thomashaas/IdeaProjects/Dat3M")
!4 = !{}
!5 = !{!0, !6, !15, !17}
!6 = !DIGlobalVariableExpression(var: !7, expr: !DIExpression())
!7 = distinct !DIGlobalVariable(name: "B", scope: !2, file: !8, line: 8, type: !9, isLocal: false, isDefinition: true)
!8 = !DIFile(filename: "benchmarks/c/spectre/pht/victim_v12.c", directory: "/Users/thomashaas/IdeaProjects/Dat3M")
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
!29 = distinct !DISubprogram(name: "victim_v12", scope: !8, file: !8, line: 13, type: !30, scopeLine: 13, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!30 = !DISubroutineType(types: !31)
!31 = !{null, !32, !32}
!32 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!33 = !DILocalVariable(name: "a", arg: 1, scope: !29, file: !8, line: 13, type: !32)
!34 = !DILocation(line: 13, column: 21, scope: !29)
!35 = !DILocalVariable(name: "b", arg: 2, scope: !29, file: !8, line: 13, type: !32)
!36 = !DILocation(line: 13, column: 28, scope: !29)
!37 = !DILocation(line: 14, column: 10, scope: !38)
!38 = distinct !DILexicalBlock(scope: !29, file: !8, line: 14, column: 9)
!39 = !DILocation(line: 14, column: 14, scope: !38)
!40 = !DILocation(line: 14, column: 12, scope: !38)
!41 = !DILocation(line: 14, column: 17, scope: !38)
!42 = !DILocation(line: 14, column: 9, scope: !29)
!43 = !DILocalVariable(name: "var", scope: !44, file: !8, line: 15, type: !32)
!44 = distinct !DILexicalBlock(scope: !38, file: !8, line: 14, column: 25)
!45 = !DILocation(line: 15, column: 13, scope: !44)
!46 = !DILocation(line: 15, column: 21, scope: !44)
!47 = !DILocation(line: 15, column: 25, scope: !44)
!48 = !DILocation(line: 15, column: 23, scope: !44)
!49 = !DILocation(line: 15, column: 19, scope: !44)
!50 = !DILocation(line: 16, column: 19, scope: !44)
!51 = !DILocation(line: 16, column: 17, scope: !44)
!52 = !DILocation(line: 16, column: 14, scope: !44)
!53 = !DILocation(line: 17, column: 27, scope: !44)
!54 = !DILocation(line: 17, column: 31, scope: !44)
!55 = !DILocation(line: 17, column: 9, scope: !44)
!56 = !DILocation(line: 18, column: 5, scope: !44)
!57 = !DILocation(line: 19, column: 1, scope: !29)
!58 = distinct !DISubprogram(name: "main", scope: !8, file: !8, line: 21, type: !59, scopeLine: 22, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!59 = !DISubroutineType(types: !60)
!60 = !{!32}
!61 = !DILocalVariable(name: "a", scope: !58, file: !8, line: 23, type: !32)
!62 = !DILocation(line: 23, column: 9, scope: !58)
!63 = !DILocation(line: 23, column: 13, scope: !58)
!64 = !DILocalVariable(name: "b", scope: !58, file: !8, line: 24, type: !32)
!65 = !DILocation(line: 24, column: 9, scope: !58)
!66 = !DILocation(line: 24, column: 13, scope: !58)
!67 = !DILocation(line: 25, column: 24, scope: !58)
!68 = !DILocation(line: 25, column: 28, scope: !58)
!69 = !DILocation(line: 25, column: 26, scope: !58)
!70 = !DILocation(line: 25, column: 31, scope: !58)
!71 = !DILocation(line: 25, column: 5, scope: !58)
!72 = !DILocation(line: 26, column: 16, scope: !58)
!73 = !DILocation(line: 26, column: 19, scope: !58)
!74 = !DILocation(line: 26, column: 5, scope: !58)
!75 = !DILocation(line: 27, column: 5, scope: !58)
