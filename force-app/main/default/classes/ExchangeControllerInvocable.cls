public class ExchangeControllerInvocable {
    
    @InvocableMethod   
    public static void getExchangeRate(List<Opportunity> oppList){
        
        if(!System.isFuture()){
            ExchangeControllerCallout.apexCallout(oppList[0].Id);
        }
    }
}