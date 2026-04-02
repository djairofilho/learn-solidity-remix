// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title Votacao
 * @dev Sistema simples de votação com uma votação por pessoa
 * Ensina: mapping + require + lógica de negócio
 */
contract Votacao {
    
    // 🗳️ Mapeia candidato => número de votos
    mapping(string => uint256) public votos;
    
    // ✅ Controla quem já votou
    mapping(address => bool) public jaVotou;
    
    /**
     * @dev Registra um voto para um candidato
     * @param candidato Nome do candidato (string)
     * 
     * Requer: Que você ainda não tenha votado
     */
    function votar(string memory candidato) public {
        require(!jaVotou[msg.sender], "Voce ja votou");
        
        votos[candidato] += 1;
        jaVotou[msg.sender] = true;
    }
    
    /**
     * @dev Vê quantos votos um candidato tem
     * @param candidato Nome do candidato
     * @return Número de votos
     */
    function obterVotos(string memory candidato) public view returns (uint256) {
        return votos[candidato];
    }
    
    /**
     * @dev Verifica se você já votou
     * @return true se já votou, false caso contrário
     */
    function voceJaVotou() public view returns (bool) {
        return jaVotou[msg.sender];
    }
}
