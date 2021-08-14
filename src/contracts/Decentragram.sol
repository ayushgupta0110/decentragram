pragma solidity ^0.5.0;

contract Decentragram {
  string public name = "Decentragram";

  //Store Images
  uint public imageCount = 0;
  mapping (uint => Image) public images;
  
  struct Image{
    uint id;
    string hash;
    string description;
    uint tipAmount;
    address payable author;  
  }
  
  event imageCreated(
    uint id,
    string hash,
    string description,
    uint tipAmount,
    address payable author 
  );

  //Create Images
    function uploadImage(string memory _imagehash,string memory _description) public{
      imageCount++;
      images[imageCount] = Image(imageCount,_imagehash,_description, 0, msg.sender);
    //Emit the event 
      emit imageCreated(imageCount,_imagehash,_description,0,msg.sender);
    }

  //Tip Images
}