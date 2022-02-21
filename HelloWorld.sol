pragma solidity ^0.5.0;

contract HelloWorld {
     string public hello = "Hi, Hello AT!";
     
     uint256[] private numbers;
     
     // - Mapping is unbound dict
     // ! Default value is 0 (not None)
     mapping (string => uint256) public keyValueStore;
     // To solve the above problem
     mapping (string => bool) public hashValue;
     // Count mapping length
     uint256 public keyValueLength;
     
     constructor(uint256[] memory initData) public {
         numbers = initData;
     }
     
     // Array numbers
     function pushNumber(uint256 newNumber) public {
         numbers.push(newNumber);
     }
     
     function getNumber(uint256 index) public view returns (uint256) {
         return numbers[index];
     }
     
     // cannot use .length with mapping datatype
     function getNumberLength() public view returns (uint256) {
         return numbers.length;
     }
     
     // Mapping Key value store
     // * string in solidity is byte Array. Don't forget "memory"
     function setKeyValue(string memory key, uint256 value) public {
         keyValueStore[key] = value;
         
         // adding new value if never has value before
         if (hashValue[key] == false) {
             keyValueLength += 1;
         // when has value
         } else if (value == 0) {
                 keyValueLength -= 1;
         }
         // resolve above problem
         hashValue[key] = true;
     }
     
/*     function hashValue(string memory key) public view returns(bool) {
         // check if keyValueStore[key] not equal 0 then return boolean
         return keyValueStore[key] != 0;
     }*/
}