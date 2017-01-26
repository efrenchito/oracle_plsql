--DROP DATABASE LINK DBLINK_TST140_TST110.GRUPOMUN.COM;

CREATE DATABASE LINK DBLINK_TST110 
CONNECT TO apps IDENTIFIED BY JI6oLmgX6sQW USING '(DESCRIPTION= 
   (ADDRESS=(PROTOCOL=tcp)(HOST=hc01db01.grupomun.com)(PORT=1546))
  (CONNECT_DATA=
   (SERVICE_NAME=TST110)
   (INSTANCE_NAME=TST110)
  )
 )';

SELECT *
FROM   DBA_OBJECTS O
WHERE  1 = 1
AND    O.OBJECT_TYPE LIKE '%LINK%'
AND    o.OBJECT_NAME LIKE 'DBLINK_TST140_TST110%'
;

--ELEMENT_TYPES
SELECT element_type_id
      ,TO_DATE('01/01/1950', 'DD/MM/YYYY') AS effective_start_date          
      ,TO_DATE('31/12/4712', 'DD/MM/YYYY') AS effective_end_date
      ,business_group_id             
      ,legislation_code              
      ,formula_id                    
      ,'VEF' input_currency_code           
      ,'COP' output_currency_code          
      ,classification_id             
      ,benefit_classification_id     
      ,additional_entry_allowed_flag 
      ,adjustment_only_flag          
      ,closed_for_entry_flag         
      ,element_name                  
      ,reporting_name                
      ,description                   
      ,indirect_only_flag            
      ,multiple_entries_allowed_flag 
      ,multiply_value_flag           
      ,post_termination_rule         
      ,process_in_run_flag           
      ,processing_priority           
      ,processing_type               
      ,standard_link_flag            
      ,comment_id                    
      ,legislation_subgroup          
      ,qualifying_age                
      ,qualifying_length_of_service  
      ,qualifying_units              
      ,attribute_category            
      ,attribute1                    
      ,attribute2                    
      ,attribute3                    
      ,attribute4                    
      ,attribute5                    
      ,attribute6                    
      ,attribute7                    
      ,attribute8                    
      ,attribute9                    
      ,attribute10                   
      ,attribute11                   
      ,attribute12                   
      ,attribute13                   
      ,attribute14                   
      ,attribute15                   
      ,attribute16                   
      ,attribute17                   
      ,attribute18                   
      ,attribute19                   
      ,attribute20                   
      ,SYSDATE AS last_update_date              
      ,last_updated_by               
      ,last_update_login             
      ,created_by                    
      ,SYSDATE creation_date                 
      ,element_information_category  
      ,element_information1          
      ,element_information2          
      ,element_information3          
      ,element_information4          
      ,element_information5          
      ,element_information6          
      ,element_information7          
      ,element_information8          
      ,element_information9          
      ,element_information10         
      ,element_information11         
      ,element_information12         
      ,element_information13         
      ,element_information14         
      ,element_information15         
      ,element_information16         
      ,element_information17         
      ,element_information18         
      ,element_information19         
      ,element_information20         
      ,third_party_pay_only_flag     
      ,object_version_number         
      ,iterative_flag                
      ,iterative_formula_id          
      ,iterative_priority            
      ,creator_type                  
      ,retro_summ_ele_id             
      ,grossup_flag                  
      ,process_mode                  
      ,advance_indicator             
      ,advance_payable               
      ,advance_deduction             
      ,process_advance_entry         
      ,proration_group_id            
      ,proration_formula_id          
      ,recalc_event_group_id         
      ,once_each_period_flag         
      ,time_definition_type          
      ,time_definition_id            
      ,advance_element_type_id       
      ,deduction_element_type_id     
      ,null AS comments                      
      ,NULL AS default_uom                   
      ,NULL AS lenguage_code                 
      ,NULL AS processing_priority_warning   
      ,NULL AS batch_id                      
      ,NULL AS process_flag                  
      ,NULL AS effective_date                
      ,NULL AS ERROR   
FROM   pay_element_types_f@DBLINK_TST140_TST110.GRUPOMUN.COM pet
WHERE  1 = 1
AND    pet.element_Name LIKE 'VE%'
;

--ELEMENT_TYPE_RULES
SELECT petr.*
FROM   pay_element_type_rules@DBLINK_TST140_TST110.GRUPOMUN.COM petr
      ,pay_element_types_f@DBLINK_TST140_TST110.GRUPOMUN.COM pet
WHERE  1 = 1
AND    petr.element_type_id = pet.element_type_id
AND    pet.element_Name LIKE 'VE%'
;

--ELEMENT_CLASSIFICATIONS
SELECT *
FROM   pay_element_classifications @DBLINK_TST140_TST110.GRUPOMUN.COM pec
WHERE  1 = 1
AND    pec.legislation_code = 'VE'
;

--ELEMENT_SETS
SELECT element_set_id   
      ,business_group_id
      ,legislation_code 
      ,element_set_name 
      ,element_set_type 
      ,comments         
      ,NULL AS batch_id         
      ,NULL AS process_flag     
      ,NULL AS ERROR
FROM   pay_element_sets@DBLINK_TST140_TST110.GRUPOMUN.COM pes
WHERE  1 = 1
AND    pes.element_set_name LIKE 'VE%'
;


--
SELECT *
FROM   pay_input_values_f@DBLINK_TST140_TST110.GRUPOMUN.COM piv
      ,pay_element_types_f@DBLINK_TST140_TST110.GRUPOMUN.COM pet
WHERE  1 = 1
AND    piv.element_type_id  = pet.element_type_id
AND    pet.element_Name LIKE 'VE%'
;
