mosmlc -c Mips.sml
mosmlc -c RegAlloc.sig RegAlloc.sml
mosmlc -c S100.sml
mosmlyac -v Parser.grm
mosmlc -c Parser.sig Parser.sml
mosmllex Lexer.lex
mosmlc -c Lexer.sml
mosmlc -c Type.sig Type.sml
mosmlc -c Compiler.sig Compiler.sml
mosmlc -o C100.exe C100.sml
