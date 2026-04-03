# Guia Prático do Remix para Aula

Este guia resolve as dúvidas mais comuns de quem está começando no Remix.

## Configuração mínima para começar

1. Abra https://remix.ethereum.org
2. No painel esquerdo, use o File Explorer para criar ou abrir um `.sol`
3. No plugin Solidity Compiler:
   - Compiler: use versão compatível com `pragma solidity ^0.8.0`
   - Ative Auto compile se quiser feedback imediato
4. No plugin Deploy & Run Transactions:
   - Environment: `Remix VM (Cancun)` para aula local
   - Account: escolha uma conta de teste com saldo fictício

## Fluxo padrão de teste

1. Compile o contrato
2. Clique em Deploy
3. Execute funções `view` para leitura de estado
4. Execute funções que alteram estado e confirme o novo valor
5. Troque de conta quando quiser simular usuários diferentes

## Como enviar ETH em funções payable

1. No Deploy & Run, ajuste o campo `Value`
2. Escolha unidade (wei/gwei/ether)
3. Chame a função `payable`

Exemplo:
- Para enviar 1 ether, coloque `1` e selecione `ether`
- Para enviar 0.1 ether, coloque `0.1` e selecione `ether`

## Como testar com contas diferentes

1. Conta A faz deploy
2. Conta B chama uma função de usuário comum
3. Conta C tenta uma função restrita para validar `require`

Esse padrão ajuda a ensinar `msg.sender` e controle de acesso.

## Como ler eventos

Depois de executar uma transação:
1. Abra os detalhes da transação no terminal do Remix
2. Veja os logs emitidos por `emit`
3. Confirme campos `indexed` para filtros

## Erros comuns no Remix

- Erro de compilador: versão do compiler não compatível com `pragma`
- Revert sem entender: abra os detalhes da transação e leia a mensagem do `require`
- Função não aparece no painel: contrato não compilou ou contrato errado selecionado
- Saldo insuficiente: falta ETH de teste para enviar em funções payable

## Checklist rápido para professor

- Contrato compilou sem warnings críticos
- Deploy foi feito no ambiente certo
- Pelo menos 2 contas participaram do teste
- Um caminho de sucesso e um caminho de falha foram demonstrados
- Eventos principais foram mostrados
