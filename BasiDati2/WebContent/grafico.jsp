<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
     <%@ page import ="gestione.GestioneGrafico" %>
     <%@ page import ="gestione.ChartCreation" %>
     <%@ page import ="gestione.ChartItem" %>
     <%@ page import="java.util.ArrayList"%>
    <%ArrayList<ChartItem> chart = new ArrayList<ChartItem>(); %> 			 
    
<!DOCTYPE html>

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
        
        <style>
	canvas {
		-moz-user-select: none;
		-webkit-user-select: none;
		-ms-user-select: none;
	}
	</style>
	
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
	
	
	
	<form method="post" action="GestioneGrafico" role="form" >
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
        <br>
           		  	
		<label for="daField" style=" margin-left:3px;">Anno partenza</label>
		<input type="number" class="form-control"  name="daField" id="daField" placeholder="1990">
		
		
		<label style="margin-top: 15px;">Granularità anno</label>
			<select name="range" class="form-control">
				<option>1</option>
				<option>3</option>
				<option>5</option>
			</select>
			
			<label style="margin-top: 15px;">Scegli valore sull'asse x</label>
			<select name="axis" class="form-control">
				<option>Incasso</option>
				<option>Budget</option>
			</select>
				
		<label for="checkBoxPaese" style="margin-top: 35px; margin-left:3px">Aggrega per</label>
		
		<div>
		  <div class="form-check">
		    <input name="gruppo1" type="radio" id="genres" value="$content_rating" checked>
		    <label for="genres">Classificazione Film</label>
		 	<br>
		    <input name="gruppo1" type="radio" id="language" value="$language">
		    <label for="language">Lingua</label>
	    	<br>
		    <input name="gruppo1" type="radio" id="country" value="$country">
		    <label for="country">Paese</label>
		  </div>
		</div>
			
		
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
			String json="{array:[";
			String[] labelsMy = {};
			String labelMyFormatted="[";
			if(request.getAttribute("arrayListChartItem")!=null){
				
				chart = (ArrayList<ChartItem>) request.getAttribute("arrayListChartItem");
				
				for(int i=0;i<chart.size();i++)
					json+=chart.get(i).toJSOBJ()+",";
				
				labelsMy = (String[]) request.getAttribute("filterVector");
				for(int i=0;i<labelsMy.length;i++)
					labelMyFormatted+="\'"+labelsMy[i]+"\',";
			}else{
				chart=null;
			}
			json+="]}";
			labelMyFormatted+="]";
				  %>
				  			  
				  <div id="container" style="width: 75%;">
		<canvas id="canvas"></canvas>
	</div>
	
	
	<script>
	
	
	var dati=<%=json %>;
	var labels = <%=labelMyFormatted %>;
	
	var color = Chart.helpers.color;
		
		//grafico
		
		var barChartData = {
			labels,
			datasets: [
				/*{
				label: 'Dataset 1',
				backgroundColor: color(window.chartColors.red).alpha(0.5).rgbString(),
				borderColor: window.chartColors.red,
				borderWidth: 1,
				data: [
					1000,
					20,
					randomScalingFactor(),
					randomScalingFactor(),
					randomScalingFactor(),
					randomScalingFactor(),
					randomScalingFactor()
				]
			}*/
			]

		};

		window.onload = function() {
			var ctx = document.getElementById('canvas').getContext('2d');
			window.myBar = new Chart(ctx, {
				type: 'bar',
				data: barChartData,
				options: {
					responsive: true,
					legend: {
						position: 'right',
					},
					title: {
						display: false,
						text: 'Basi di dati2 '
					}
				}
			});

		};

		
		
		var colorNames = Object.keys(window.chartColors);
		
		for(var x=0;x<dati.array.length;x++){
			console.log("var "+dati.array[x]["range"]);
		
		//aggiunge e sceglie il colore del prossimo dataset
		
			var colorName = colorNames[barChartData.datasets.length % colorNames.length];
			var dsColor = window.chartColors[colorName];
			var newDataset = {
				label: dati.array[x]["range"],
				backgroundColor: color(dsColor).alpha(0.5).rgbString(),
				borderColor: dsColor,
				borderWidth: 1,
				data: []
			};

			for (var index = 0; index < dati.array[x]["value"].length; index++) {
				newDataset.data.push(dati.array[x]["value"][index]);
			}

			barChartData.datasets.push(newDataset);
			//window.myBar.update();
		}

		
		
		document.getElementById('addData').addEventListener('click', function() {
			if (barChartData.datasets.length > 0) {
				var month = MONTHS[barChartData.labels.length % MONTHS.length];
				barChartData.labels.push(month);

				for (var index = 0; index < barChartData.datasets.length; ++index) {
					// window.myBar.addData(randomScalingFactor(), index);
					barChartData.datasets[index].data.push(randomScalingFactor());
				}

				window.myBar.update();
			}
		});

		document.getElementById('removeDataset').addEventListener('click', function() {
			barChartData.datasets.pop();
			window.myBar.update();
		});

		document.getElementById('removeData').addEventListener('click', function() {
			barChartData.labels.splice(-1, 1); // remove the label first

			barChartData.datasets.forEach(function(dataset) {
				dataset.data.pop();
			});

			window.myBar.update();
		});
		
		
	</script>


<br><br>

</body>
</html>