// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title Cofrinho
 * @dev Contrato para depositar e retirar ETH de forma segura
 * Ensina: payable + msg.value + require + segurança
 */
contract Cofrinho {
    
    // 💰 Mapeia endereço => saldo em wei
    mapping(address => uint256) public saldos;
    
    /**
     * @dev Função para depositar ETH (qualquer valor)
     * 
     * Uso: Envie ETH junto e será adicionado ao seu saldo
     * msg.value = quantidade de ETH em wei
     */
    function depositar() public payable {
        require(msg.value > 0, "Deposito deve ser maior que zero");
        saldos[msg.sender] += msg.value;
    }
    
    /**
     * @dev Retira uma quantia específica de ETH
     * @param valor Quantidade em wei a retirar
     * 
     * Requer: Você ter saldo suficiente
     */
    function sacar(uint256 valor) public {
        require(saldos[msg.sender] >= valor, "Saldo insuficiente");
        require(valor > 0, "Saque deve ser maior que zero");
        
        // Primeiro atualiza o saldo (segurança contra re-entrancy)
        saldos[msg.sender] -= valor;
        
        // Depois transfere
        payable(msg.sender).transfer(valor);
    }
    
    /**
     * @dev Vê seu saldo atual em wei
     * @return Seu saldo em wei (divide por 10^18 pra converter pra ETH)
     */
    function meuSaldo() public view returns (uint256) {
        return saldos[msg.sender];
    }
    
    /**
     * @dev Saca tudo de uma vez
     */
    function sacarTudo() public {
        uint256 saldo = saldos[msg.sender];
        require(saldo > 0, "Sem saldo para sacar");
        
        saldos[msg.sender] = 0;
        payable(msg.sender).transfer(saldo);
    }
}
