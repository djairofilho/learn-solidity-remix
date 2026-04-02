// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title Admin
 * @dev Padrão de ownership (usado em praticamente TODOS os contratos Web3)
 * Ensina: constructor + modifier + msg.sender + segurança
 */
contract Admin {
    
    // 👑 Armazena o endereço do dono
    address public dono;
    
    /**
     * @dev Constructor chamado uma única vez na criação do contrato
     * Define quem é o dono (quem fez o deploy)
     */
    constructor() {
        dono = msg.sender;
    }
    
    /**
     * @dev Modifier - reutilizável para proteger funções
     * Se a condição falhar, a transação é revertida
     */
    modifier onlyOwner() {
        require(msg.sender == dono, "Somente o dono pode chamar isso");
        _;  // <- símbolo especial que significa "continue a execução"
    }
    
    /**
     * @dev Função que apenas o dono pode chamar
     * Veja como usa o @modifier onlyOwner
     */
    function funcaoRestrita() public onlyOwner {
        // Apenas o dono chega aqui
    }
    
    /**
     * @dev O dono pode transferir a propriedade pra outro endereço
     * @param novoDonoEndereço O endereço do novo dono
     */
    function transferirPropriedade(address novoDonoEndereço) public onlyOwner {
        require(novoDonoEndereço != address(0), "Endereco invalido");
        dono = novoDonoEndereço;
    }
    
    /**
     * @dev Verifica se um endereço é o dono
     * @param endereco O endereço a verificar
     * @return true se é o dono, false caso contrário
     */
    function ehDono(address endereco) public view returns (bool) {
        return endereco == dono;
    }
}
