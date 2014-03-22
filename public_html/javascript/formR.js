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
		elem = document.getElementById("quantita0");
		if( isNaN(elem.value) || parseInt(elem.value)<0 || parseInt(elem.value) > 9999) {
				document.getElementById("ingrediente0Err").innerHTML= "La quantità deve essere numerica";
				err=true;
				check=false;
		} else {
				document.getElementById("ingrediente0Err").innerHTML= "";
		}
		if (check==false) {
			return !err;
		}
		
}
