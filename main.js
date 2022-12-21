const form = document.getElementById("s-form");

function ageCalculator() 
{
    event.preventDefault();
    const ffname = document.getElementById('fname').value;
    const llname = document.getElementById("lname").value;
    const ssex = document.getElementById("Sex").value;
    const dob = document.getElementById("DOB").value;
    
    
    if(ffname!="" && llname!="" && dob!="") 
    {  
        
        var dob2 = new Date(dob);
        var month_diff = Date.now() - dob2.getTime();  
        var age_dt = new Date(month_diff);   
        var year = age_dt.getUTCFullYear();  
        
        var age = Math.abs(year - 1970);  
        
        if(1)
        {   
            
            const myFormData = new FormData(form);
            
            const formDataObj = {};
            myFormData.forEach((value, key) => (formDataObj[key] = value));
            console.log(formDataObj);
            //console.log(myFormData);
        }
        else
        {
            alert("Fill up the contact details");
        }
    } 
    else 
    {  
        alert("Please Enter All the required Details");
    }  
}  

function resetFunction() 
{
    document.getElementById("s-form").reset();
}
