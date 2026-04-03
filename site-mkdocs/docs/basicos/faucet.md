# Faucet

Distribuidor de tokens (ou ETH) com limite de tempo.

**Conceitos ensinados:**
- `block.timestamp` (tempo do blockchain)
- Controle de taxa (rate limiting)
- Eventos
- Lógica real de DeFi

## Código

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title Faucet
 * @dev Distribuidor de tokens (ou ETH) com limite de tempo
 * Ensina: block.timestamp + rate limiting + lógica real
 * 
 * Um faucet é tipo um "torneira" — você pode sacar, mas tem que esperar
 *
 * Como testar no Remix:
 * 1. Deploy no Remix VM.
 * 2. Chame podeSacar() e confirme true no inicio.
 * 3. Chame sacar() e verifique tempoRestante() maior que 0.
 * 4. Tente sacar() de novo imediatamente e veja a transação reverter.
 * 5. Aguarde o tempo e chame sacar() novamente.
 */
contract Faucet {
    
    // Quantidade que pode sacar por vez
    uint256 public amountPermitido = 100; // 100 tokens ou wei
    
    // Mapeia endereço => último timestamp de saque
    mapping(address => uint256) public ultimoSaque;
    
    // Intervalo mínimo entre saques (em segundos)
    uint256 public intervaloMinimo = 1 minutes; // 60 segundos
    
    /**
     * @dev Event - é "emitido" quando algo importante acontece
     * Os clientes (front-end) podem escutar esses eventos
     */
    event Saque(address indexed usuario, uint256 valor, uint256 timestamp);
    
    /**
     * @dev Saca a quantidade permitida (se passou o intervalo)
     * 
     * Requer: Ter esperado o intervalo desde o último saque
     */
    function sacar() public {
        // Verifica se pode sacar
        require(
            block.timestamp > ultimoSaque[msg.sender] + intervaloMinimo,
            "Espere mais um pouco antes de sacar novamente"
        );
        
        // Atualiza o timestamp
        ultimoSaque[msg.sender] = block.timestamp;
        
        // Aqui você integraria com uma transferência real de token
        // Por enquanto, apenas loga o evento
        emit Saque(msg.sender, amountPermitido, block.timestamp);
    }
    
    /**
     * @dev Diz quanto tempo falta pra poder sacar novamente
     * @return Segundos até poder sacar (0 se pode sacar agora)
     */
    function tempoRestante() public view returns (uint256) {
        uint256 proximoSaque = ultimoSaque[msg.sender] + intervaloMinimo;
        
        if (block.timestamp >= proximoSaque) {
            return 0; // Pode sacar agora
        }
        
        return proximoSaque - block.timestamp;
    }
    
    /**
     * @dev Verifica se pode sacar AGORA
     * @return true se pode sacar, false se precisa esperar
     */
    function podeSacar() public view returns (bool) {
        return block.timestamp > ultimoSaque[msg.sender] + intervaloMinimo;
    }
}
```

## Como Testar no Remix

1. **Deploy** no Remix VM
2. Chame `podeSacar()` → deve retornar **true**
3. Chame `sacar()` → evento Saque é emitido
4. Chame `tempoRestante()` → deve mostrar valor > 0
5. Tente `sacar()` novamente → deve **reverter**
6. Aguarde ~1 minuto (ou ajuste `intervaloMinimo` para testar)
7. Chame `sacar()` novamente → deve funcionar

## Use Case

Aplicação prática de Web3 • Faucets de tokens • Rate limiting em DeFi
