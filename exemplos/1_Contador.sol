// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title Contador
 * @dev O contrato mais simples possível
 * Ensina: variável de estado + funções básicas
 */
contract Contador {
    
    // 📊 Variável de estado (fica armazenada na blockchain)
    uint256 public numero;
    
    /**
     * @dev Incrementa o número em 1
     * Modifica estado (público)
     */
    function incrementar() public {
        numero += 1;
    }
    
    /**
     * @dev Decrementa o número em 1
     * Modifica estado (público)
     */
    function decrementar() public {
        numero -= 1;
    }
    
    /**
     * @dev Reseta o número pra 0
     */
    function resetar() public {
        numero = 0;
    }
}
