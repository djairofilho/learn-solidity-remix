// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title CaraOuCoroa
 * @dev Jogo simples de sorte (não é verdadeiramente aleatório)
 * Ensina: keccak256 + hash + limitações da blockchain
 * 
 * ⚠️ IMPORTANTE: Isso NÃO é aleatoriedade verdadeira!
 * A blockchain é determinística, então qualquer um pode calcular o resultado
 * Use oráculos (VRF, Chainlink) para randomness real
 */
contract CaraOuCoroa {
    
    /**
     * @dev Evento emitido quando alguém joga
     */
    event Jogo(address indexed jogador, bool resultado, uint256 timestamp);
    
    /**
     * @dev Simula um jogo de cara ou coroa
     * @return true = cara, false = coroa
     * 
     * Resultado é baseado em:
     * - block.timestamp (hora do bloco)
     * - msg.sender (seu endereço)
     * Qualquer um pode calcular o resultado antes de jogar!
     */
    function jogar() public returns (bool) {
        // Hash do timestamp + seu endereço
        bytes32 hash = keccak256(abi.encodePacked(block.timestamp, msg.sender));
        
        // Converte para número e tira o resto da divisão por 2
        // Resultado: 0 ou 1
        bool resultado = uint256(hash) % 2 == 0;
        
        emit Jogo(msg.sender, resultado, block.timestamp);
        
        return resultado;
    }
    
    /**
     * @dev Versão com número específico
     * @param numero Um número qualquer (seed)
     * @return true ou false
     */
    function jogarComNumero(uint256 numero) public returns (bool) {
        bytes32 hash = keccak256(abi.encodePacked(numero, msg.sender, block.timestamp));
        bool resultado = uint256(hash) % 2 == 0;
        
        emit Jogo(msg.sender, resultado, block.timestamp);
        
        return resultado;
    }
    
    /**
     * @dev Sorteia um número entre 1 e max
     * @param max O número máximo (inclusive)
     * @return Número sorteado
     */
    function sortearAte(uint256 max) public view returns (uint256) {
        require(max > 0, "Max deve ser maior que 0");
        
        bytes32 hash = keccak256(abi.encodePacked(block.timestamp, msg.sender));
        return (uint256(hash) % max) + 1;
    }
}
