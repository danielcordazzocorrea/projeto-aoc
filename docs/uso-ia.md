# Uso de IA

**Ferramenta:** Codex (OpenAI), usado para revisar o enunciado, organizar a entrega, melhorar a leitura de entrada e preparar a documentação.

**Outras ferramentas de IA ou fontes de código reutilizado:** nenhuma informada pelo autor.

**Sugestão aproveitada:** ler a escolha com a syscall 8 como string e aceitar apenas um único dígito de `0` a `3`. Isso evita que uma entrada textual interrompa o programa na syscall de leitura de inteiro. O código mantém a validação de energia no procedimento de ataque.

**Verificação realizada:** execução no MARS 4.5 de três sequências registradas em `docs/testes.md`. Na sequência `abc, 12, 4, 2, 1, 3, 0`, o programa rejeitou as três entradas inválidas e o ataque posterior causou 10 de dano, como previsto pelo estado de defesa. Também foram verificadas uma vitória e a tentativa de atacar sem energia.

**Responsabilidade do autor:** Daniel deve revisar o código e repetir os testes no ambiente usado para a apresentação. Se usar outras ferramentas, fontes ou recursos mais adiante, deve registrá-los aqui. Também deve compreender os procedimentos para a prova individual.
