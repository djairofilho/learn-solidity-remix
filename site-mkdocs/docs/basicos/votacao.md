# Votação

Sistema simples de votação com uma votação por pessoa.

**Conceitos ensinados:**
- `mapping` (dicionário blockchain)
- Lógica de negócio (`require`)
- Controle simples de acesso
- Estrutura condicional

## Código

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title Votacao
 * @dev Sistema simples de votação com uma votação por pessoa
 * Ensina: mapping + require + lógica de negócio
 *
 * Como testar no Remix:
 * 1. Deploy no Remix VM.
 * 2. Chame votar("Alice") com a conta 1.
 * 3. Chame obterVotos("Alice") e confirme valor 1.
 * 4. Tente votar("Bob") novamente com a conta 1 e veja o require falhar.
 * 5. Troque para a conta 2 e vote em "Bob" para validar votos independentes por endereço.
 */
contract Votacao {
    
    // Mapeia candidato => número de votos
    mapping(string => uint256) public votos;
    
    // Controla quem já votou
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
```

## Como Testar no Remix

1. **Deploy** no Remix VM
2. Troque para **Conta 1** e chame `votar("Alice")`
3. Chame `obterVotos("Alice")` → deve mostrar **1**
4. Tente `votar("Bob")` com a **mesma conta** → deve reverter
5. Troque para **Conta 2** e vote em "Bob"
6. Confirme que cada conta tem votes independentes

## Use Case

Engajamento em votações • Lógica real de negócio
