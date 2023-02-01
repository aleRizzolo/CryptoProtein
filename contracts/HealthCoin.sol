// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";

contract HealthCoin is ERC20, AccessControl {
   bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
   address destinatario;

   mapping(uint => uint) private pricesMapping;

   constructor(
        string memory name,
        string memory symbol,
        uint256 initialSupply) ERC20(name, symbol) {
      _mint(msg.sender, initialSupply);
      _setupRole(DEFAULT_ADMIN_ROLE, msg.sender);
      _setRoleAdmin(MINTER_ROLE, DEFAULT_ADMIN_ROLE);

      pricesMapping[0] = 20000000000000000000;
      pricesMapping[1] = 40000000000000000000;
      pricesMapping[2] = 40000000000000000000;
      pricesMapping[3] = 50000000000000000000;
      pricesMapping[4] = 80000000000000000000;
      pricesMapping[5] = 110000000000000000000;
      pricesMapping[6] = 120000000000000000000;
      pricesMapping[7] = 250000000000000000000;

   }

   event Debug(address user, address sender, bytes32 role, bytes32 adminRole, bytes32 senderRole);
   event ChecksoloAdmin(address user);
   event ChecksoloMinters(address user);

   modifier soloAdmin() {
      emit ChecksoloAdmin(msg.sender);
      require(isAdmin(msg.sender), "Restricted to admins");
      _;
   }

   modifier soloMinters() {
      emit ChecksoloMinters(msg.sender);
      require(isMinter(msg.sender), "Caller is not a minter");
      _;
   }

   function isAdmin(address account) public virtual view returns (bool) {
      return hasRole(DEFAULT_ADMIN_ROLE, account);
   }

   function isMinter(address account) public virtual view returns (bool) {
      return hasRole(MINTER_ROLE, account);
   }

   function mint(address to, uint256 amount) public soloMinters {
      _mint(to, amount);
    }

    function addMinterRole(address to) public soloAdmin {
      emit Debug(to, msg.sender, MINTER_ROLE, getRoleAdmin(MINTER_ROLE), DEFAULT_ADMIN_ROLE);
      grantRole(MINTER_ROLE, to);
    }

    function removeMinterRole (address to) public {
      renounceRole(MINTER_ROLE, to);
    }

    function setDestinatario (address to) public soloAdmin{
      destinatario=to;
    }

    function payItem(uint256 price, uint itemId) public returns (uint){
      require(pricesMapping[itemId]==price);
      //Qua va messo l'indirizzo del gestore della CryptoGym
      require(transfer(0xc9a68AA2B9dF277C8BEA55187a1FC4B89269c2e4,price));
      return itemId;
    }

}
