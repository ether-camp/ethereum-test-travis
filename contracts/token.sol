contract Token {
  
  uint public price;
  mapping (address => uint) public balances;
  
  function Token(uint _price) {
    price = _price;
  }
  
  function send(address to, uint tokens) {
    if (balances[msg.sender] < tokens) throw;
    balances[msg.sender] -= tokens;
    balances[to] += tokens;
  }
  
  function withdraw(uint tokens) {
    if (balances[msg.sender] < tokens) throw;
    balances[msg.sender] -= tokens;
    if (!msg.sender.send(tokens * price)) throw;
  }
  
  function () {
    if (msg.value == 0) throw;
    
    uint tokens = msg.value / price;
    balances[msg.sender] += tokens;
    
    if (!msg.sender.send(msg.value - (tokens * price))) throw;
  }
}