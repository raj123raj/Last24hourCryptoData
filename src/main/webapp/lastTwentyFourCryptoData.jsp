<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Last Twenty Four Cryptocurrency Data</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
    <style type="text/css">
        .main-form, .profile-area {
            width: 500px;
        }
        .main-form {
            margin: 50px auto 0px;
        }
        .profile-area {
            margin: 10px auto;
        }
        .main-form section, .profile-area section {
            margin-bottom: 15px;
            background: #ffb891;
            box-shadow: 0px 2px 2px rgba(0, 0, 0, 0.3);
        }
        .main-form section {
            padding: 30px;
        }
        .profile-area section {
            padding: 30px 30px 30px;
        }
        .profile-area section > div {
            text-align: center;
        }
        .main-form h3 {
            margin: 0 0 15px;
        }
        .form-control, .btn {
            min-height: 38px;
            border-radius: 2px;
        }
        .btn {
            font-size: 15px;
            font-weight: bold;
            font-family: verdana;
        }
        .hideElement {
            display: none;
        }
        table, th, td {
  border: 1px solid white;
  border-collapse: collapse;
}
th, td {
  background-color: #a0e040;
}
    </style>
</head>
<body>
<div class="main-form" id="main-form">
    <section>
        <h5 class="text-center">Enter a Cryptocurrency to know about its 24 hour data </h5>
        <div class="form-group">
            <input id="symbol" type="text" class="form-control" placeholder="Enter a Cryptocurrency(btc/eth/icx/bnb etc) ..." required="required">
        </div>
        <!-- 
        <h5 class="text-center">Enter a comparison Cryptocurrency </h5>
        <div class="form-group">
            <input id="tsyms" type="text" class="form-control" placeholder="Enter a comparision Cryptocurrency ..." required="required">
        </div> -->
        <div class="form-group">
            <button onclick="loadData()" class="btn btn-primary btn-block">Fetch 24 Hours Crypto Data</button>
        </div>
    </section>
</div>
<div class="profile-area hideElement" id="profile-area">
    <section>
        <div id="loader" class="hideElement">
            <div class="spinner-border" role="status">
                <span class="sr-only">Loading...</span>
            </div>
        </div>
        <div id="profile" class="hideElement">
        <center>
            <table border = "2" col>
            <tr>
            	<th><strong><span id="cryptosymbol">   </span> Price In INR </strong></th>
            </tr>
            <tr><td><strong>OpenPrice : <span id="openPrice"></span></strong></td></tr>
            <tr><td><strong>LastPrice : <span id="lastPrice"></span></strong></td></tr>
            <tr><td><strong>BidPrice : <span id="bidPrice"></span></strong></td></tr>
            	
            </table>
            </center>
        </div>
    </section>
</div>
</body>
<script>
    function loadData() {
        document.getElementById("profile-area").classList.remove("hideElement");
        document.getElementById("loader").classList.remove("hideElement");
        document.getElementById("profile").classList.add("hideElement");
        var symbol = document.getElementById("symbol").value;
        if(symbol != "" && symbol != null) {
            var xhttp = new XMLHttpRequest();
            xhttp.onreadystatechange = function() {
                if (this.readyState == 4 && this.status == 200) {
                    var jsonResponse = JSON.parse(this.responseText);
                    document.getElementById("cryptosymbol").innerHTML = jsonResponse.cryptosymbol
                    ;
                    document.getElementById("openPrice").innerHTML = jsonResponse.openPrice;
                    document.getElementById("lastPrice").innerHTML = jsonResponse.lastPrice;
                    document.getElementById("bidPrice").innerHTML = jsonResponse.bidPrice;
                    document.getElementById("loader").classList.add("hideElement");
                    document.getElementById("profile").classList.remove("hideElement");
                }
            };
            xhttp.open("GET", "getCryptodataForLastTwentyFour?cryptoSymbol=" + symbol + "inr", true);
            
            xhttp.send();
            console.log("done");
        } else {
            console.log("Enter a cryptocurrency...")
        }
    }
</script>
</html>