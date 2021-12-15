pragma solidity >=0.7.0 < 0.9.0;

/**
 * @title Wishlist
 * @dev A simple wishlist contract.
 */

contract Wishlist {
    struct Item {
        string name;
        string description;
        uint price;
        bool purchased;
    }

    address private owner;

    uint public itemCount;
    mapping(uint => Item) public items;

    /**
     * @dev Modifier to check if caller is owner
     */
    modifier isOwner() {
        // If the first argument of 'require' evaluates to 'false', execution terminates and all
        // changes to the state and to Ether balances are reverted.
        // This used to consume all gas in old EVM versions, but not anymore.
        // It is often a good idea to use 'require' to check if functions are called correctly.
        // As a second argument, you can also provide an explanation about what went wrong.
        require(msg.sender == owner, "Caller is not owner");
        _;
    }


    /**
     * @dev Constructor
     */
    constructor() {
        owner = msg.sender; // 'msg.sender' is sender of current call, contract deployer for a constructor
        itemCount = 0;
    }

    /**
     * @dev Add an item to the wishlist.
     * @param _name The name of the item.
     * @param _description The description of the item.
     * @param _price The price of the item.
     * @return The ID of the item.
     */
    function addItem(string memory _name, string memory _description, uint _price) public isOwner returns (uint) {
        itemCount++;
        
        Item storage item = items[itemCount];
        item.name = _name;
        item.description = _description;
        item.price = _price;
        item.purchased = false;

        return itemCount;
    }

    /**
     * @dev Remove an item from the wishlist.
     * @param _id The ID of the item.
     */
    function removeItem(uint _id) public isOwner {
        delete items[_id];
    }

    /**
     * @dev Purchase an item.
     * @param _id The ID of the item.
     */
    function purchaseItem(uint _id) public isOwner {
        items[_id].purchased = true;
    }
}