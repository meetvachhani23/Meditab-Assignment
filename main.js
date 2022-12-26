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

// address box
// address box add
function addAddressField() {
    // alert('seen');
    addressHTML = `	<div class="fcolumn address">
    <fieldset class="field-column">
        <legend class="leg-column" >
            <select name="" id="" class="select-option">
                <option value="">Home</option>
                <option value="">Work</option>
                <option value="">Other</option>
            </select>
        </legend>
        <div class="contact-container">
            <div  style="justify-content: space-between; margin-bottom: 0.5rem;">
                <div>
                    <span style="color: black; font-size: 0.9rem; font-weight: 600; padding: 0.4%;">Address</span>
                    <a href="#index" style="float: right;"><i class="fa-solid fa-trash-can" onclick="removeAddressField(this)"></i></a>
                </div>
            </div>
            <div class="street-field" style="width: 66%; margin: 1.25% 0%">
                <div style="margin: 0.5rem;">
                    <label for="Street">Street</label>
                </div>
                <div>
                    <input type="text" class="text-box-in" id="Street" name="Street" placeholder="221 N Shaw Ave" value="221 N Shaw Ave">
                </div>
            </div>
            <div>
                <div class="zip-row2" >
                    <div class="zip-rowcolumn" style="margin: 0.5rem;">
                        <div >
                            <label for="Zip">Zip</label>
                        </div>
                        <div>
                            <input type="text" class="text-box-in" style="margin: 0%;" id="Zip" name="Zip" placeholder="93727" value="93727">
                        </div>
                    </div>
                    <div class="zip-rowcolumn" style="margin: 0.5rem;">
                        <div>
                            <label for="City">City</label>
                        </div>
                        <div>
                            <input type="text" class="text-box-in" style="margin: 0%;" id="City" name="City" placeholder="">
                        </div>
                    </div>
                    <div class="zip-rowcolumn" style="margin: 0.5rem;">
                        <div>
                            <label for="State">State</label>
                        </div>
                        <div>
                            <select name="State" id="State" class="text-box-dropdown" style="margin: 0%;">
                                <option value="CALIFORNIA">CALIFORNIA</option>
                                <option value="Washington">Washington</option>
                                <option value="CALIFORNIA">CALIFORNIA</option>
                            </select>
                        </div>
                    </div>
                    <div class="zip-rowcolumn" style="margin: 0.5rem;">
                        <div>
                            <label for="Country" >Country</label>
                        </div>
                        <div>
                            <select name="Country" id="Country" class="text-box-dropdown" style="margin: 0%;">
                                <option value="US">US</option>
                                <option value="INDIA">INDIA</option>
                            </select>
                        </div>
                    </div>
                    <div class="zip-rowcolumn" style="margin: 0.5rem; width:5%">
                        <a href="#index" style="float: right;"><i class="fa-solid fa-trash-can"></i></a>
                    </div>
                </div>
                <div  >
                    <div >
                        <div style="margin: 0.5rem;">
                            <div>Phone<a href="#index"><i class="fa-solid fa-circle-plus"></i></a></div>
                        </div>
                    </div>
                    <div class="phone-row3">
                        <div class="phone-rows1" style="margin: 0.25rem 0.5rem 0.25rem 0.5rem;">
                            <div style="width: 10%;">
                                <label for="Type">Type</label>
                            </div>
                            <div style="width: 13%; margin:0% 1.25%;">
                                <label for="Code">Code</label>
                            </div>
                            <div style="width: 30%; margin:0% 1.25%;"> 
                                <label for="Number">Number</label>
                            </div>
                            <div style="width: 20%; margin:0% 1.25%;">
                                <label for="Ext.">Ext.</label>
                            </div>
                        </div>
                        <div class="phone-rows2" style="margin-left: 0.5rem;">
                            <div style="width: 10%;">
                                <select name="Type" id="Type" class="text-box-dropdown">
                                    <option value="Cell">Cell</option>
                                    <option value="Landline">Landline</option>
                                </select>
                            </div>
                            <div style="width: 13%; margin:0% 1.25%;">
                                <select name="Code" id="Code" class="text-box-dropdown">
                                    <option value="CALIFORNIA">+91 India</option>
                                    <option value="Washington">+1 United States</option>
                                    <option value="CALIFORNIA">+213 Algeria</option>
                                </select>
                            </div>
                            <div style="width: 32%; margin:0%;">
                                <input type="text" id="Number" class="text-box-in" name="Number" placeholder="(707) 322-1076" value="(707) 322-1076">
                            </div>
                            <div style="width: 20%; margin:0% 1.25%;">
                            </div>
                            <div style="width: 10%; margin:0% 1.25%;">
                                <a href="#index" style="float: right;"><i class="fa-solid fa-trash-can"></i></a>
                            </div>
                        </div>
                    </div>
                </div>
                <div >
                    <div>
                        <div style="margin: 0.5rem;">
                            <div>Fax<a href="#index"><i class="fa-solid fa-circle-plus"></i></a></div>
                        </div>
                    </div>
                    <div class="fax-row4">
                        <div class="fax-rows1" style="margin: 0.25rem 0.5rem 0.25rem 0.5rem;">
                            <div style="width: 10%;">
                                <label for="Code">Code</label>
                            </div>
                            <div style="width: 30%; margin:0% 1.25%;">
                                <label for="Number">Number</label>
                            </div>
                        </div>
                        <div class="fax-rows2" style="margin-left: 0.5rem;">
                            <div style="width: 10%;">
                                <input type="text" class="text-box-in" id="Code" name="Code" placeholder="+91" value="+91">
                            </div>
                            <div style="width: 30%;">
                                <input type="text" class="text-box-in" id="Number" name="Number" placeholder="(971) 222-9147" value="(971) 222-9147">
                            </div>
                            <div style="width: 30%; margin:0% 2.5%;">
                                <a href="#index"  style="float: right;"><i class="fa-solid fa-trash-can"></i></a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="emailSection" >
                <div>
                    <div style="margin: 0.5rem;">
                        <div>Email<a href="#index"><i class="fa-solid fa-circle-plus" onclick="addEmailField(this)"></i></a></div>
                    </div>
                </div>
                <div class="multiEmail" id="multiEmail" >
                    <div class="singleEmail">
                        <div class="email-rowcolumn">
                            <input type="email" id="email" class="text-box-in" name="email" value="ashishj@meditab.com">
                        </div>
                        <div style="margin: 0.5rem;">
                            <a href="#index"><i class="fa-solid fa-trash-can" onclick="removeEmailField(this)"></i></a>
                        </div>
                    </div>
                </div>  
            </div>
            <div class="websiteSection">
                <div style="margin: 0.5rem;">
                    <div>Website<a href="#index"><i class="fa-solid fa-circle-plus" onclick="addWebsiteField(this)"></i></a></div>
                </div>
                <!--// <div style="margin: 0.5rem;">
                   // <a href="#index"><i class="fa-solid fa-trash-can"></i></a>
               // </div> -->
                <div class="multiWebsite" id="multiWebsite">
                    <!-- <div class="singleWebsite">
                        <div class="website-rowcolumn" name="Website" style="margin-left: 0.5rem;">
                            <input type="website" id="website" class="text-box-in" name="website" value="">
                        </div>
                        <div style="margin: 0.5rem;">
                            <a href="#index"><i class="fa-solid fa-trash-can" onclick="removeWebsiteField(this)"></i></a>
                        </div>
                    </div> -->
                </div>
            </div>
        </div>
    </fieldset>
</div>
`
    document.getElementById("multiaddress").innerHTML += addressHTML
}

