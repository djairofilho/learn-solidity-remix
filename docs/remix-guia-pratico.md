# Guia Pratico do Remix para Aula

Este guia resolve as duvidas mais comuns de quem esta comecando no Remix.

## 1) Configuracao minima para comecar

1. Abra https://remix.ethereum.org
2. No painel esquerdo, use o File Explorer para criar ou abrir um `.sol`
3. No plugin Solidity Compiler:
   - Compiler: use versao compativel com `pragma solidity ^0.8.0`
   - Ative Auto compile se quiser feedback imediato
4. No plugin Deploy & Run Transactions:
   - Environment: `Remix VM (Cancun)` para aula local
   - Account: escolha uma conta de teste com saldo ficticio

## 2) Fluxo padrao de teste

1. Compile o contrato
2. Clique em Deploy
3. Execute funcoes `view` para leitura de estado
4. Execute funcoes que alteram estado e confirme o novo valor
5. Troque de conta quando quiser simular usuarios diferentes

## 3) Como enviar ETH em funcoes payable

1. No Deploy & Run, ajuste o campo `Value`
2. Escolha unidade (wei/gwei/ether)
3. Chame a funcao `payable`

Exemplo:
- Para enviar 1 ether, coloque `1` e selecione `ether`
- Para enviar 0.1 ether, coloque `0.1` e selecione `ether`

## 4) Como testar com contas diferentes

1. Conta A faz deploy
2. Conta B chama uma funcao de usuario comum
3. Conta C tenta uma funcao restrita para validar `require`

Esse padrao ajuda a ensinar `msg.sender` e controle de acesso.

## 5) Como ler eventos

Depois de executar uma transacao:
1. Abra os detalhes da transacao no terminal do Remix
2. Veja os logs emitidos por `emit`
3. Confirme campos `indexed` para filtros

## 6) Erros comuns no Remix

- Erro de compilador: versao do compiler nao compativel com `pragma`
- Revert sem entender: abra os detalhes da transacao e leia a mensagem do `require`
- Funcao nao aparece no painel: contrato nao compilou ou contrato errado selecionado
- Saldo insuficiente: falta ETH de teste para enviar em funcoes payable

## 7) Checklist rapido para professor

- Contrato compilou sem warnings criticos
- Deploy foi feito no ambiente certo
- Pelo menos 2 contas participaram do teste
- Um caminho de sucesso e um caminho de falha foram demonstrados
- Eventos principais foram mostrados
