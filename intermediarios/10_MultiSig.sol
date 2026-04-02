// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title MultiSigSimples
 * @dev Múltiplas assinaturas: 2-de-3, 3-de-5, etc
 * Ensina: multiples approvers, voting pattern, execution
 */
contract MultiSigSimples {
    
    // 👥 Signatários autorizados
    address[] public signatarios;
    mapping(address => bool) public ehSignatario;
    
    // 🗳️ Quantas aprovações são necessárias
    uint256 public assinaturasNecessarias;
    
    // 💼 Proposta de transação
    struct Proposta {
        uint256 id;
        address alvo;
        uint256 valor;
        bytes dados;
        uint256 aprovacoes;
        bool executada;
    }
    
    Proposta[] public propostas;
    mapping(uint256 => mapping(address => bool)) public jaAprovou;
    
    event PropostaSubmetida(uint256 indexed id, address alvo, uint256 valor);
    event PropostaAprovada(uint256 indexed id, address signatario);
    event PropostaExecutada(uint256 indexed id);
    
    constructor(address[] memory _signatarios, uint256 _assinaturasNecessarias) {
        require(_signatarios.length >= _assinaturasNecessarias, "Signatarios insuficiente");
        
        for (uint256 i = 0; i < _signatarios.length; i++) {
            signatarios.push(_signatarios[i]);
            ehSignatario[_signatarios[i]] = true;
        }
        
        assinaturasNecessarias = _assinaturasNecessarias;
    }
    
    modifier apenasSignatario() {
        require(ehSignatario[msg.sender], "Nao e signatario");
        _;
    }
    
    /**
     * @dev Submete uma nova proposta de transação
     */
    function submeterProposta(
        address _alvo,
        uint256 _valor,
        bytes memory _dados
    ) public apenasSignatario {
        propostas.push(Proposta({
            id: propostas.length,
            alvo: _alvo,
            valor: _valor,
            dados: _dados,
            aprovacoes: 0,
            executada: false
        }));
        
        emit PropostaSubmetida(propostas.length - 1, _alvo, _valor);
    }
    
    /**
     * @dev Aprova uma proposta
     */
    function aprovarProposta(uint256 _id) public apenasSignatario {
        require(_id < propostas.length, "Proposta invalida");
        require(!propostas[_id].executada, "Ja foi executada");
        require(!jaAprovou[_id][msg.sender], "Ja aprovou");
        
        jaAprovou[_id][msg.sender] = true;
        propostas[_id].aprovacoes += 1;
        
        emit PropostaAprovada(_id, msg.sender);
    }
    
    /**
     * @dev Executa uma proposta se tiver aprovações suficientes
     */
    function executarProposta(uint256 _id) public apenasSignatario {
        require(_id < propostas.length, "Proposta invalida");
        require(!propostas[_id].executada, "Ja foi executada");
        require(propostas[_id].aprovacoes >= assinaturasNecessarias, "Aprovacoes insuficiente");
        
        Proposta storage proposta = propostas[_id];
        proposta.executada = true;
        
        // Executa a transação
        (bool sucesso, ) = proposta.alvo.call{value: proposta.valor}(proposta.dados);
        require(sucesso, "Execucao falhou");
        
        emit PropostaExecutada(_id);
    }
    
    /**
     * @dev Total de propostas criadas
     */
    function totalPropostas() public view returns (uint256) {
        return propostas.length;
    }
    
    /**
     * @dev Vê informações de uma proposta
     */
    function verProposta(uint256 _id) public view returns (Proposta memory) {
        require(_id < propostas.length, "Proposta invalida");
        return propostas[_id];
    }
    
    // Para receber ETH
    receive() external payable {}
}
