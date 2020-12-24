({
    handleSearch : function(component, event, helper) {
        component.set('v.isOpenTable', true);
        var action = component.get('c.getPostOfficesByCode');
        action.setParams({
            'pinCode' : component.get('v.pincode') 
        });
        
        action.setCallback(this, function(response){
            if(response.getState()=='SUCCESS'){
                component.set('v.postOfficeData', response.getReturnValue());
                var items = response.getReturnValue();
                component.set('v.size', items.length);
            }
            else if(response.getState()=='ERROR'){
                component.set('v.size',0);
                component.set('v.postOfficeData', []);
            }
        });
        
        $A.enqueueAction(action);
    }
})
