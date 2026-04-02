// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title Leilao
 * @dev Sistema de leilão: maior lance vence
 * Ensina: tracking de bids, comparação de valores, refund logic
 *
 * Como testar no Remix:
 * 1. Deploy com _precoMinimo (ex: 100000000000000000) e _duracao (ex: 600).
 * 2. Conta 2 envia lance via fazerLance() com Value >= preco minimo.
 * 3. Conta 3 envia lance maior e vire maior lancador.
 * 4. Conta 2 chama sacarLanceAnterior() para reembolso.
 * 5. Apos o tempo, chame encerrarLeilao() e confirme evento de encerramento.
 */
contract Leilao {
    
    // 🏛️ Informações do leilão
    address public vendedor;
    uint256 public precoMinimo;
    uint256 public tempoFinal;
    bool public encerrado;
    
    // 💰 Tracking de lances
    address public maiorLancador;
    uint256 public maiorLance;
    
    // 🔄 Mapeamento de lances anteriores (para refund)
    mapping(address => uint256) public lances;
    
    event NovoLance(address indexed lancador, uint256 valor);
    event LeilaoEncerrado(address indexed vencedor, uint256 valorFinal);
    
    constructor(uint256 _precoMinimo, uint256 _duracao) {
        vendedor = msg.sender;
        precoMinimo = _precoMinimo;
        tempoFinal = block.timestamp + _duracao;
        encerrado = false;
    }
    
    /**
     * @dev Faz um lance no leilão
     * Se enviar ETH, participa com esse valor
     */
    function fazerLance() public payable {
        require(!encerrado, "Leilao ja encerrou");
        require(block.timestamp < tempoFinal, "Leilao expirou");
        
        uint256 novoLance = lances[msg.sender] + msg.value;
        require(novoLance >= precoMinimo, "Lance abaixo do minimo");
        require(novoLance > maiorLance, "Lance muito baixo");
        
        // Se tinha um lance anterior do mesmo usuario, adiciona ao novo
        if (lances[msg.sender] > 0) {
            // Mantém o antigo, depois soma o novo
        }
        
        lances[msg.sender] = novoLance;
        maiorLance = novoLance;
        maiorLancador = msg.sender;
        
        emit NovoLance(msg.sender, novoLance);
    }
    
    /**
     * @dev Retira um lance anterior (refund)
     * Quem não lucrou pode sacar a diferença
     */
    function sacarLanceAnterior() public {
        require(lances[msg.sender] > 0, "Voce nao fez lances");
        require(msg.sender != maiorLancador, "Vencedor nao pode sacar");
        
        uint256 valor = lances[msg.sender];
        lances[msg.sender] = 0;

        (bool sucesso, ) = payable(msg.sender).call{value: valor}("");
        require(sucesso, "Falha no saque");
    }
    
    /**
     * @dev Encerra o leilão (apenas depois do tempo)
     */
    function encerrarLeilao() public {
        require(block.timestamp >= tempoFinal, "Leilao ainda ativo");
        require(!encerrado, "Ja foi encerrado");
        
        encerrado = true;

        (bool sucesso, ) = payable(vendedor).call{value: maiorLance}("");
        require(sucesso, "Falha no repasse ao vendedor");
        
        emit LeilaoEncerrado(maiorLancador, maiorLance);
    }
    
    /**
     * @dev Vê qual é o maior lance atual
     */
    function verMaiorLance() public view returns (address, uint256) {
        return (maiorLancador, maiorLance);
    }
    
    /**
     * @dev Tempo restante do leilão (em segundos)
     */
    function tempoRestante() public view returns (uint256) {
        if (block.timestamp >= tempoFinal) return 0;
        return tempoFinal - block.timestamp;
    }
}
