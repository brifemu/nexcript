		function PreviewImage() {
			var oFReader = new FileReader();
			oFReader.readAsDataURL(document.getElementById("foto").files[0]);
			
			oFReader.onload = function (oFREvent) {
				
				if(document.getElementById("foto").files[0].size > 5000000){
					alert('El archivo no debe superar los 5MB');
					document.getElementById("foto").value = '';
					document.getElementById("foto").name = '';
				} else {
				document.getElementById("preview").src = oFREvent.target.result;
				document.getElementById("fileName").textContent = document.getElementById("foto").files[0].name+" ("+(document.getElementById("foto").files[0].size / 1048576).toFixed(2)+" MB)";
				}
			};
		};
	    
	    function LimpiarImage() {
	        document.getElementById("foto").value= '';	
	        document.getElementById("preview").src = "";
	        document.getElementById("fileName").textContent = '';
	    };
	    