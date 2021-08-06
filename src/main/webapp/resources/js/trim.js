function trim(str){
	//alert("str1.length: " + str.length);
	
	while(str && str.indexOf(" ") == 0)
		str = str.substring(1); 
	while(str && str.lastIndexOf(" ") == str.length-1)
		str = str.substring(0, str.length-1); 
	
	//alert("str2.length: " + str.length);
	
	return str;
}