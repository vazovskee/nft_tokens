
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

    function createToken(string name, string breed, string color, uint8 weight) public {
        require(!name.empty(), 201, "Token's name cannot be empty");
        require(!allTokens.exists(name), 202, "Token with this name already exists");
        tvm.accept();

        allTokens[name] = DoggoToken(name, breed, color, weight); // создание нового токена
        tokenToOwner[name] = msg.pubkey();                        // присваиваем новый токен владельцу
    }
}
