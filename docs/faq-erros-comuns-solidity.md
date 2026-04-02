# FAQ de Duvidas Frequentes em Solidity

## 1) Qual a diferenca entre wei, gwei e ether?

- `1 ether = 10^18 wei`
- `1 gwei = 10^9 wei`
- `wei` e a menor unidade.

Em contratos, quase tudo e armazenado em wei.

## 2) Por que minha transacao reverteu?

Motivos comuns:
- `require` falhou (regra de negocio)
- saldo insuficiente
- usuario sem permissao (`onlyOwner`)
- valor enviado incorreto em funcao `payable`

Dica: sempre leia a mensagem do `require` no output da transacao.

## 3) Diferenca entre `view`, `pure` e funcao normal

- `view`: le estado, nao altera
- `pure`: nao le e nao altera estado
- normal: altera estado e gera transacao

## 4) `memory`, `storage` e `calldata` confundem. Como pensar?

- `storage`: dados persistentes da blockchain
- `memory`: dados temporarios durante a execucao
- `calldata`: dados de entrada de funcoes externas (somente leitura)

Regra pratica:
- parametro `string` em funcao `public`: use `memory`
- parametro em funcao `external`: prefira `calldata` quando possivel

## 5) O que e gas na pratica?

Gas e o custo computacional da operacao.

Custos altos costumam vir de:
- loops longos
- muitas escritas em storage
- estruturas grandes retornadas on-chain

## 6) Posso confiar em `block.timestamp`?

Use para janelas de tempo aproximadas (cooldown, expiracao simples).
Nao use como unica fonte de aleatoriedade ou para regras extremamente sensiveis.

## 7) Por que aleatoriedade em blockchain e dificil?

Porque a blockchain e deterministica: todos os nos precisam chegar no mesmo resultado.
Para sorteio serio, use oraculo de random (ex.: VRF).

## 8) `transfer` vs `call` para enviar ETH

Hoje, `call` e preferido por compatibilidade e flexibilidade.

Padrao recomendado:

```solidity
(bool ok, ) = payable(destino).call{value: valor}("");
require(ok, "Falha no envio");
```

## 9) O que nao esquecer antes de deploy real

- validar controle de acesso
- emitir eventos nas acoes criticas
- revisar mensagens de erro
- testar cenarios de falha
- limitar superficies de ataque (funcoes externas desnecessarias)

## 10) Erros de sintaxe muito comuns de iniciantes

- nome de funcao com espaco (invalido)
- identificadores com caracteres nao suportados pelo compilador/linter
- esquecer ponto e virgula
- esquecer `emit` ao disparar evento
