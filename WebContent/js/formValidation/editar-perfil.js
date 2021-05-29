$(document).ready(function() {
  if(window.location.hash != "") {
    $('a[href="' + window.location.hash + '"]').click()
  }

  $("#editar-perfil").validate({
    rules: {
      nombre: {
        required: true
      },
      username: {
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
      nombre: {
    	  required: "Campo requerido"
      },
      username: {
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
  
  $("#editar-correo").validate({
	    rules: {
	      newmail: {
	        required: true,
	        email: true
	      },
	      remail: {
	        required: true,
	        email: true,
	        equalTo: "#newmail"
	      },
	      password: {
	        required: true
	      },
	      repassword: {
	        required: true,
	        equalTo: "#password"
	      }  
	    },
	    messages : {
	      newmail: {
	    	  required: "Campo requerido",
	    	  email: "Formato de correo inválido"
	      },
	      remail: {
	    	  required: "Campo requerido",
	    	  email: "Formato de correo inválido",
	    	  equalTo: "Las cuentas de correo no coinciden"
	      },
	      password: {
	    	  required: "Campo requerido"
	      },
	      repassword: {
	    	  required: "Campo requerido",
	    	  equalTo: "Las contraseñas no coinciden"
	      }
	    }
	  });
  $("#editar-clave").validate({
	    rules: {
	      password: {
	        required: true
	      },
	      newpassword: {
	        required: true,
	        pwcheck: true
	      },
	      repassword: {
	        required: true,
	        equalTo: "#newpassword"
	      }  
	    },
	    messages : {
	      newpassword: {
		    required: "Campo requerido",
		  },
	      newpassword: {
	    	  required: "Campo requerido",
	    	  pwcheck: "La contraseña no cumple con los requisitos"
	      },
	      repassword: {
	    	  required: "Campo requerido",
	    	  equalTo: "Las contraseñas no coinciden"
	      }
	    }
	  });
  
    $.validator.addMethod("pwcheck",
		  function(value, element) {
		  	const regexp = /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$/ ;
	        return regexp.test(value);
	  });
});