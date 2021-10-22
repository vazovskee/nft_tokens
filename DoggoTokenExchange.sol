
pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

contract DoggoTokenExchange {
    
    struct DoggoToken {
        string name;
        string breed;
        string color;
        uint8 weight;
    }

    mapping (string => DoggoToken) tokens;  // имя токена выступает в качестве ключа

}
