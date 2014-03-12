var tabindex = 19;

function aggiungiIng(){
		var fI;
		var i=0;
		while(fI = document.getElementById("insIng"+i)){
				i++;
		}
		i--;
		var div = document.getElementById("insIng"+i);
		var ingr = "ingrediente"+i;
		var quant = "quantita"+i;
		var unit = "unita"+i;
		div.innerHTML +="<label for=\""+ingr+"\">Ingrediente "+(i+1)+": </label>"+
				"<input type=\"text\" name=\""+ingr+"\" id=\""+ingr+"\" class=\"ingrediente\" size=\"20\" tabindex=\""+(tabindex++)+"\" />"+
				"<label for=\""+quant+"\"> Quantità: </label>"+
				"<input type=\"text\" name=\""+quant+"\" id=\""+quant+"\" size=\"5\" tabindex=\""+(tabindex++)+"\"/>"+
				"<label for=\""+unit+"\"> Unità di misura: </label>"+
				"<select name=\""+unit+"\" id=\""+unit+"\" tabindex=\""+(tabindex++)+"\">"+
						"<option value=\"Non specificata\">Non specificata</option>"+
						"<option value=\"g\">g</option>"+
						"<option value=\"hg\">hg</option>"+
						"<option value=\"kg\">kg</option>"+
						"<option value=\"ml\">ml</option>"+
						"<option value=\"dl\">dl</option>"+
						"<option value=\"l\">l</option>"+
						"<option value=\"Cucchiaio\">Cucchiaio</option>"+
						"<option value=\"Cucchiaino\">Cucchiaino</option>"+
						"<option value=\"Tazzina\">Tazzina</option>"+
				"</select></div><div id='insIng"+(i+1)+"'>";
		return false;
}
                
			
function controllaDati() {
		var err=false;
		var check=true;
		var elem = document.getElementById("nomeRicetta");
		if(elem.value.length == 0) {
				document.getElementById("nomeRicettaErr").innerHTML= "Inserisci il titolo";
				err=true;
				check=false;
		} else {
				document.getElementById("nomeRicettaErr").innerHTML= "";
		}
		elem = document.getElementById("nomeAutore");
		if( elem.value.length==0 ) {
				document.getElementById("nomeAutoreErr").innerHTML= "Inserisci il nome dell'autore";
				err=true;
				check=false;
		} else {
				document.getElementById("nomeAutoreErr").innerHTML= "";
		}
		elem = document.getElementById("areaProcedimento");
		if( elem.value.length==0 ) {
				document.getElementById("areaProcedimentoErr").innerHTML= "Inserisci il procedimento";
				err=true;
				check=false;
		} else {
				document.getElementById("areaProcedimentoErr").innerHTML= "";
		}
		elem = document.getElementById("ingrediente0");
		if( elem.value.length==0 ) {
				document.getElementById("ingrediente0Err").innerHTML= "Inserisci almeno il primo ingrediente";
				err=true;
				check=false;
		} else {
				document.getElementById("ingrediente0Err").innerHTML= "";
		}
		elem = document.getElementById("usernameL");
		if( elem.value.length==0 ) {
				document.getElementById("UsernameErrLogin").innerHTML= "Inserisci Username";
				err=true;
				check=false;
		} else {
				document.getElementById("UsernameErrLogin").innerHTML= "";
		}
		elem = document.getElementById("passwordL");
		if( elem.value.length==0 ) {
				document.getElementById("PasswordErrLogin").innerHTML= "Inserisci password";
				err=true;
				check=false;
		} else {
				document.getElementById("PasswordErrLogin").innerHTML= "";
		}
		elem = document.getElementById("username");
		if( elem.value.length==0 ) {
				document.getElementById("UsernameErr").innerHTML= "Username obbligatorio";
				err=true;
				check=false;
		} else {
				document.getElementById("UsernameErr").innerHTML= "";
		}
		elem = document.getElementById("password");
		if( elem.value.length==0 ) {
				document.getElementById("PasswordErr").innerHTML= "Inserisci password";
				err=true;
				check=false;
		} else {
				document.getElementById("PasswordErr").innerHTML= "";
		}
		elem = document.getElementById("nome");
		if( elem.value.length==0 ) {
				document.getElementById("NomeErr").innerHTML= "Inserisci il nome";
				err=true;
				check=false;
		} else {
				document.getElementById("NomeErr").innerHTML= "";
		}
		elem = document.getElementById("cognome");
		if( elem.value.length==0 ) {
				document.getElementById("CognomeErr").innerHTML= "Inserisci il cognome";
				err=true;
				check=false;
		} else {
				document.getElementById("CognomeErr").innerHTML= "";
		}
		elem = document.getElementById("anno");
		if( elem.value.length==0 ) {
				document.getElementById("AnnoErr").innerHTML= "Inserisci l'anno";
				err=true;
				check=false;
		} else {
				document.getElementById("AnnoErr").innerHTML= "";
		}
		return !err;
		if check==true {
			inserimento.pl
		}
}
