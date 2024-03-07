; ModuleID = '/Users/thomashaas/IdeaProjects/Dat3M/benchmarks/c/spectre/pht/victim_v10.c'
source_filename = "/Users/thomashaas/IdeaProjects/Dat3M/benchmarks/c/spectre/pht/victim_v10.c"
target datalayout = "e-m:o-i64:64-i128:128-n32:64-S128"
target triple = "arm64-apple-macosx13.0.0"

@A = dso_local global [16 x i8] zeroinitializer, align 1, !dbg !0
@B = dso_local global [16 x i8] zeroinitializer, align 1, !dbg !6
@secret = dso_local global i8 42, align 1, !dbg !15
@temp = dso_local global i8 0, align 1, !dbg !17

; Function Attrs: noinline nounwind ssp uwtable
define dso_local void @victim_v10(i32 %0, i32 %1) #0 !dbg !29 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  store i32 %0, i32* %3, align 4
  call void @llvm.dbg.declare(metadata i32* %3, metadata !33, metadata !DIExpression()), !dbg !34
  store i32 %1, i32* %4, align 4
  call void @llvm.dbg.declare(metadata i32* %4, metadata !35, metadata !DIExpression()), !dbg !36
  %6 = load i32, i32* %3, align 4, !dbg !37
  %7 = icmp slt i32 %6, 16, !dbg !39
  br i1 %7, label %8, label %33, !dbg !40

8:                                                ; preds = %2
  call void @llvm.dbg.declare(metadata i32* %5, metadata !41, metadata !DIExpression()), !dbg !43
  %9 = load i32, i32* %3, align 4, !dbg !44
  %10 = sext i32 %9 to i64, !dbg !45
  %11 = getelementptr inbounds [16 x i8], [16 x i8]* @A, i64 0, i64 %10, !dbg !45
  %12 = load i8, i8* %11, align 1, !dbg !45
  %13 = zext i8 %12 to i32, !dbg !45
  store i32 %13, i32* %5, align 4, !dbg !43
  %14 = load i32, i32* %5, align 4, !dbg !46
  %15 = load i32, i32* %4, align 4, !dbg !48
  %16 = icmp eq i32 %14, %15, !dbg !49
  br i1 %16, label %17, label %24, !dbg !50

17:                                               ; preds = %8
  %18 = load i8, i8* getelementptr inbounds ([16 x i8], [16 x i8]* @B, i64 0, i64 0), align 1, !dbg !51
  %19 = zext i8 %18 to i32, !dbg !51
  %20 = load volatile i8, i8* @temp, align 1, !dbg !53
  %21 = zext i8 %20 to i32, !dbg !53
  %22 = and i32 %21, %19, !dbg !53
  %23 = trunc i32 %22 to i8, !dbg !53
  store volatile i8 %23, i8* @temp, align 1, !dbg !53
  br label %24, !dbg !54

24:                                               ; preds = %17, %8
  %25 = load i32, i32* %5, align 4, !dbg !55
  %26 = icmp ne i32 %25, 42, !dbg !56
  %27 = zext i1 %26 to i32, !dbg !56
  %28 = load i32, i32* %5, align 4, !dbg !57
  %29 = load i32, i32* %4, align 4, !dbg !58
  %30 = icmp ne i32 %28, %29, !dbg !59
  %31 = zext i1 %30 to i32, !dbg !59
  %32 = or i32 %27, %31, !dbg !60
  call void @__VERIFIER_assert(i32 %32), !dbg !61
  br label %33, !dbg !62

33:                                               ; preds = %24, %2
  ret void, !dbg !63
}

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare void @__VERIFIER_assert(i32) #2

