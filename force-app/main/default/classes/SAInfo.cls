public with sharing class SAInfo {
@AuraEnabled(cacheable=true) 
public static List<SA_Detail__c> getSAInfo(){
return [SELECT Id, Name__c, Customer_Handled__c, Experience__c, 
Date_of_Joining__c, Location__latitude__s, Location__longitude__s,
Specilization__c, Location__c FROM SA_Detail__c with SECURITY_ENFORCED
ORDER BY NAME__c LIMIT 20];
}
@AuraEnabled(cacheable=true) 
public static List<SA_Detail__c> getSASearch(String filter){
filter=filter.trim();
if(filter==''){
return getSAInfo();
}
String keyNameString='%'+filter+'%';    
return [SELECT Id, Name__c, Customer_Handled__c, Experience__c, 
Date_of_Joining__c, Location__latitude__s, Location__longitude__s,
Specilization__c  FROM SA_Detail__c 
WHERE Name__c LIKE :keyNameString with SECURITY_ENFORCED
ORDER BY NAME__c LIMIT 20];
}
}