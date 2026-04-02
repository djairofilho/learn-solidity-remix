// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title Contador
 * @dev O contrato mais simples possível
 * Ensina: variável de estado + funções básicas
 *
 * Como testar no Remix:
 * 1. Deploy no ambiente Remix VM.
 * 2. Chame numero() e confirme que começa em 0.
 * 3. Chame incrementar() duas vezes e veja numero() ir para 2.
 * 4. Chame decrementar() e veja numero() voltar para 1.
 * 5. Chame resetar() e confirme numero() em 0.
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
