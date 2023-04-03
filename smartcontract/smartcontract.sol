pragma solidity ^0.6.0;
pragma experimental ABIEncoderV2;
import "solidity-string-utils/StringUtils.sol";


contract SupplyChain {
    
    event Added(uint256 index);
    
    struct State{
        string description;
        address person;
    }
    
    struct Product{
        address creator;
        string productName;
        string prodgrd;
        string prodtype;
        string prodlife;
        string packsize;
        string prodqnt;
        string manuname;
        string avail;
        uint256 productId;
        string date;
        string cntno;
        uint256 totalStates;
        mapping (uint256 => State) positions;
    }
    
    mapping(uint => Product) allProducts;
    uint256 items=0;

    function uint2str(uint _i) internal pure returns (string memory _uintAsString) {
        if (_i == 0) {
            return "0";
        }
        uint j = _i;
        uint len;
        while (j != 0) {
            len++;
            j /= 10;
        }
        bytes memory bstr = new bytes(len);
        uint k = len - 1;
        while (_i != 0) {
            bstr[k--] = byte(uint8(48 + _i % 10));
            _i /= 10;
        }
        return string(bstr);
    }

    function concat(string memory _a, string memory _b) public returns (string memory){
        bytes memory bytes_a = bytes(_a);
        bytes memory bytes_b = bytes(_b);
        string memory length_ab = new string(bytes_a.length + bytes_b.length);
        bytes memory bytes_c = bytes(length_ab);
        uint k = 0;
        for (uint i = 0; i < bytes_a.length; i++) bytes_c[k++] = bytes_a[i];
        for (uint i = 0; i < bytes_b.length; i++) bytes_c[k++] = bytes_b[i];
        return string(bytes_c);
    }
    
    function newItem(string memory _prodname, string memory _prodgrd, string memory _type, string memory _prodlife, string memory _packsize, string memory _prodqnt, string memory _manuname, string memory _avail, string memory _cntno, string memory _date) public returns (bool) {
        Product memory newItem = Product({creator: msg.sender, totalStates: 0,productName: _prodname, prodgrd: _prodgrd, 
        prodtype: _type, prodlife: _prodlife, packsize: _packsize, prodqnt: _prodqnt, manuname: _manuname, avail: _avail, cntno: _cntno, productId: items, date: _date});
        allProducts[items]=newItem;
        items = items+1;
        emit Added(items-1);
        return true;
    }
    
    function addState(uint _productId, string memory info) public returns (string memory) {
        require(_productId<=items);
        allProducts[_productId].avail= "Out of Stock";
        State memory newState = State({person: msg.sender, description: info});
        
        allProducts[_productId].positions[ allProducts[_productId].totalStates ]=newState;
        
        allProducts[_productId].totalStates = allProducts[_productId].totalStates +1;
        return info;
    }
    function displayprods() public returns (string memory) {
        string memory allout ="<head><link href='https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css' rel='stylesheet' integrity='sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ' crossorigin='anonymous'><script src='https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js' integrity='sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe' crossorigin='anonymous'></script>";
        allout=concat(allout, "<style>body{font-family: 'Ubuntu', sans-serif;} .row{margin-right: 10px; margin-left: 10px}</style></head><body>");
        allout=concat(allout, "<div class='disp'>");
        for(uint i=0;i<items;i++){
            if(i%4==0){
                allout=concat(allout, "<div class='row'>");
                allout=concat(allout, "<div class='col-sm-3'>");
            }
            else{
                allout=concat(allout, "<div class='col-sm-3'>");
            }
            allout=concat(allout, "<div class='card'>");
            if(keccak256(abi.encodePacked(allProducts[i].prodgrd)) == keccak256(abi.encodePacked("A"))){
                allout=concat(allout, "<img class='card-img-top' src='https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcTR1qa8tE-HE9B4f5oPxCqNYpDUzNLKIDfjD8eeVMkXs9HiL-_i' alt='Card image cap'>");
            }
            else if(keccak256(abi.encodePacked(allProducts[i].prodgrd)) == keccak256(abi.encodePacked("B"))){
                allout=concat(allout, "<img class='card-img-top' src='https://i.pinimg.com/564x/de/7b/8d/de7b8d85939b11f549c026df7a40564b--turmeric-health-turmeric-root.jpg' alt='Card image cap'>");
            }    
            else if(keccak256(abi.encodePacked(allProducts[i].prodgrd)) == keccak256(abi.encodePacked("C"))){
                allout=concat(allout, "<img class='card-img-top' src='https://5.imimg.com/data5/CC/II/MY-5308089/turmeric-mother-rhizome-2fmother-rhizome-500x500.jpg' alt='Card image cap'>");
            } 
            allout=concat(allout, "<div class='card-body'><h5 class='card-title'>");
            allout=concat(allout, uint2str(allProducts[i].productId+1));
            allout=concat(allout, ". ");
            allout=concat(allout, allProducts[i].productName);
            allout=concat(allout, "</h5><p class='card-text'>Product Grade: ");
            allout=concat(allout, allProducts[i].prodgrd);
            allout=concat(allout, "<br>Product ID: ");
            allout=concat(allout, uint2str(allProducts[i].productId));
            allout=concat(allout, "<br>Type: "); 
            allout=concat(allout, allProducts[i].prodtype);
            allout=concat(allout, "<br>Shelf life (in months): "); 
            allout=concat(allout, allProducts[i].prodlife);
            allout=concat(allout, "<br>Packaging Size (in kgs): "); 
            allout=concat(allout, allProducts[i].packsize);
            allout=concat(allout, "<br>Quantity (in kgs): "); 
            allout=concat(allout, allProducts[i].prodqnt);
            allout=concat(allout, "<br>Manufacturer Name: "); 
            allout=concat(allout, allProducts[i].manuname);
            allout=concat(allout, "<br>Manufacture date: ");
            allout=concat(allout, allProducts[i].date);
            allout=concat(allout, "<br>Availability: ");
            allout=concat(allout, allProducts[i].avail);
            allout=concat(allout, "<br>Contact: "); 
            allout=concat(allout, allProducts[i].cntno);
            allout=concat(allout, "</p></div></div></div>");
            if((i%4==0 && i!=0)|| i==items-1 ){
                allout=concat(allout, "</div>");
            }
        }
        allout=concat(allout, "</div></body>");
        return allout;
    }
    function searchProduct(uint _productId) public returns (string memory) {
        require(_productId<=items);
        string memory output="Product Name: ";
        output=concat(output, allProducts[_productId].productName);
        output=concat(output, "<br>Grade: ");
        output=concat(output, allProducts[_productId].prodgrd);
        output=concat(output, "<br>Type: ");
        output=concat(output, allProducts[_productId].prodtype);
        output=concat(output, "<br>Shelf life (in months): ");
        output=concat(output, allProducts[_productId].prodlife);
        output=concat(output, "<br>Packaging Size (in kgs): ");
        output=concat(output, allProducts[_productId].packsize);
        output=concat(output, "<br>Quantity (in kgs): ");
        output=concat(output, allProducts[_productId].prodqnt);
        output=concat(output, "<br>Manufacture Name: ");
        output=concat(output, allProducts[_productId].manuname);
        output=concat(output, "<br>Manufacture Date: ");
        output=concat(output, allProducts[_productId].date);
        
        for (uint256 j=0; j<allProducts[_productId].totalStates; j++){
            output=concat(output, allProducts[_productId].positions[j].description);
        }
        return output;
        
    }
    
}