
pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

contract DoggoTokenExchange {
    
    struct DoggoToken {
        string name;
        string breed;
        string color;
        uint8 weight;
    }

    mapping (string => DoggoToken) allTokens;  // сопоставление имени токена с самим токеном
    mapping (string => uint) tokenToOwner;     // сопоставление имени токена с его текущим владельцем
    mapping (string => uint128) tokensForSale; // сопоставление имени выставленного на продажу токена с его ценой

    function createToken(string tokenName, string breed, string color, uint8 weight) public {
        require(!tokenName.empty(), 201, "Token's name cannot be empty");
        require(!allTokens.exists(tokenName), 202, "Token with this name already exists");
        tvm.accept();

        allTokens[tokenName] = DoggoToken(tokenName, breed, color, weight); // создание нового токена
        tokenToOwner[tokenName] = msg.pubkey(); // присваиваем новый токен владельцу
    }

    function putTokenForSale(string tokenName, uint128 price) public {
        require(allTokens.exists(tokenName), 203, "Token with this name doesn't exist");
        require(msg.pubkey() == tokenToOwner[tokenName], 204, "Only owner of the token can put it for sale");
        tvm.accept();
        
        tokensForSale[tokenName] = price; // выставляем цену токена, выставленного на продажу
    }
}
