public class ExchangeControllerCallout {
	
    @future(callout=true)
    public static void apexCallout(Id oppId){
        
        String endPoint = 'https://api.currencyfreaks.com/latest';
    	String apiKey;
        CurrencyApi__c currencyApi = CurrencyApi__c.getValues('Key');
        apiKey = currencyApi.ApiKey__c;
        Http hp = new Http();
        HttpRequest request = new HttpRequest();
        endPoint = endPoint + '?apikey='+apiKey+'&symbols=INR';
        request.setEndpoint(endpoint);
        request.setMethod('GET');        
        HttpResponse response = hp.send(request);
        Map<String,Object> bodyMap = (Map<String,Object>)JSON.deserializeUntyped(response.getBody());
        Map<String,Object> rateMap = (Map<String,Object>)bodyMap.get('rates');
        Decimal rate = Decimal.valueOf((String)rateMap.get('INR'));
        //System.debug(rate);
        
        Opportunity opp = [SELECT Amount, INR_Value__c from Opportunity where id= :oppId];
        
        opp.INR_Value__c = opp.Amount * rate;
        
        update opp;

    }    
}