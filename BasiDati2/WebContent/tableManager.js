var expanded = false;

function showCheckboxes() {
  var checkboxes = document.getElementById("checkboxes");
  if (!expanded) {
    checkboxes.style.display = "block";
    expanded = true;
  } else {
    checkboxes.style.display = "none";
    expanded = false;
  }
}

$(document).ready(function () {

	//Se si vuole che si apra in automatico
	/*
	  $("#test42").mouseenter(function(){
		  var checkboxes = document.getElementById("checkboxes");
		  checkboxes.style.display = "block";
		  expanded = true;
	  });
	  */

	  $("#checkboxes, #checkboxesfather").mouseleave(function(){
		  var checkboxes = document.getElementById("checkboxes");
		  checkboxes.style.display = "none";
		  expanded = false;
	  });
	});

function hideChekboxes(){
	var checkboxes = document.getElementById("checkboxes");
	checkboxes.style.display = "none";
    expanded = false;
}

function valoreSelectFunction(){
	var idSelectTabella = document.getElementById("tableFilms_length");
	var valoreSelect = idSelectTabella.options[idSelectTabella.selectedIndex].value;
	
	return valoreSelect;
	
}

function resizeTable(){
	
	acc = document.getElementById("tableFilms");
	clearTable(acc);
	
	var lista=JSON.parse(sessionStorage.getItem('list'));
	var numeroRigheDaGenerare = valoreSelectFunction();
	
	console.log("questa lista "+lista.Film);
	
	if(lista!=undefined && lista.Film.length>0)
        for (var i=0; i<numeroRigheDaGenerare; i++) {

            titolo = lista.Film[i].titolo;
            anno = lista.Film[i].anno;
            genere = lista.Film[i].genere;
            cast = lista.Film[i].cast;
            
            acc.innerHTML = acc.innerHTML +
                "<tr>" +
                "<td>" + titolo + "</td>" +
                "<td>" + anno + "</td>" +
                "<td>" + genere + "</td>" +
                "<td>" + cast + "</td>" +
                "</tr>";
        }
	
}


function generateTable(list){
				  		
				  		acc = document.getElementById("tableFilms");
				  		sessionStorage.setItem('list',JSON.stringify(list));
				  		
				  		clearTable(acc);
						if(list!=undefined && list.Film.length>0)
		                for (i in list.Film) {

		                    titolo = list.Film[i].titolo;
		                    anno = list.Film[i].anno;
		                    genere = list.Film[i].genere;
		                    cast = list.Film[i].cast;
		                    
		                    acc.innerHTML = acc.innerHTML +
		                        "<tr>" +
		                        "<td>" + titolo + "</td>" +
		                        "<td>" + anno + "</td>" +
		                        "<td>" + genere + "</td>" +
		                        "<td>" + cast + "</td>" +
		                        "</tr>";
		                }
				  					  		
}

function clearTable(acc){
	var rows = acc.getElementsByTagName("tr");
	//Cancellazione tabella dal basso verso l'alto
    for(i=rows.length-1;i>0;i--){
        acc.deleteRow(i);
    }
}

/*function isChecked(){
	 /*var genere = document.getElementById("checkboxGenere");
	  if (genere.checked) {
		  document.getElementById("genereScelto").disabled = false;
	  } else {
		  document.getElementById("genereScelto").disabled = true;
	  }
	  
	  var checkboxAnno = document.getElementById("checkboxAnno");
	  if (checkboxAnno.checked) {
		  document.getElementById("daField").disabled = false;
		  document.getElementById("aField").disabled = false;
	  } else {
		  document.getElementById("daField").disabled = true;
		  document.getElementById("aField").disabled = true;
	  }
	  
	  var checkBoxPaese = document.getElementById("checkBoxPaese");
	  if (checkBoxPaese.checked) {
		  checkBoxPaese = true;
	  } else {
		  checkboxPaese = false;
	  }
	  
	  var checkboxNumLikes = document.getElementById("checkboxNumLikes");
	  console.log(checkboxNumLikes);
	  if (checkboxNumLikes.checked) {
		  document.getElementById("checkAtt1").disabled = false;
		  document.getElementById("checkAtt2").disabled = false;
		  document.getElementById("checkAtt3").disabled = false;
		  document.getElementById("checkReg").disabled = false;
		  
	  } else {
		  document.getElementById("checkAtt1").disabled = true;
		  document.getElementById("checkAtt2").disabled = true;
		  document.getElementById("checkAtt3").disabled = true;
		  document.getElementById("checkReg").disabled = true;
	  }
	  
	  var checkBudget = document.getElementById("checkBudget");
	  if (checkBudget.checked) {
		  checkBudget = true;
	  } else {
		  checkBudget = false;
	  }
	  
	  var checkIncasso = document.getElementById("checkIncasso");
	  if (checkIncasso.checked) {
		  checkIncasso = true;
	  } else {
		  checkIncasso = false;
	  }
	  
	  
}*/
				 