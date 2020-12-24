public class ExchangeRateController {
    
	@AuraEnabled   
    public static CurrencyType getExchangeRate(String toCurrency){
        String endPoint = 'https://api.currencyfreaks.com/latest';
    	String apiKey;
        CurrencyApi__c currencyApi = CurrencyApi__c.getValues('Key');
        apiKey = currencyApi.ApiKey__c;
        Http hp = new Http();
        HttpRequest request = new HttpRequest();
        endPoint = endPoint + '?apikey='+apiKey+'&symbols='+toCurrency;
        request.setEndpoint(endpoint);
        request.setMethod('GET');
        
        HttpResponse response = hp.send(request);
        CurrencyType currencyObj = new CurrencyType();
        Map<String,Object> bodyMap = (Map<String,Object>)JSON.deserializeUntyped(response.getBody());
        currencyObj.cDate = (String)bodyMap.get('date');
        Map<String,Object> rateMap = (Map<String,Object>)bodyMap.get('rates');
        currencyObj.rate = (String)rateMap.get(toCurrency);
        
        return currencyObj;
    }
}