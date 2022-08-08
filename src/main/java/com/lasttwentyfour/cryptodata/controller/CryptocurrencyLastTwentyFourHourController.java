package com.lasttwentyfour.cryptodata.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.StringTokenizer;

import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.google.gson.JsonObject;

@Controller
public class CryptocurrencyLastTwentyFourHourController {
    @RequestMapping("/getCryptodataForLastTwentyFour")
    public @ResponseBody
    JsonObject getCryptodataForLastTwentyFour(String cryptoSymbol) throws IOException {

    	JsonObject jsonObject = new JsonObject();
    	jsonObject = getCryptoDetailsForLastTwentyFour(cryptoSymbol);
        String data = jsonObject.toString().replaceAll("^\"|\"$", "");
        StringTokenizer jsonTokenizer = new StringTokenizer(data,",");
        String internalData[];
        String expectedCryptocurrencyOutput = null;        
        while (jsonTokenizer.hasMoreTokens()) {  
        	expectedCryptocurrencyOutput = jsonTokenizer.nextToken();
        	internalData = StringUtils.split(expectedCryptocurrencyOutput,":");
        	System.out.println(internalData[0]+internalData[1]);
        	if (internalData[0].substring(1,internalData[0].length()-1).equalsIgnoreCase("baseAsset")) {
        		jsonObject.addProperty("cryptosymbol",internalData[1].substring(1,internalData[1].length()-1));
        		
        	}
        	/*if (internalData[0].substring(1,internalData[0].length()-1).equalsIgnoreCase("quoteAsset")) {
        		jsonObject.addProperty("inr",internalData[1].substring(0,internalData[1].length()));
        	}*/
        	if (internalData[0].substring(1,internalData[0].length()-1).equalsIgnoreCase("openPrice")) {
        		jsonObject.addProperty("openPrice",internalData[1].substring(1,internalData[1].length()-1));
        	}
        	if (internalData[0].substring(1,internalData[0].length()-1).equalsIgnoreCase("lastPrice")) {
        		jsonObject.addProperty("lastPrice",internalData[1].substring(1,internalData[1].length()-1));
        	}
        	if (internalData[0].substring(1,internalData[0].length()-1).equalsIgnoreCase("bidPrice")) {
        		jsonObject.addProperty("bidPrice",internalData[1].substring(1,internalData[1].length()-1));
        	}
      
        }
        return jsonObject;
    }

    private JsonObject getCryptoDetailsForLastTwentyFour(String cryptoSymbol) throws IOException {
        StringBuilder responseData = new StringBuilder();
        JsonObject jsonObject = null;

        URL url = null;
        
        //url = new URL("https://api.wazirx.com/sapi/v1/tickers/24hr");
        url = new URL("https://api.wazirx.com/sapi/v1/ticker/24hr?symbol="+cryptoSymbol);

        HttpURLConnection con = (HttpURLConnection) url.openConnection();
        con.setRequestMethod("GET");
        con.setRequestProperty("User-Agent", "Mozilla/5.0");
        int responseCode = con.getResponseCode();

        System.out.println("\nSending 'GET' request to URL : " + url);
        System.out.println("Response Code : " + responseCode);

        try (BufferedReader in = new BufferedReader(
                new InputStreamReader(con.getInputStream()))) {


            String line;

            while ((line = in.readLine()) != null) {
                responseData.append(line);
            }

            jsonObject = new Gson().fromJson(responseData.toString(), JsonObject.class);
            
        }
        System.out.println(jsonObject);
        return jsonObject;
    }
}