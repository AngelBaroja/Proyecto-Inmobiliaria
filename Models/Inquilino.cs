using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace Proyecto_Inmobiliaria.Models
{
    public class Inquilino
    {
        [Key]
        [Display(Name = "Código")]
        public int id { get; set; }
        [Required]
        public string Nombre { get; set; } = string.Empty;
        [Required]
        public string Apellido { get; set; } = string.Empty;
        [Required]
        public int DNI { get; set; }
        public string Telefono { get; set; } = string.Empty;
        [Required, EmailAddress]
        public string Email { get; set; } = string.Empty;
        [Required]
        public bool Estado { get; set; }
        
	}
}
