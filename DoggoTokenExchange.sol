
pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

contract DoggoTokenExchange {

    struct DoggoToken {
        string name;
        string breed;
        string color;
        uint8 weight;
    }

    DoggoToken[] public tokens;                    // массив, хранящий все созданные токены
    mapping (uint => uint128) public tradedTokens; // сопоставление индекса продаваемого токена с его ценой 
    mapping (string => uint) nameToToken;          // сопоставление названия токена с его индексом в массиве tokens
    mapping (uint => uint) tokenToOwner;           // сопоставление индекса токена с адресом владельца
    

    // модификатор для проверки существования индекса токена в массиве tokens
    modifier checkTokenExistence(uint tokenId) {
        require(tokenId <= tokens.length - 1, 201, "Token with this id doesn't exist");
        _;
    }

    // создание нового токена
    function createToken(string tokenName, string breed, string color, uint8 weight) public {
        require(!tokenName.empty(), 202, "Token's name cannot be empty");
        require(!nameToToken.exists(tokenName), 203, "Token with this name already exists");
        tvm.accept();

        tokens.push(DoggoToken(tokenName, breed, color, weight));

        uint lastTokenId = tokens.length - 1;     // индекс последнего сохранённого токена
        nameToToken[tokenName] = lastTokenId;     // устанавливаем соответствие между именем токена и его индексом
        tokenToOwner[lastTokenId] = msg.pubkey(); // присваиваем новый токен владельцу
    }

    // выставление токена на продажу
    function putTokenForSale(uint tokenId, uint128 price) public checkTokenExistence(tokenId) {
        require(msg.pubkey() == tokenToOwner[tokenId], 204, "Only token's owner can put it for sale");
        tvm.accept();

        tradedTokens[tokenId] = price; // устанавливаем цену выставленного на продажу токена
    }

    // получение искомого токена
    function getToken(uint tokenId) public checkTokenExistence(tokenId) view returns (DoggoToken) {
        return tokens[tokenId];
    }
}
