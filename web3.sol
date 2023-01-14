pragma solidity ^0.6.0;

// This contract represents a simple NFT game
contract NFTGame {
    // Define a struct for players, with their id, name, and score
    struct Player {
        uint id;
        string name;
        uint score;
    }

    // Create a mapping from player id to player struct
    mapping(uint => Player) public players;

    // Create a mapping from player id to their NFT token ID
    mapping(uint => uint) public tokens;

    // Create an array to store the top players, sorted by score
    Player[] public leaderboard;

    // Create an event to log when a player joins the game
    event PlayerJoined(uint id, string name);

    // Create a function to let a player join the game
    function join(string memory _name) public {
        // Generate a new player ID
        uint id = players.length++;

        // Create a new player struct and add it to the mapping
        Player memory player = Player(id, _name, 0);
        players[id] = player;

        // Emit the PlayerJoined event
        emit PlayerJoined(id, _name);
    }

    // Create a function to let a player increment their score
    function increment(uint _id) public {
        // Get the player struct
        Player storage player = players[_id];

        // Increment the player's score
        player.score++;
    }

    // Create a function to get the current leaderboard
    function getLeaderboard() public view returns (Player[] memory) {
        // Sort the players by score
        LeaderboardStorage storage leaderboardStorage = LeaderboardStorage(this);
        leaderboard = leaderboardStorage.get();
        return leaderboard;
    }
}
