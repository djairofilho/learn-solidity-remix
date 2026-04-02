// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title Admin
 * @dev Padrão de ownership (usado em praticamente TODOS os contratos Web3)
 * Ensina: constructor + modifier + msg.sender + segurança
 *
 * Como testar no Remix:
 * 1. Deploy com a conta 1 e confira dono().
 * 2. Chame funcaoRestrita() com a conta 1 (deve funcionar).
 * 3. Troque para conta 2 e tente funcaoRestrita() (deve reverter).
 * 4. Volte para conta 1 e chame transferirPropriedade(conta2).
 * 5. Com conta 2, chame funcaoRestrita() novamente (agora deve funcionar).
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
     * Veja como usa o modifier onlyOwner
     */
    function funcaoRestrita() public onlyOwner {
        // Apenas o dono chega aqui
    }
    
    /**
     * @dev O dono pode transferir a propriedade pra outro endereço
     * @param novoDonoEndereco O endereco do novo dono
     */
    function transferirPropriedade(address novoDonoEndereco) public onlyOwner {
        require(novoDonoEndereco != address(0), "Endereco invalido");
        dono = novoDonoEndereco;
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
