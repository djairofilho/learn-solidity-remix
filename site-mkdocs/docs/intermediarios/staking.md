# Staking

Recompensar usuários que "prenderem" fundos por tempo.

**Conceitos ensinados:**
- Lock period
- Rewards calculation
- Claim mechanism
- Time-based logic

## Código

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title StakingBasico
 * @dev Recompensar usuários que "prenderem" fundos por tempo
 * Ensina: lock period, rewards calculation, claim mechanism, time-based logic
 *
 * Como testar no Remix:
 * 1. Deploy no Remix VM e envie ETH para o contrato ter saldo de pagamento.
 * 2. Chame fazerStaking() enviando Value (ex: 1 ether).
 * 3. Aguarde alguns segundos e chame verRecompensaPending().
 * 4. Chame cobrarRecompense() para simular recebimento de recompensa.
 * 5. Chame retirarStaking(_valor) para retirar parte do stake.
 */
contract StakingBasico {
    
    // Informações de recompensa
    uint256 public recompensaPorSegundo = 1e16; // 0.01 token por segundo
    
    // Registro de stakeholders
    struct Staker {
        uint256 amountStaked;
        uint256 timestampLastClaim;
    }
    
    mapping(address => Staker) public stakers;
    uint256 public totalStaked;
    
    event DepositoStaking(address indexed usuario, uint256 valor);
    event RetiraStaking(address indexed usuario, uint256 valor);
    event RecompensaCobrada(address indexed usuario, uint256 recompensa);
    
    /**
     * @dev Faz depósito pra começar staking
     * Apenas recebendo ETH, começa a acumular recompensas
     */
    function fazerStaking() public payable {
        require(msg.value > 0, "Envie ETH");
        
        // Se já estava fazendo staking, calcula recompensa antes
        if (stakers[msg.sender].amountStaked > 0) {
            _calcularRecompensa(msg.sender);
        }
        
        stakers[msg.sender].amountStaked += msg.value;
        stakers[msg.sender].timestampLastClaim = block.timestamp;
        totalStaked += msg.value;
        
        emit DepositoStaking(msg.sender, msg.value);
    }
    
    /**
     * @dev Calcula recompensa acumulada desde o último claim
     */
    function _calcularRecompensa(address _usuario) internal {
        if (stakers[_usuario].amountStaked == 0) return;
        
        uint256 tempoDecorrido = block.timestamp - stakers[_usuario].timestampLastClaim;
        uint256 recompense = (stakers[_usuario].amountStaked / 1 ether) * recompensaPorSegundo * tempoDecorrido;
        
        // Aqui em um contrato real, transferíamos tokens como recompensa
        // Por enquanto, apenas atualiza o timestamp
        stakers[_usuario].timestampLastClaim = block.timestamp;
    }
    
    /**
     * @dev Vê quanto de recompensa você ganhou desde última vez
     */
    function verRecompensaPending() public view returns (uint256) {
        if (stakers[msg.sender].amountStaked == 0) return 0;
        
        uint256 tempoDecorrido = block.timestamp - stakers[msg.sender].timestampLastClaim;
        return (stakers[msg.sender].amountStaked / 1 ether) * recompensaPorSegundo * tempoDecorrido;
    }
    
    /**
     * @dev Cobra a recompensa acumulada
     */
    function cobrarRecompense() public {
        uint256 recompensa = verRecompensaPending();
        require(recompensa > 0, "Sem recompensa");
        
        stakers[msg.sender].timestampLastClaim = block.timestamp;
        
        // Aqui transferíamos tokens: token.transfer(msg.sender, recompensa);
        // Por enquanto, apenas envia ETH como simulação
        payable(msg.sender).transfer(recompensa / 1e18); // Conversão simplificada
        
        emit RecompensaCobrada(msg.sender, recompensa);
    }
    
    /**
     * @dev Retira o staking (sem lock period neste exemplo)
     */
    function retirarStaking(uint256 _valor) public {
        require(_valor > 0, "Valor invalido");
        require(stakers[msg.sender].amountStaked >= _valor, "Saldo insuficiente");
        
        // Calcula recompensa antes de retirar
        _calcularRecompensa(msg.sender);
        
        stakers[msg.sender].amountStaked -= _valor;
        totalStaked -= _valor;
        
        payable(msg.sender).transfer(_valor);
        
        emit RetiraStaking(msg.sender, _valor);
    }
    
    /**
     * @dev Vê quanto você tem em staking
     */
    function meuStaking() public view returns (uint256) {
        return stakers[msg.sender].amountStaked;
    }
    
    /**
     * @dev Total em staking na pool
     */
    function verTotalStaked() public view returns (uint256) {
        return totalStaked;
    }
    
    // Para receber ETH
    receive() external payable {
        fazerStaking();
    }
}
```

## Como Testar no Remix

1. **Deploy** no Remix VM
2. Envie **10 ETH** para o contrato (via Value)
3. Troque para **Conta 2**, defina **Value = 1 ETH** e chame `fazerStaking()`
4. Chame `meuStaking()` → deve mostrar **1 ETH**
5. Aguarde ~10 segundos
6. Chame `verRecompensaPending()` → mostra recompensa acumulada
7. Chame `cobrarRecompense()` → recebe recompensa
8. Chame `retirarStaking(500000000000000000)` → retira 0.5 ETH

## Use Case

Yield farming • Staking pools • Programas de incentivo
