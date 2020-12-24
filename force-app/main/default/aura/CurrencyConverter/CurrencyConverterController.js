({
    loadOptions: function (component, event, helper) {
        var opts = [
            { value: "GBP", label: "GBR" },
            { value: "INR", label: "INR" },
            { value: "EUR", label: "EUR" },
            { value: "SCR", label: "SCR" },
            { value: "PKR", label: "PKR" }
        ];
        component.set("v.options", opts);
    },
    
    getConvertedValue: function(component, event, helper) {
        
        var action = component.get('c.getExchangeRate');
        
        action.setParams({
            'toCurrency' : component.get('v.selectedValue')
        });
        
        action.setCallback(this, function(response){
           
            if(response.getState()=='SUCCESS'){
                component.set('v.isOpenConverter',true);
                component.set('v.currency', response.getReturnValue());
                console.log(response.getReturnValue());
            }
        });
        
        $A.enqueueAction(action);
    }
})