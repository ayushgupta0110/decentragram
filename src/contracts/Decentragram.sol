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
  
  event ImageCreated(
    uint id,
    string hash,
    string description,
    uint tipAmount, 
    address payable author 
  );

  event ImageTipped(
    uint id,
    string hash,
    string description,
    uint tipAmount, 
    address payable author 
  );

  //Create Images
    function uploadImage(string memory _imagehash,string memory _description) public{
      //Make sure the image hash is not empty
      require(bytes(_imagehash).length >0, 'Hash cannot be empty');

      //Make sure image description exists
      require(bytes(_description).length > 0, 'Description must be at least 1 character');

      //Make sure the uploader address is present
      require(msg.sender != address(0), 'Sender must be present');

      //Increment image count i.e. id
      imageCount++;

      //Add Image to contract
      images[imageCount] = Image(imageCount,_imagehash,_description, 0, msg.sender);

    //Trigger an event 
      emit ImageCreated(imageCount,_imagehash,_description,0,msg.sender);
    }

  //Tip Images
    function tipImageOwner(uint _id) public payable{
     //Make sure the id is valid
      require(_id >0 && _id <=imageCount, 'Invalid Image ID');
     
     //fetch the image 
      Image memory _image = images[_id];

      //fetch the image author
      address payable _author = _image.author;

      //Transfer the ether to the image owner
      address(_author).transfer(msg.value);
    
      //Increment the image tip amount
      _image.tipAmount = _image.tipAmount + msg.value;
      
      //Update image in the blockchain
      images[_id] = _image;
 
      //Trigger an event
      emit ImageTipped(_id,_image.hash,_image.description,_image.tipAmount,_author);
    } 
}