// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title MeuPrimeiroNFT
 * @dev Implementação didática do padrão ERC-721
 * 
 * Diferença principal do ERC-20:
 * - ERC-20: todos os tokens são iguais (fungíveis)
 * - ERC-721: cada token tem um ID único e um dono (não fungível)
 *
 * Como testar no Remix:
 * 1. Deploy no Remix VM.
 * 2. Chame mint(conta1, "ipfs://token-1.json") e mint(conta2, "ipfs://token-2.json").
 * 3. Consulte ownerOf(1), balanceOf(conta1) e tokenURI(1).
 * 4. Conta1 chama approve(conta3, 1) e conta3 chama transferFrom(conta1, conta2, 1).
 * 5. Teste setApprovalForAll(conta3, true) e valide com isApprovedForAll(conta1, conta3).
 */
contract MeuPrimeiroNFT {

    // =========================================================
    // DADOS DO TOKEN
    // =========================================================

    string public name   = "Mentoria NFT";
    string public symbol = "ABNFT";

    // Contador para gerar IDs únicos.
    // O primeiro NFT terá ID 1, o segundo ID 2, e assim por diante.
    uint256 private _nextTokenId = 1;

    // =========================================================
    // MAPPINGS PRINCIPAIS
    // =========================================================

    // Dado um tokenId, quem é o dono?
    mapping(uint256 => address) private _owners;

    // Dado um endereço, quantos NFTs ele possui?
    mapping(address => uint256) private _balances;

    // Dado um tokenId, qual endereço está aprovado para movimentá-lo?
    // Diferente do ERC-20: a aprovação é por token, não por valor.
    mapping(uint256 => address) private _tokenApprovals;

    // Dado um dono e um operador, esse operador pode mexer em TODOS
    // os NFTs do dono? Isso é chamado de "aprovação total" (setApprovalForAll).
    mapping(address => mapping(address => bool)) private _operatorApprovals;

    // Metadado de cada token: guarda a URI (link) com as informações do NFT
    // Ex: "ipfs://Qm.../1.json" → arquivo JSON com nome, imagem, atributos
    mapping(uint256 => string) private _tokenURIs;

    // =========================================================
    // EVENTOS (padrão ERC-721 obrigatório)
    // =========================================================

    // Emitido sempre que um NFT muda de dono (inclusive no mint)
    // No mint: _from = address(0), pois o token não existia antes
    event Transfer(
        address indexed _from,
        address indexed _to,
        uint256 indexed _tokenId
    );

    // Emitido quando um endereço é aprovado para mover um token específico
    event Approval(
        address indexed _owner,
        address indexed _approved,
        uint256 indexed _tokenId
    );

    // Emitido quando um dono aprova (ou revoga) um operador para TODOS seus tokens
    event ApprovalForAll(
        address indexed _owner,
        address indexed _operator,
        bool _approved
    );

    // =========================================================
    // MINT — criar um novo NFT
    // =========================================================

    /**
     * @dev Cria um novo NFT e entrega para o endereço _to.
     * Qualquer pessoa pode mintar nesse exemplo didático.
     * Em produção, normalmente só o dono do contrato pode mintar.
     *
     * @param _to     Endereço que vai receber o NFT
     * @param _uri    Link para os metadados do token (imagem, atributos etc.)
     */
    function mint(address _to, string memory _uri) public returns (uint256) {
        require(_to != address(0), "Nao pode mintar para endereco zero");

        uint256 tokenId = _nextTokenId;
        _nextTokenId++;

        // Registra o dono e aumenta o saldo
        _owners[tokenId]   = _to;
        _balances[_to]    += 1;
        _tokenURIs[tokenId] = _uri;

        // No mint, o "from" é o endereço zero — convenção do padrão
        emit Transfer(address(0), _to, tokenId);

        return tokenId;
    }

    // =========================================================
    // CONSULTAS (view)
    // =========================================================

    /**
     * @dev Quantos NFTs um endereço possui?
     */
    function balanceOf(address _owner) public view returns (uint256) {
        require(_owner != address(0), "Endereco invalido");
        return _balances[_owner];
    }

    /**
     * @dev Quem é o dono de um token específico?
     */
    function ownerOf(uint256 _tokenId) public view returns (address) {
        address owner = _owners[_tokenId];
        require(owner != address(0), "Token nao existe");
        return owner;
    }

    /**
     * @dev Retorna o link de metadados de um token.
     * Esse JSON normalmente contém: nome, descrição, imagem, atributos.
     */
    function tokenURI(uint256 _tokenId) public view returns (string memory) {
        require(_owners[_tokenId] != address(0), "Token nao existe");
        return _tokenURIs[_tokenId];
    }

    // =========================================================
    // TRANSFERÊNCIAS
    // =========================================================

    /**
     * @dev Transfere um NFT do remetente para _to.
     * Só o dono do token pode chamar essa função diretamente.
     */
    function transferFrom(
        address _from,
        address _to,
        uint256 _tokenId
    ) public {
        require(_to != address(0), "Destino invalido");
        require(_owners[_tokenId] == _from, "_from nao e o dono");

        // Quem pode transferir?
        // 1. O próprio dono
        // 2. Um endereço aprovado para esse token específico
        // 3. Um operador aprovado para todos os tokens do dono
        require(
            msg.sender == _from ||
            msg.sender == _tokenApprovals[_tokenId] ||
            _operatorApprovals[_from][msg.sender],
            "Sem permissao para transferir"
        );

        // Remove aprovação pontual ao transferir — boa prática de segurança
        delete _tokenApprovals[_tokenId];

        _balances[_from] -= 1;
        _balances[_to]   += 1;
        _owners[_tokenId] = _to;

        emit Transfer(_from, _to, _tokenId);
    }

    // =========================================================
    // APROVAÇÕES
    // =========================================================

    /**
     * @dev Aprova um endereço para mover um token específico.
     * Só o dono (ou um operador aprovado) pode aprovar.
     *
     * Caso de uso típico: marketplace. Você aprova o contrato
     * do marketplace para mover seu NFT quando ele for vendido.
     */
    function approve(address _approved, uint256 _tokenId) public {
        address owner = _owners[_tokenId];
        require(owner != address(0), "Token nao existe");
        require(
            msg.sender == owner || _operatorApprovals[owner][msg.sender],
            "Sem permissao para aprovar"
        );

        _tokenApprovals[_tokenId] = _approved;
        emit Approval(owner, _approved, _tokenId);
    }

    /**
     * @dev Retorna quem está aprovado para um token específico.
     */
    function getApproved(uint256 _tokenId) public view returns (address) {
        require(_owners[_tokenId] != address(0), "Token nao existe");
        return _tokenApprovals[_tokenId];
    }

    /**
     * @dev Aprova (ou revoga) um operador para TODOS os seus tokens.
     * 
     * Diferença do approve():
     * - approve()         → permissão para 1 token específico
     * - setApprovalForAll → permissão para todos os tokens do dono
     *
     * Usado por marketplaces (OpenSea, etc.) para gerenciar
     * coleções inteiras sem precisar aprovar token por token.
     */
    function setApprovalForAll(address _operator, bool _approved) public {
        require(_operator != msg.sender, "Nao pode aprovar a si mesmo");
        _operatorApprovals[msg.sender][_operator] = _approved;
        emit ApprovalForAll(msg.sender, _operator, _approved);
    }

    /**
     * @dev Verifica se um operador tem aprovação total sobre os tokens de um dono.
     */
    function isApprovedForAll(
        address _owner,
        address _operator
    ) public view returns (bool) {
        return _operatorApprovals[_owner][_operator];
    }
}