// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title Faucet
 * @dev Distribuidor de tokens (ou ETH) com limite de tempo
 * Ensina: block.timestamp + rate limiting + lógica real
 * 
 * Um faucet é tipo um "torneira" — você pode sacar, mas tem que esperar
 */
contract Faucet {
    
    // 💧 Quantidade que pode sacar por vez
    uint256 public amountPermitido = 100; // 100 tokens ou wei
    
    // ⏰ Mapeia endereço => último timestamp de saque
    mapping(address => uint256) public ultimoSaque;
    
    // 🕐 Intervalo mínimo entre saques (em segundos)
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
     * @dev Saques quanto tempo falta pra poder sacar novamente
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
