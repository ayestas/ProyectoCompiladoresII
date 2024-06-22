## Commit - Avance 1 Final
1. Correr comandos de build:
   - mkdir build
   - cd build
   - cmake ../
   - make

2. Correr los ejemplos dentro 'minilpp_tests' y crear el archivo para codigo generado de ensamblador (ejemplo):
   - ./Lpp ../minilpp_tests/HolaMundo.lpp ../HolaMundo.asm

3. Notas:
   - Codigo Generado de ensamblador no se pudo completar, pero los argumentos del CLI toma en cuenta el llamado/creacion de un .asm.
   - AST no se completo, solo se encuentra parcialmente en la gramática.
