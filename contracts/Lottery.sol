pragma solidity ^0.4.17;

contract Lottery {
    // Manager und Spieler Variablen
  address public manager;
  address[] public players;

    // Constructor der den Manager auf msg.sender Adresse festlegt
  function Lottery() public {
    manager = msg.sender;
    
  }
    // Mit dieser Funktion werden die Addressen der Spieler in das Array Plyers eingetragen, 
    // wenn sie mehr als 0.01 Ether einzahlen in den Contact
  function enter() public payable {
    require(msg.value > 0.01 ether );

    players.push(msg.sender);
  }

    //Es wird eine Random Zahl generiert
  function random() private view returns(uint) {
    return uint(keccak256(block.difficulty, now, players));
  }

    // Die PickWinner Funktion hat eine Eigenschaft, das nur der Manager diese Funktion ausführen kann
    // Die Randomzahl wird zu einer Zahl gemacht, die einen Gewinner anhand der Anzahl der Teilnehmer
    // im Array feststellt
    // Das Geld was in dem Contract ist, wird an den Gewinner ausgezahlt
    // Das Array players wird anschließend wieder auf 0 gesetzt
  function pickWinner() public restricted {
    
    uint index = random() % players.length;
    players[index].transfer(this.balance);
    players = new address[](0);
  }

    // DONT REPEAT YOURSELF
    // Die Menge an Code soll verringert werden, wenn wir uns immer wieder wiederholen mit Code
    // _; danach wird der ganze Code ausgeführt
  modifier restricted() {
     require( msg.sender == manager);
     _;
  }

    //Zeigt alle Spieler mit ihren Adressen, die diesem Contract beigetreten sind
  function getPlayers() public view returns (address[]){
    return players;
}

}