// address box remove
function removeAddressField(btn) {
    btn.closest('.address').remove();
}

// Email part 
// Email part add
function addEmailField(add) {
    emailHTML = `<div class="singleEmail">
    <div class="email-rowcolumn" style="margin-left: 0.5rem;">
        <input type="email" id="email" class="text-box-in" name="email" value="ashishj@meditab.com">
    </div>
    <div style="margin: 0.5rem;">
        <a href="#index"><i class="fa-solid fa-trash-can" onclick="removeEmailField(this)"></i></a>
    </div>
</div>`
    // document.getElementById("multiEmail").innerHTML += emailHTML;
    add.closest('.emailSection').querySelector('.multiEmail').innerHTML += emailHTML;
}
// Email part remove
function removeEmailField(btn) {
    btn.closest('.multiEmail').querySelector('.singleEmail').remove();
}

// Website part 
// Website part add
function addWebsiteField(add) {
    websiteHTML = `<div class="singleWebsite">
    <div class="website-rowcolumn" name="Website" style="margin-left: 0.5rem;">
        <input type="website" id="website" class="text-box-in" name="website" value="">
    </div>
    <div style="margin: 0.5rem;">
        <a href="#index"><i class="fa-solid fa-trash-can" onclick="removeWebsiteField(this)"></i></a>
    </div>
</div>`
    // document.getElementById("multiWebsite").innerHTML += websiteHTML;
    add.closest('.websiteSection').querySelector('.multiWebsite').innerHTML += websiteHTML;
}

// Website part remove
function removeWebsiteField(btn) {
    btn.closest('.multiWebsite').querySelector('.singleWebsite').remove();
}