<?php 
  session_start();
?>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>Supply Chain DAPP</title>
    <link rel="SHORTCUT ICON" href="images/fibble.png" type="image/x-icon" />
    <link rel="ICON" href="images/fibble.png" type="image/ico" />
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/mdbmin.css" rel="stylesheet">
    <link href="css/mdb.min.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
  </head>
  <?php
  if(isset($_SESSION['role'])){
  ?>
  <body>
    <?php
    include "navbar.php"
    ?>
    <center>
      <div class="customalert">
          <div class="alertcontent">
              <div id="alertText"> &nbsp </div>
              <img id="qrious">
              <div id="bottomText" style="margin-top: 10px; margin-bottom: 15px;"> &nbsp </div>
              <button id="closebutton" class="formbtn"> OK </button>
          </div>
      </div>
    </center>
    <div>
        <br><br>
          <p id="database" class="">
          </p>
        </div>
    </div>
    <div class='box'>
      <div class='wave -one'></div>
      <div class='wave -two'></div>
      <div class='wave -three'></div>
    </div>
  <?php }else{
    include 'redirection.php';
    redirect("index.php");
  } ?>
    <!-- JQuery -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>

    <script src="js/popper.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/mdb.min.js"></script>


    <script src="web3.min.js"></script>
    <script src="app.js"></script>

	<!-- QR Code Reader -->
	<script src="https://rawgit.com/sitepoint-editors/jsqrcode/master/src/qr_packed.js"></script>

    <!-- Web3 Injection -->
    <script>
      web3 = new Web3(new Web3.providers.HttpProvider('HTTP://127.0.0.1:7545'));

      // Set the Contract
      var contract = new web3.eth.Contract(contractAbi, contractAddress);
      contract.methods.displayprods().call(function(err, result){
        console.log(err, result)
        $("#database").html(result);
        if(err==null){
            $("#database").html(result);
          }
          else{
            $("#database").html("<div class='loader'></div>");
          }
      });

    </script>
  </body>
</html>
