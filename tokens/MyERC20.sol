// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title MeuPrimeiroToken
 * @dev Implementação didática do padrão ERC-20
 *
 * ERC-20 é o padrão de tokens fungíveis no Ethereum.
 * "Fungível" significa que todos os tokens são idênticos e
 * intercambiáveis — assim como dinheiro. R$10 é R$10,
 * independente de qual nota você tem na mão.
 *
 * Diferença principal do ERC-721:
 * - ERC-721: cada token tem um ID único e um dono
 * - ERC-20:  tokens não têm identidade, só quantidade
 */
contract MeuPrimeiroToken {

    // =========================================================
    // DADOS DO TOKEN
    // =========================================================

    string public name   = "Aula Bruno Token";
    string public symbol = "ABT";

    // Casas decimais: define a menor fração possível do token.
    // 18 é o padrão — igual ao Ether (1 ETH = 10^18 wei).
    // Exemplo: 1 ABT "humano" = 1000000000000000000 na blockchain.
    uint8 public decimals = 18;

    // Quantidade total de tokens em circulação.
    // Aumenta no mint, diminui no burn.
    uint256 public totalSupply;

    // =========================================================
    // MAPPINGS PRINCIPAIS
    // =========================================================

    // Dado um endereço, qual é o seu saldo?
    mapping(address => uint256) private _balances;

    // Dado um dono e um gastador, quanto o gastador pode gastar?
    // Isso é a "allowance" — permissão de gasto delegado.
    // Usado por contratos DeFi, exchanges etc.
    mapping(address => mapping(address => uint256)) private _allowances;

    // =========================================================
    // EVENTOS (padrão ERC-20 obrigatório)
    // =========================================================

    // Emitido sempre que tokens mudam de endereço.
    // No mint: _from = address(0), pois os tokens não existiam antes.
    // No burn: _to   = address(0), pois os tokens deixam de existir.
    event Transfer(
        address indexed from,
        address indexed to,
        uint256 value
    );

    // Emitido quando um dono autoriza um gastador a usar seus tokens.
    // Aplicações externas (como DEXes) escutam esse evento para
    // saber que podem chamar transferFrom em nome do dono.
    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );

    // =========================================================
    // CONSTRUTOR — executado uma única vez no deploy
    // =========================================================

    /**
     * @dev Define o supply inicial e entrega tudo para quem fez o deploy.
     * Multiplicamos por 10^18 para respeitar as casas decimais:
     * se _initialSupply = 1000, o contrato cria 1000 tokens "humanos",
     * que internamente são representados como 1000 * 10^18.
     *
     * @param _initialSupply Quantidade de tokens a criar (sem decimais)
     */
    constructor(uint256 _initialSupply) {
        totalSupply         = _initialSupply * 10 ** uint256(decimals);
        _balances[msg.sender] = totalSupply;

        // Convenção: mint emite Transfer com from = address(0)
        emit Transfer(address(0), msg.sender, totalSupply);
    }

    // =========================================================
    // CONSULTAS (view) — não custam gas quando chamadas externamente
    // =========================================================

    /**
     * @dev Retorna o saldo de um endereço.
     * O valor retornado inclui os decimais — para exibir
     * ao usuário, divida por 10^18.
     */
    function balanceOf(address _owner) public view returns (uint256) {
        return _balances[_owner];
    }

    /**
     * @dev Retorna quanto _spender ainda pode gastar em nome de _owner.
     * Diminui a cada transferFrom e pode ser redefinido com approve().
     */
    function allowance(
        address _owner,
        address _spender
    ) public view returns (uint256) {
        return _allowances[_owner][_spender];
    }

    // =========================================================
    // TRANSFERÊNCIA DIRETA
    // =========================================================

    /**
     * @dev Transfere tokens do remetente para _to.
     * Só quem chama a função pode mover seus próprios tokens.
     *
     * @param _to    Endereço de destino
     * @param _value Quantidade a transferir (com decimais)
     */
    function transfer(
        address _to,
        uint256 _value
    ) public returns (bool) {
        require(_to != address(0),             "Destino invalido");
        require(_balances[msg.sender] >= _value, "Saldo insuficiente");

        _balances[msg.sender] -= _value;
        _balances[_to]        += _value;

        emit Transfer(msg.sender, _to, _value);
        return true;
    }

    // =========================================================
    // APROVAÇÕES — base do DeFi
    // =========================================================

    /**
     * @dev Autoriza _spender a gastar até _value tokens em seu nome.
     *
     * Caso de uso típico: você quer usar uma DEX (exchange descentralizada).
     * Antes de trocar, você aprova o contrato da DEX para movimentar
     * seus tokens — assim ela pode executar a troca sem você
     * precisar assinar cada transação individualmente.
     *
     * ATENÇÃO: chamar approve() sobrescreve a allowance anterior.
     * Para reduzir uma allowance existente com segurança, o ideal
     * é primeiro zerar (approve 0) e depois setar o novo valor.
     *
     * @param _spender Endereço autorizado a gastar
     * @param _value   Limite máximo de gasto
     */
    function approve(
        address _spender,
        uint256 _value
    ) public returns (bool) {
        require(_spender != address(0), "Spender invalido");

        _allowances[msg.sender][_spender] = _value;

        emit Approval(msg.sender, _spender, _value);
        return true;
    }

    // =========================================================
    // TRANSFERÊNCIA DELEGADA
    // =========================================================

    /**
     * @dev Transfere tokens em nome de _from, usando a allowance.
     * Quem chama essa função é o _spender aprovado — não o dono.
     *
     * Fluxo completo:
     * 1. Dono chama approve(spender, valor)
     * 2. Spender chama transferFrom(dono, destino, valor)
     * 3. A allowance diminui automaticamente
     *
     * @param _from  Endereço de origem (quem tem os tokens)
     * @param _to    Endereço de destino
     * @param _value Quantidade a transferir
     */
    function transferFrom(
        address _from,
        address _to,
        uint256 _value
    ) public returns (bool) {
        require(_to != address(0),                        "Destino invalido");
        require(_balances[_from] >= _value,               "Saldo insuficiente");
        require(_allowances[_from][msg.sender] >= _value, "Allowance insuficiente");

        _balances[_from]                  -= _value;
        _balances[_to]                    += _value;
        _allowances[_from][msg.sender]    -= _value;

        emit Transfer(_from, _to, _value);
        return true;
    }

    // =========================================================
    // MINT — criar novos tokens
    // =========================================================

    /**
     * @dev Cria novos tokens e entrega para _to.
     * Aumenta o totalSupply.
     *
     * ATENÇÃO: nesse exemplo didático qualquer um pode mintar.
     * Em produção, use um modificador onlyOwner ou similar
     * para restringir quem pode criar tokens.
     *
     * @param _to    Quem vai receber os tokens criados
     * @param _value Quantidade a criar (com decimais)
     */
    function mint(address _to, uint256 _value) public {
        require(_to != address(0), "Destino invalido");

        totalSupply     += _value;
        _balances[_to]  += _value;

        // Convenção: mint emite Transfer com from = address(0)
        emit Transfer(address(0), _to, _value);
    }

    // =========================================================
    // BURN — destruir tokens
    // =========================================================

    /**
     * @dev Destrói tokens do próprio remetente.
     * Diminui o totalSupply — útil para mecanismos deflacionários.
     *
     * Exemplos de uso real:
     * - Projetos que queimam tokens para valorizar os restantes
     * - Pagamento de taxas que são destruídas (EIP-1559 no ETH)
     *
     * @param _value Quantidade a destruir (com decimais)
     */
    function burn(uint256 _value) public {
        require(_balances[msg.sender] >= _value, "Saldo insuficiente");

        _balances[msg.sender]  -= _value;
        totalSupply            -= _value;

        // Convenção: burn emite Transfer com to = address(0)
        emit Transfer(msg.sender, address(0), _value);
    }
}