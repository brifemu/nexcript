$(document).ready(function() {
	
  $('select').on('change', function() {
	  $("#rol").val() === "Programador" ? $("#form-username").css("display", "block") : $("#form-username").css("display", "none");
	  $("#rol").val() === "Programador" ? $("#form-lenguaje").css("display", "block") : $("#form-lenguaje").css("display", "none");
  });
  
  $("#registro-form").validate({
    rules: {
      mail : {
        required: true,
        email: true
      },
      password: {
        required: true,
        pwcheck: true
      },
      repassword: {
        required: true,
        equalTo: "#password"
      },
      username: {
    	required:true
      },
      nombre: {
        required: true
      },
      pais: {
          required: true
      },
      provincia: {
        required: true
      },
      ciudad: {
          required: true
      }    
    },
    messages : {
      mail: {
    	  required: "Campo requerido",
    	  email: "Debes insertar un correo válido"
      },
      password: {
          required: "Campo requerido",
          pwcheck: "La contraseña no cumple con los requisitos"
      },
      repassword: {
          required: "Campo requerido",
          equalTo: "Las contraseñas no coinciden"
      },
      username: {
    	  required: "Campo requerido"
      },
      nombre: {
    	  required: "Campo requerido"
      },
      pais: {
    	  required: "Campo requerido"
      },
      provincia: {
    	  required: "Campo requerido"
      },
      ciudad: {
    	  required: "Campo requerido"
      }
    }
  });
  
  $.validator.addMethod("pwcheck",
	  function(value, element) {
	  	const regexp = /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$/ ;
        return regexp.test(value);
  });
});