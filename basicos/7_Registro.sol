// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title Registro
 * @dev Sistema de registro de documentos (cartório blockchain)
 * Ensina: struct + arrays + iteração + persistência
 *
 * Como testar no Remix:
 * 1. Deploy no Remix VM.
 * 2. Chame registrar("doc-1") e registrar("doc-2").
 * 3. Confirme totalDocumentos() igual a 2.
 * 4. Chame obterDocumento(0) e obterUltimoDocumento().
 * 5. Chame obterTodosDocumentos() para inspecionar o historico completo.
 */
contract Registro {
    
    /**
     * @dev Struct - tipo customizado para agrupar dados
     * Representa um documento registrado
     */
    struct Documento {
        string conteudo;        // O que está sendo registrado
        uint256 timestamp;      // Quando foi registrado
        address criador;        // Quem criou
    }
    
    /**
     * @dev Array de documentos para cada endereço (histórico)
     * documentos[seu_endereco] = lista de seus documentos
     */
    mapping(address => Documento[]) public documentos;
    
    /**
     * @dev Event para quando um documento é registrado
     */
    event DocumentoRegistrado(
        address indexed criador,
        string conteudo,
        uint256 timestamp
    );
    
    /**
     * @dev Registra um novo documento em seu nome
     * @param conteudo O texto/hash a armazenar
     */
    function registrar(string memory conteudo) public {
        require(bytes(conteudo).length > 0, "Conteudo nao pode ser vazio");
        
        // Cria um novo documento
        Documento memory novoDoc = Documento({
            conteudo: conteudo,
            timestamp: block.timestamp,
            criador: msg.sender
        });
        
        // Adiciona ao histórico
        documentos[msg.sender].push(novoDoc);
        
        // Emite evento
        emit DocumentoRegistrado(msg.sender, conteudo, block.timestamp);
    }
    
    /**
     * @dev Retorna quantos documentos você tem
     * @return Número de documentos registrados
     */
    function totalDocumentos() public view returns (uint256) {
        return documentos[msg.sender].length;
    }
    
    /**
     * @dev Retorna um documento específico seu
     * @param indice Qual documento (0 = primeiro, 1 = segundo, etc)
     * @return O documento (conteudo, timestamp, criador)
     */
    function obterDocumento(uint256 indice) 
        public 
        view 
        returns (Documento memory) 
    {
        require(indice < documentos[msg.sender].length, "Indice invalido");
        return documentos[msg.sender][indice];
    }
    
    /**
     * @dev Retorna todos os seus documentos
     * @return Array de todos os documentos registrados
     * 
     * ⚠️ Cuidado: Se houver muitos documentos, pode ser caro!
     */
    function obterTodosDocumentos() 
        public 
        view 
        returns (Documento[] memory) 
    {
        return documentos[msg.sender];
    }
    
    /**
     * @dev Obtém o último documento registrado
     * @return O documento mais recente
     */
    function obterUltimoDocumento() 
        public 
        view 
        returns (Documento memory) 
    {
        require(documentos[msg.sender].length > 0, "Nenhum documento registrado");
        
        uint256 ultimoIndice = documentos[msg.sender].length - 1;
        return documentos[msg.sender][ultimoIndice];
    }
}
