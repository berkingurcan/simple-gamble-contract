// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;

contract SimpleGamble {
    
    address user1;
    address user2;
    
    mapping (address => uint) userToDice;
    
    address[] public users;
    
    function join_game() public {
        require(users.length < 2, "Game is full.");
        users.push(msg.sender);
        //joined
    }
    
    mapping (address => uint) userToDeposit;
    
    function send_deposit() external payable {
        require(msg.value == 1 ether);
        userToDeposit[msg.sender] = 1; //oyun bitince sıfırla
    }
    
    function balance_of_contract() external view returns(uint){
        return address(this).balance;
    }
    
    function get_date() private returns (uint256) {
        uint256 now_date = block.timestamp;
        return now_date;
    }
    
    uint nonce = 0;
    
    function roll_dice() public returns(uint) {
        require(users.length == 2, "Other playes is waiting");
        require(users[0] == msg.sender || users[1] == msg.sender, "You are not user");
        require(userToDeposit[msg.sender] == 1, "Please deposit 1 ether");
        nonce++;
        
        uint dice = uint(keccak256(abi.encodePacked(get_date(), msg.sender, nonce))) % 6 + 1;
        userToDice[msg.sender] = dice;
        return dice;
    }
    
    function view_dice(address _sender) public view returns(uint){
        return userToDice[_sender];
    }
    
    function get_winner() public view returns(address) {
        if(view_dice(users[0]) > view_dice(users[1])) {
            return users[0];
        } else {
            return users[1];
            //beraberlik olduğunda bu fonksiyonu çalıştırmadan oyunu baştan başlat
        }
    }
    
    function send_to_winner() external {
        address payable _recipient = payable(get_winner());
        _recipient.transfer(1.9 ether);
        delete users;
    }
}
