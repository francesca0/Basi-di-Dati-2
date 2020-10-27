<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%@ page import="gestione.Aggregation" %>
<%@ page import="gestione.GestioneDatiServlet"%>
<%@ page import="java.util.ArrayList"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Aggregazione</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta http-Equiv="Cache-Control" Content="no-cache">
        <meta http-Equiv="Pragma" Content="no-cache">
        <meta http-Equiv="Expires" Content="0">
        <script src="js/bootstrap.min.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        <script src="tableManager.js"></script>
        <script src="https://www.chartjs.org/dist/2.8.0/Chart.min.js"></script>
        <script src="https://www.chartjs.org/samples/latest/utils.js"></script>
        <link href="//maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
        <link rel="stylesheet" type="text/css" href="style.css" media="screen" />
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"> 
        
	
    </head>
<body>

<nav class="navbar navbar-dark bg-dark">
    	<div class="container-fluid">
            <a class="navbar-brand" href="grafico.jsp">MovieRecord</a> 
             <ul class="navbar-nav mr-auto">
		      <li class="nav-item active">
		        <a class="nav-link" href="aggregazione.jsp">Aggregazione</a>
		      </li>
		      </ul>             
        </div>	   
	</nav>
	<br><br>
	<h3 align="center">Cerca i tuoi film!</h3><br>
	
	
	
	<form method="post" action="GestioneDatiServlet" role="form" >
	<div class="form-group" id="campiRicercaFilm">
	  	
          <div id="checkboxesfather">
        <div class="selectBox" onclick="showCheckboxes()">
          <select class="form-control">
          <option>Seleziona genere</option>
          </select>
          <div class="overSelect" ></div>
        </div>
        <div id="checkboxes" style='padding: 15px' >
          <label for="Action">
            <input type="checkbox" name="genere" id="Action" value="Action"/>Action</label>
          <label for="Adventure">
            <input type="checkbox" name="genere" id="Adventure" value="Adventure"/>Adventure</label>
          <label for="Thriller">
            <input type="checkbox" name="genere" id="Thriller" value="Thriller" />Thriller</label>
            <label for="Sci-fi">
            <input type="checkbox" name="genere" id="Sci-fi" value="Sci-fi" />Sci-fi</label>
          <label for="Fantasy">
            <input type="checkbox" name="genere" id="Fantasy" value="Fantasy"/>Fantasy</label>
          <label for="Documentary">
            <input type="checkbox" name="genere" id="Documentary" value="Documentary"/>Documentary</label>
            <label for="Romance">
            <input type="checkbox" name="genere" id="Romance" value="Romance"/>Romance</label>
          <label for="Comedy">
            <input type="checkbox" name="genere" id="Comedy" value="Comedy"/>Comedy</label>
            <label for="Musical">
            <input type="checkbox" name="genere" id="Musical" value="Musical"/>Musical</label>
            <label for="Animation">
            <input type="checkbox" name="genere" id="Animation" value="Animation"/>Animation</label>
          <label for="Family">
            <input type="checkbox" name="genere" id="Family" value="Family"/>Family</label> 
            <label for="Mistery">
            <input type="checkbox" name="genere" id="Mistery" value="Mistery"/>Mistery</label>
          <label for="Western">
            <input type="checkbox" name="genere" id="Western" value="Western"/>Western</label>
            
          <label for="Drama">
            <input type="checkbox" name="genere" id="Drama" value="Drama" />Drama</label>
        </div>
        </div>
		
		<label for="checkboxAnno" style="margin-top: 35px; margin-left:3px; ">Scegli l'anno:</label>
		<br>  		  	
		<label for="daField" style=" margin-left:3px;">Da</label>
		<input type="number" class="form-control"  name="daField" id="daField" placeholder="1990"  >
	    <label for="aField" style="margin-top: 8px; margin-left:3px;">A</label>
		<input type="number"  class="form-control" name="aField" id="aField" placeholder="2010" >
		
		<label for="checkBoxPaese" style="margin-top: 35px; margin-left:3px">Aggrega per:</label>
		
		<div>
		  <div class="form-check">
		    <input name="gruppo1" type="radio" id="title_year" value="$title_year" checked>
		    <label for="title_year">Anno</label>
		 	<br>
		    <input name="gruppo1" type="radio" id="language" value="$language">
		    <label for="language">Lingua</label>
		<br>
		    <input name="gruppo1" type="radio" id="country" value="$country">
		    <label for="country">Paese</label>
		  </div>
		</div>
			
		<label for="checkboxNumLikes" style="margin-top: 15px; margin-left:3px">Includi il numero di likes di:</label>
		
		<br>
		<input id="checkAtt1" value="actor_1_facebook_likes" type="checkbox" name="altro" style="margin-top: 5px; margin-left:20px;" >
		<label for="checkAtt1"  style="margin-top: 5px; margin-left:3px">Attore 1</label><br>
		<input id="checkAtt2" value="actor_2_facebook_likes" type="checkbox"  name="altro" style="margin-top: 5px;margin-left:20px;"  >
		<label for="checkAtt2" style="margin-top: 5px; margin-left:3px">Attore 2 </label><br>
		<input id="checkAtt3" value="actor_3_facebook_likes" type="checkbox" name="altro" style="margin-top: 5px;margin-left:20px;"  >
		<label for="checkAtt3" style="margin-top: 5px; margin-left:3px">Attore 3</label><br>
		<input id="checkReg" value="director_facebook_likes" type="checkbox" name="altro" style="margin-top: 5px;margin-left:20px;"  >
		<label for="checkReg" style="margin-top: 5px; margin-left:3px">Regista</label><br>
		
		<input id="checkBudget" value="budget" type="checkbox" name="altro" style="margin-top: 15px;" >
		<label for="checkBudget" style="margin-top: 15px; margin-left:3px">Includi il budget</label><br>
		
		<input id="checkIncasso" value="gross" type="checkbox" name="altro" style="margin-top: 15px;" >
		<label for="checkIncasso" style="margin-top: 15px; margin-left:3px">Includi l'incasso</label><br>
		
		<label style="margin-top: 15px;">Scegli l'operazione da effettuare</label>
	  	<select name="operazione" id="operazione" class="form-control" >
			<option value="Somma">Somma</option>
			<option value="Media">Media</option>
			<option value="Minimo">Minimo</option>
			<option value="Massimo">Massimo</option>		
		</select> 
		
		
		
		<div id="soloBottone"  align="center" style="margin:35px;">
				<button type="submit" id="aggregaButton" value="Aggrega" class="btn btn-primary">Aggrega</button>
		 </div>
		<br>
	
	</div>
	
</form>

 <%! @SuppressWarnings("unchecked") %>				  
				  <%
				  
				  ArrayList<String> stringa = new ArrayList<String>(); 
				  
				  if(request.getAttribute("tabella") == null){
					  
					  stringa.add("");
					  stringa.add("");
					  					  
				  }else{
					  stringa =(ArrayList<String>) request.getAttribute("tabella");
				  }
				  
				  %>
				  
				  

<table id="tableFilms" class="table table-striped table-bordered"> 
  <thead class="thead-dark" id="tabella">
  	<%= stringa.get(0) %>
  </thead>
  <tbody>
  	<%= stringa.get(1) %>
  </tbody>
</table>
<br><br>

</body>
</html>