; Function Attrs: noinline nounwind ssp uwtable
define dso_local i32 @main() #0 !dbg !64 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  store i32 0, i32* %1, align 4
  call void @llvm.dbg.declare(metadata i32* %2, metadata !67, metadata !DIExpression()), !dbg !68
  %4 = call i32 @__VERIFIER_nondet_int(), !dbg !69
  store i32 %4, i32* %2, align 4, !dbg !68
  call void @llvm.dbg.declare(metadata i32* %3, metadata !70, metadata !DIExpression()), !dbg !71
  %5 = call i32 @__VERIFIER_nondet_int(), !dbg !72
  store i32 %5, i32* %3, align 4, !dbg !71
  %6 = load i32, i32* %2, align 4, !dbg !73
  %7 = icmp sge i32 %6, 0, !dbg !74
  %8 = zext i1 %7 to i32, !dbg !74
  call void @__VERIFIER_assume(i32 %8), !dbg !75
  %9 = load i32, i32* %3, align 4, !dbg !76
  %10 = icmp sge i32 %9, 0, !dbg !77
  %11 = zext i1 %10 to i32, !dbg !77
  call void @__VERIFIER_assume(i32 %11), !dbg !78
  %12 = load i32, i32* %2, align 4, !dbg !79
  %13 = load i32, i32* %3, align 4, !dbg !80
  call void @victim_v10(i32 %12, i32 %13), !dbg !81
  ret i32 0, !dbg !82
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
!3 = !DIFile(filename: "/Users/thomashaas/IdeaProjects/Dat3M/benchmarks/c/spectre/pht/victim_v10.c", directory: "/Users/thomashaas/IdeaProjects/Dat3M")
!4 = !{}
!5 = !{!0, !6, !15, !17}
!6 = !DIGlobalVariableExpression(var: !7, expr: !DIExpression())
!7 = distinct !DIGlobalVariable(name: "B", scope: !2, file: !8, line: 8, type: !9, isLocal: false, isDefinition: true)
!8 = !DIFile(filename: "benchmarks/c/spectre/pht/victim_v10.c", directory: "/Users/thomashaas/IdeaProjects/Dat3M")
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
!29 = distinct !DISubprogram(name: "victim_v10", scope: !8, file: !8, line: 13, type: !30, scopeLine: 13, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!30 = !DISubroutineType(types: !31)
!31 = !{null, !32, !32}
!32 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!33 = !DILocalVariable(name: "idx", arg: 1, scope: !29, file: !8, line: 13, type: !32)
!34 = !DILocation(line: 13, column: 21, scope: !29)
!35 = !DILocalVariable(name: "guess", arg: 2, scope: !29, file: !8, line: 13, type: !32)
!36 = !DILocation(line: 13, column: 30, scope: !29)
!37 = !DILocation(line: 14, column: 9, scope: !38)
!38 = distinct !DILexicalBlock(scope: !29, file: !8, line: 14, column: 9)
!39 = !DILocation(line: 14, column: 13, scope: !38)
!40 = !DILocation(line: 14, column: 9, scope: !29)
!41 = !DILocalVariable(name: "var", scope: !42, file: !8, line: 15, type: !32)
!42 = distinct !DILexicalBlock(scope: !38, file: !8, line: 14, column: 21)
!43 = !DILocation(line: 15, column: 13, scope: !42)
!44 = !DILocation(line: 15, column: 21, scope: !42)
!45 = !DILocation(line: 15, column: 19, scope: !42)
!46 = !DILocation(line: 16, column: 13, scope: !47)
!47 = distinct !DILexicalBlock(scope: !42, file: !8, line: 16, column: 13)
!48 = !DILocation(line: 16, column: 20, scope: !47)
!49 = !DILocation(line: 16, column: 17, scope: !47)
!50 = !DILocation(line: 16, column: 13, scope: !42)
!51 = !DILocation(line: 17, column: 21, scope: !52)
!52 = distinct !DILexicalBlock(scope: !47, file: !8, line: 16, column: 27)
!53 = !DILocation(line: 17, column: 18, scope: !52)
!54 = !DILocation(line: 18, column: 9, scope: !52)
!55 = !DILocation(line: 19, column: 28, scope: !42)
!56 = !DILocation(line: 19, column: 32, scope: !42)
!57 = !DILocation(line: 19, column: 52, scope: !42)
!58 = !DILocation(line: 19, column: 59, scope: !42)
!59 = !DILocation(line: 19, column: 56, scope: !42)
!60 = !DILocation(line: 19, column: 49, scope: !42)
!61 = !DILocation(line: 19, column: 9, scope: !42)
!62 = !DILocation(line: 20, column: 5, scope: !42)
!63 = !DILocation(line: 21, column: 1, scope: !29)
!64 = distinct !DISubprogram(name: "main", scope: !8, file: !8, line: 23, type: !65, scopeLine: 24, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!65 = !DISubroutineType(types: !66)
!66 = !{!32}
!67 = !DILocalVariable(name: "idx", scope: !64, file: !8, line: 25, type: !32)
!68 = !DILocation(line: 25, column: 9, scope: !64)
!69 = !DILocation(line: 25, column: 15, scope: !64)
!70 = !DILocalVariable(name: "guess", scope: !64, file: !8, line: 26, type: !32)
!71 = !DILocation(line: 26, column: 9, scope: !64)
!72 = !DILocation(line: 26, column: 17, scope: !64)
!73 = !DILocation(line: 27, column: 23, scope: !64)
!74 = !DILocation(line: 27, column: 27, scope: !64)
!75 = !DILocation(line: 27, column: 5, scope: !64)
!76 = !DILocation(line: 28, column: 23, scope: !64)
!77 = !DILocation(line: 28, column: 29, scope: !64)
!78 = !DILocation(line: 28, column: 5, scope: !64)
!79 = !DILocation(line: 29, column: 16, scope: !64)
!80 = !DILocation(line: 29, column: 21, scope: !64)
!81 = !DILocation(line: 29, column: 5, scope: !64)
!82 = !DILocation(line: 30, column: 5, scope: !64)
