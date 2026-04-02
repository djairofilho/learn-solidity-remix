// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title Whitelist
 * @dev Controle de acesso: apenas endereços pré-aprovados podem fazer algo
 * Ensina: array de endereços, permissões, access control pattern
 *
 * Como testar no Remix:
 * 1. Deploy com a conta 1 (dono).
 * 2. Chame adicionarAprovado(conta2).
 * 3. Troque para conta 2 e chame funcaoRestrita() (deve funcionar).
 * 4. Volte para conta 1 e chame removerAprovado(conta2).
 * 5. Na conta 2, teste funcaoRestrita() novamente (deve reverter).
 */
contract Whitelist {
    
    // 📋 Lista de endereços aprovados
    address[] public listaAprovada;
    
    // 🔍 Mapping para verificação rápida
    mapping(address => bool) public estaOAprovado;
    
    // 👑 Apenas o dono pode alterar a whitelist
    address public dono;
    
    constructor() {
        dono = msg.sender;
    }
    
    modifier apenasODono() {
        require(msg.sender == dono, "Apenas o dono");
        _;
    }
    
    modifier apenasAprovado() {
        require(estaOAprovado[msg.sender], "Voce nao esta aprovado");
        _;
    }
    
    /**
     * @dev Adiciona um endereço à whitelist
     * @param endereco O endereço a aprovar
     */
    function adicionarAprovado(address endereco) public apenasODono {
        require(endereco != address(0), "Endereco invalido");
        require(!estaOAprovado[endereco], "Ja esta aprovado");
        
        listaAprovada.push(endereco);
        estaOAprovado[endereco] = true;
    }
    
    /**
     * @dev Remove um endereço da whitelist
     * @param endereco O endereço a remover
     */
    function removerAprovado(address endereco) public apenasODono {
        require(estaOAprovado[endereco], "Nao esta na whitelist");
        estaOAprovado[endereco] = false;
    }
    
    /**
     * @dev Verifica quantos endereços estão na whitelist
     */
    function totalAprovados() public view returns (uint256) {
        return listaAprovada.length;
    }
    
    /**
     * @dev Função restrita apenas para quem está na whitelist
     */
    function funcaoRestrita() public apenasAprovado {
        // Apenas endereços aprovados chegam aqui
    }
}
