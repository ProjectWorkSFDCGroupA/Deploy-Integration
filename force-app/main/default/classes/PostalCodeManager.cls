public class PostalCodeManager {
    
    @AuraEnabled
    public static List<PostOfficeDetails> getPostOfficesByCode(Integer pinCode){
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        
        request.setEndpoint('https://api.postalpincode.in/pincode/'+pinCode);
        request.setMethod('GET');
        
        HttpResponse response = http.send(request);
        
        List<Object> responseBody = (List<Object>)JSON.deserializeUntyped(response.getBody());
        
        Map<String,Object> detailMap = (Map<String,Object>)responseBody.get(0);
        
        List<Object> postOfficeList = (List<Object>)detailMap.get('PostOffice');
        List<PostOfficeDetails> postOffices = new List<PostOfficeDetails>();
        
        for(Object obj: postOfficeList){
            Map<String, Object> innerMap = (Map<String,Object>) obj;
            PostOfficeDetails pod = new PostOfficeDetails();
            pod.postOfficeName = (String)innerMap.get('Name');
            pod.branchType = (String)innerMap.get('BranchType');
            pod.block = (String)innerMap.get('Block');
            postOffices.add(pod);
        }
        
        return postOffices;
    }
}