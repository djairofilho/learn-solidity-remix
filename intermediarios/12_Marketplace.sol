// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title MarketplaceSimples
 * @dev Marketplace: vendedores listam itens, compradores compram com comissão
 * Ensina: inventory management, comissões, payable, endereço do vendedor
 */
contract MarketplaceSimples {
    
    // 🏪 Informações de item
    struct Item {
        uint256 id;
        address vendedor;
        string nome;
        uint256 preco;
        bool vendido;
    }
    
    // 🎫 Controle de itens
    Item[] public itens;
    uint256 public itemProximo = 0;
    
    // 💰 Rastreamento de fundos vendedor
    mapping(address => uint256) public ganhoVendedor;
    
    // 📊 Estatisticas
    uint256 public percentualComissao = 5; // 5% do marketplace
    address public dono;
    uint256 public comissaoTotal;
    
    event ItemListado(uint256 indexed id, address indexed vendedor, string nome, uint256 preco);
    event ItemVendido(uint256 indexed id, address indexed vendedor, address indexed comprador, uint256 preco);
    event SaqueGanho(address indexed vendedor, uint256 valor);
    
    constructor() {
        dono = msg.sender;
    }
    
    /**
     * @dev Vendedor lista um novo item
     */
    function listarItem(string memory _nome, uint256 _preco) public {
        require(_preco > 0, "Preco deve ser maior que zero");
        
        itens.push(Item({
            id: itemProximo,
            vendedor: msg.sender,
            nome: _nome,
            preco: _preco,
            vendido: false
        }));
        
        emit ItemListado(itemProximo, msg.sender, _nome, _preco);
        itemProximo += 1;
    }
    
    /**
     * @dev Comprador compra um item
     */
    function comprarItem(uint256 _id) public payable {
        require(_id < itens.length, "Item nao existe");
        Item storage item = itens[_id];
        
        require(!item.vendido, "Item ja foi vendido");
        require(msg.value == item.preco, "Valor incorreto");
        require(msg.sender != item.vendedor, "Voce nao pode comprar seu proprio item");
        
        // Calcula comissão e valor pro vendedor
        uint256 comissao = (item.preco * percentualComissao) / 100;
        uint256 valorVendedor = item.preco - comissao;
        
        // Marca como vendido
        item.vendido = true;
        
        // Registra ganhos
        ganhoVendedor[item.vendedor] += valorVendedor;
        comissaoTotal += comissao;
        
        emit ItemVendido(_id, item.vendedor, msg.sender, item.preco);
    }
    
    /**
     * @dev Vendedor saca seus ganhos
     */
    function sacarGanhos() public {
        uint256 ganho = ganhoVendedor[msg.sender];
        require(ganho > 0, "Sem ganhos");
        
        ganhoVendedor[msg.sender] = 0;
        payable(msg.sender).transfer(ganho);
        
        emit SaqueGanho(msg.sender, ganho);
    }
    
    /**
     * @dev Dono saca comissão
     */
    function sacarComissao() public {
        require(msg.sender == dono, "Apenas dono");
        require(comissaoTotal > 0, "Sem comissao");
        
        uint256 comissao = comissaoTotal;
        comissaoTotal = 0;
        
        payable(dono).transfer(comissao);
    }
    
    /**
     * @dev Vê quantos itens foram listados
     */
    function totalItens() public view returns (uint256) {
        return itens.length;
    }
    
    /**
     * @dev Vê um item específico
     */
    function verItem(uint256 _id) public view returns (Item memory) {
        require(_id < itens.length, "Item nao existe");
        return itens[_id];
    }
    
    /**
     * @dev Vê quantos ganhos você tem
     */
    function meuGanho() public view returns (uint256) {
        return ganhoVendedor[msg.sender];
    }
    
    /**
     * @dev Lista todos os itens não vendidos
     */
    function listarItensDisponiveis() public view returns (Item[] memory) {
        uint256 contador = 0;
        
        // Primeiro conta quantos itens estão disponíveis
        for (uint256 i = 0; i < itens.length; i++) {
            if (!itens[i].vendido) contador += 1;
        }
        
        // Cria array com o tamanho correto
        Item[] memory disponiveis = new Item[](contador);
        uint256 index = 0;
        
        for (uint256 i = 0; i < itens.length; i++) {
            if (!itens[i].vendido) {
                disponiveis[index] = itens[i];
                index += 1;
            }
        }
        
        return disponiveis;
    }
    
    // Para receber ETH
    receive() external payable {}
}
